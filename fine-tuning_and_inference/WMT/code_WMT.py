import os
import random
import tqdm
import argparse
from request_chatgpt import make_requests
import tiktoken
import time

random.seed(42)

'''
code prompt fewshot (5) on WMT22 with demonstrations from WMT21
'''

prompt_v1 = '''Tell me only in ###target_language###. ###shot_n_text###[###source_language###]=[###input###][###target_language###]='''

prompt_v2 = '''###shot_n_text###\nGiven the ###source_language### sentence: ###input###\nthe ###target_language### translation of the sentence is:'''

prompt_v3 = '''###shot_n_text###\nTranslate this into 1. ###target_language###:\n###input###\n1.'''

prompt_v8 = '''###shot_n_text###Translate into ###target_language###.\\n###source_language###: ###input###\\n###target_language###:''' # same to MLP v6

def encode_prompt(source_language, target_language, shot_n, input, prompt_version=1):
    """Encode multiple prompt sentences into a single string."""
    shot_n_text = ""
    if prompt_version == 1:
        prompt = prompt_v1
        for shot in shot_n:
            shot_n_text += f'''[{source_language}]=[{shot["src"]}][{target_language}]=[{shot["tgt"]}]'''
    elif prompt_version == 2:
        prompt = prompt_v2
        for shot in shot_n:
            shot_n_text += f'''Given the ###source_language### sentence: {shot["src"]}\nthe ###target_language### translation of the sentence is: {shot["tgt"]}'''
    elif prompt_version == 3:
        prompt = prompt_v3
        for shot in shot_n:
            shot_n_text += f'''Translate this into 1. ###target_language###:\n{shot["src"]}\n1. {shot["tgt"]}'''
    elif prompt_version == 8:
        prompt = prompt_v8
        for shot in shot_n:
            shot_n_text += '''Translate into ###target_language###.\\n'''
            shot_n_text += f'''{source_language}: {shot["src"]}\\n{target_language}: {shot["tgt"]}\\n'''
            shot_n_text += '''\\n'''
    else:
        print(f"There are only 2 versions of the prompt")
        exit(0)

    prompt = prompt.replace("###shot_n_text###", shot_n_text)
    prompt = prompt.replace("###source_language###", source_language)
    prompt = prompt.replace("###target_language###", target_language)
    prompt = prompt.replace("###input###", input.strip())

    return {"role": "user", "content": prompt}


def num_tokens_of_string(string: str, encoding_name="cl100k_base"):
    """Returns the number of tokens in a text string."""
    tokenizer = tiktoken.get_encoding(encoding_name)
    return len(tokenizer.encode(string))


def post_process_response(response):
    response = response.replace("\n", "").strip("=").strip("[").strip("]").strip()
    return response


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--result_data_path",
        type=str,
        required=True,
        help="The directory where the result is stored.",
    )

    # Must be set
    parser.add_argument(
        "--wmt22_data_path",
        type=str,
        default="wmt22-news-systems/txt",
        help="The path to the WMT22.",
    )
    parser.add_argument(
        "--flores200_data_path",
        type=str,
        default="flores200_dataset",
        help="The path to the Flores-200.",
    )

    parser.add_argument(
        "--lang_para",
        type=str,
        required=True,
        help="English_#_en_###_German_#_de",
    )
    parser.add_argument(
        "--lang_para_flores",
        type=str,
        required=True,
        default="German_#_deu_Latn_###_English_#_eng_Latn",
        help="src_lang1_#_src_file1_##_src_lang2_#_src_file2_###_tgt_lang1_#_tgt_file1",
    )
    parser.add_argument(
        "--shot_n",
        type=int,
        default=1,
        help="the number of demonstrations",
    )
    parser.add_argument(
        "--engine",
        type=str,
        default="gpt-4",
        help="The engine to use."
    )
    parser.add_argument(
        "--prompt_version",
        type=int,
        default=2,
        help="Which version of prompt you would like to use",
    )
    parser.add_argument(
        "--max_input_tokens",
        type=int,
        default=2500,
        help="max number of the input prompt",
    )
    parser.add_argument(
        "--decoding_temperature",
        type=float,
        default=0,
        help="temperature"
    )
    parser.add_argument(
        "--TopP",
        type=float,
        default=1,
        help="TopP"
    )
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()    

    lang_para = args.lang_para
    src_lang = lang_para.split("_###_")[0].split("_#_")[0] # German
    src_file = lang_para.split("_###_")[0].split("_#_")[1] # de
    tgt_lang = lang_para.split("_###_")[1].split("_#_")[0] # English
    tgt_file = lang_para.split("_###_")[1].split("_#_")[1] # en

    lang_para_flores = args.lang_para_flores
    src_lang_flores = lang_para_flores.split("_###_")[0].split("_#_")[0]
    src_file_flores = lang_para_flores.split("_###_")[0].split("_#_")[1]
    tgt_lang_flores = lang_para_flores.split("_###_")[1].split("_#_")[0]
    tgt_file_flores = lang_para_flores.split("_###_")[1].split("_#_")[1]

    src_sents = []
    with open(os.path.join(args.wmt22_data_path, "sources", f"generaltest2022.{src_file}-{tgt_file}.src.{src_file}"), "r") as fin:
        for line in fin:
            line = line.strip()
            src_sents.append(line)
    print(f"Loaded {len(src_sents)} pieces of source data")

    shot_sents = []
    with open(os.path.join(args.flores200_data_path, "dev", src_file_flores+".dev"), "r") as fin_src:
        with open(os.path.join(args.flores200_data_path, "dev", tgt_file_flores+".dev"), "r") as fin_tgt:
            for src_line, tgt_line in zip(fin_src, fin_tgt):
                src_line = src_line.strip()
                tgt_line = tgt_line.strip()
                shot_sents.append({"src":src_line, "tgt":tgt_line})
    print(f"Loaded {len(shot_sents)} pieces of shot data")
    shots = random.sample(shot_sents, args.shot_n)

    # load the LM-generated sentences
    os.makedirs(args.result_data_path, exist_ok=True)
    machine_data = []
    if os.path.exists(os.path.join(args.result_data_path, "result.txt")):
        with open(os.path.join(args.result_data_path, "result.txt"), "r") as fin:
            for line in fin:
                line = line.strip()
                machine_data.append(line)
        print(f"Loaded {len(machine_data)} pieces of machine-generated data")
    

    # now let's generate new sentences!
    progress_bar = tqdm.tqdm(total=len(src_sents))
    if machine_data:
        progress_bar.update(len(machine_data))
    with open(os.path.join(args.result_data_path, "result.txt"), "a", encoding='utf-8') as fout:
        with open(os.path.join(args.result_data_path, "prompt.txt"), "a", encoding='utf-8') as fout_prompt:
            while len(machine_data) < len(src_sents):
                prompt = encode_prompt(src_lang, tgt_lang, shots, src_sents[len(machine_data)], prompt_version=args.prompt_version)

                fout_prompt.write(prompt["content"].replace("\n", "\\n") + "\n")
                prompt["content"] = prompt["content"].replace("\\n", "\n")
                if num_tokens_of_string(prompt["content"]) <= args.max_input_tokens:
                    # result = "Only prompt no request" # Commenting out the next line and uncommenting this line enables this script to only records the prompts!
                    result = make_requests(
                        engine=args.engine,
                        prompts=[prompt],
                        max_tokens=(4000 - args.max_input_tokens),
                        temperature=args.decoding_temperature,
                        top_p=args.TopP,
                        frequency_penalty=0,
                        presence_penalty=2,
                        stop_sequences=["\n\n"]
                        )[0]["response"]["choices"][0]["message"]["content"]
                else:
                    result = "###over length!!!"

                result = post_process_response(result)
                machine_data.append(result)
                fout.write(result + "\n")
                progress_bar.update(1)

            print("finish!")
