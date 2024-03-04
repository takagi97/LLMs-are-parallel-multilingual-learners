import os
import tqdm
import argparse
from request_chatgpt_myy import make_requests
from request_chatgpt_myy import key_generator_f
import tiktoken
import re

keys = [
    "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"
]

'''
code prompt multi-lang input on flores-200
'''
prompt_v3 = '''###fewshot_text######current_text###'''

prompt_v8 = '''###fewshot_text######current_text######target_language###:'''

prompt_v9 = '''###fewshot_text######current_text######target_language###:'''

def encode_prompt(source_language, target_language, fewshot, mid_languages, prompt_version=1):
    """Encode multiple prompt sentences into a single string."""
    fewshot_text = ""
    current_text = ""
    if prompt_version == 8:
        prompt = prompt_v8
        if fewshot != None:
            for shot in fewshot:
                fewshot_text += '''Translate into ###target_language###.\\n'''
                for language in shot:
                    fewshot_text += f'''{language[0]}: {language[1]}\\n'''
                fewshot_text += '''\\n'''
        current_text += '''Translate into ###target_language###.\\n'''
        for language in mid_languages:
            current_text += f'''{language[0]}: {language[1]}\\n'''
    elif prompt_version == 9:
        prompt = prompt_v9
        if fewshot != None:
            for shot in fewshot:
                fewshot_text += '''Translate into ###target_language###. Note that only the first sentence represents the true source language (i.e., ###source_language###). Your output should be semantically equivalent to it. The subsequent sentences are results of neural machine translation, provided to enhance your understanding of the source language from the perspectives of other languages. Please provide the highest quality translation of the sentence.\\n'''
                for language in shot:
                    fewshot_text += f'''{language[0]}: {language[1]}\\n'''
                fewshot_text += '''\\n'''
        current_text += '''Translate into ###target_language###. Note that only the first sentence represents the true source language (i.e., ###source_language###). Your output should be semantically equivalent to it. The subsequent sentences are results of neural machine translation, provided to enhance your understanding of the source language from the perspectives of other languages. Please provide the highest quality translation of the sentence.\\n'''
        for language in mid_languages:
            current_text += f'''{language[0]}: {language[1]}\\n'''
    elif prompt_version == 3:
        prompt = prompt_v3
        if fewshot != None:
            for shot in fewshot:
                fewshot_text += '''Translate this into 1. ###target_language###.\\n'''
                for language in shot:
                    if language != shot[-1]:
                        fewshot_text += f'''{language[0]}: {language[1]}\\n'''
                    else:
                        fewshot_text += f'''1. {language[1]}\\n'''
                fewshot_text += '''\\n'''
        current_text += '''Translate this into 1. ###target_language###.\\n'''
        for language in mid_languages:
            current_text += f'''{language[0]}: {language[1]}\\n'''
        current_text += '''1.'''
    else:
        print(f"There are only 2 versions of the prompt")
        exit(0)

    prompt = prompt.replace("###fewshot_text###", fewshot_text)
    prompt = prompt.replace("###current_text###", current_text)
    prompt = prompt.replace("###source_language###", source_language)
    prompt = prompt.replace("###target_language###", target_language)

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
    parser.add_argument(
        "--wmt22_data_path",
        type=str,
        # default="/mnt/muyongyu/fpn/multi_lang/gpt-MT/evaluation/testset/wmt-testset",
        default="/mnt/muyongyu/fpn/multi_lang/wmt22-news-systems/txt",
        help="The path to the WMT22.",
    )
    parser.add_argument(
        "--flores200_data_path",
        type=str,
        default="/mnt/muyongyu/fpn/multi_lang/flores200_dataset",
        help="The path to the Flores-200.",
    )
    parser.add_argument(
        "--nmt_data_path",
        type=str,
        default="/mnt/muyongyu/fpn/multi_lang/myy_files/results/GPT4",
        help="The path to the NMT translations.",
    )
    parser.add_argument(
        "--flores_src_files",
        type=str,
        required=True,
        help="eng_Latn_#_ita_Latn_#_fra_Latn_#_spa_Latn",
    )
    parser.add_argument(
        "--flores_tgt_file",
        type=str,
        required=True,
        help="eng_Latn",
    )
    parser.add_argument(
        "--source_languages",
        type=str,
        required=True,
        help="English_#_Italian_#_French_#_Spanish",
    )
    parser.add_argument(
        "--target_language",
        type=str,
        required=True,
        help="German",
    )
    parser.add_argument(
        "--source_lang_abb_flores",
        type=str,
        required=True,
        help="eng_#_ita_#_fra_#_spa",
    )
    parser.add_argument(
        "--target_lang_abb_flores",
        type=str,
        required=True,
        help="deu",
    )
    parser.add_argument(
        "--source_lang_abb_wmt22",
        type=str,
        required=True,
        help="en_#_it_#_fr_#_es",
    )
    parser.add_argument(
        "--target_lang_abb_wmt22",
        type=str,
        required=True,
        help="de",
    )
    parser.add_argument(
        "--engine",
        type=str,
        default="gpt-3.5-turbo-0613",
        help="The engine to use."
    )
    parser.add_argument(
        "--prompt_version",
        type=int,
        default=1,
        help="Which version of prompt you would like to use",
    )
    parser.add_argument(
        "--nshot",
        type=int,
        default=0,
        help="n shot?",
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

    flores_src_files = args.flores_src_files.split("_#_")
    flores_tgt_file = args.flores_tgt_file
    source_languages = args.source_languages.split("_#_")
    target_language = args.target_language
    source_lang_abb_flores = args.source_lang_abb_flores.split("_#_")
    target_lang_abb_flores = args.target_lang_abb_flores
    source_lang_abb_wmt22 = args.source_lang_abb_wmt22.split("_#_")
    target_lang_abb_wmt22 = args.target_lang_abb_wmt22
    

    fewshot = None
    fewshot_row_list = [4,12,137,36,65]
    if args.nshot > 0:
        fewshot = []
        fewshot_row_list = fewshot_row_list[0:args.nshot]
        with open(os.path.join(args.flores200_data_path, "dev", flores_src_files[0]+".dev"), "r") as fin_s1:
            with open(os.path.join(args.flores200_data_path, "dev", flores_src_files[1]+".dev"), "r") as fin_s2:
                with open(os.path.join(args.flores200_data_path, "dev", flores_src_files[2]+".dev"), "r") as fin_s3:
                    with open(os.path.join(args.flores200_data_path, "dev", flores_src_files[3]+".dev"), "r") as fin_s4:
                        with open(os.path.join(args.flores200_data_path, "dev", flores_tgt_file+".dev"), "r") as fin_t:
                            line_num = 0
                            for line_s1, line_s2, line_s3, line_s4, line_t in zip(fin_s1, fin_s2, fin_s3, fin_s4, fin_t):
                                if line_num in fewshot_row_list:
                                    fewshot.append([[source_languages[0],line_s1.strip()], [source_languages[1],line_s2.strip()], [source_languages[2],line_s3.strip()], [source_languages[3],line_s4.strip()], [target_language,line_t.strip()]])
                                line_num += 1

    shots = []
    with open(os.path.join(args.wmt22_data_path, "sources", f"generaltest2022.{source_lang_abb_wmt22[0]}-{target_lang_abb_wmt22}.src.{source_lang_abb_wmt22[0]}"), "r") as fin_s1:
    # with open(os.path.join("/mnt/muyongyu/fpn/multi_lang/wmt21-news-systems/txt/sources", f"newstest2021.{source_lang_abb_wmt22[0]}-{target_lang_abb_wmt22}.src.{source_lang_abb_wmt22[0]}"), "r") as fin_s1:
        with open(os.path.join(args.nmt_data_path, source_lang_abb_wmt22[0]+"2"+target_lang_abb_wmt22, "wmt22-"+source_lang_abb_flores[0]+"2"+source_lang_abb_flores[1]+"-1shot-baseline_vhendy", "result.txt"), "r") as fin_s2:
            with open(os.path.join(args.nmt_data_path, source_lang_abb_wmt22[0]+"2"+target_lang_abb_wmt22, "wmt22-"+source_lang_abb_flores[0]+"2"+source_lang_abb_flores[2]+"-1shot-baseline_vhendy", "result.txt"), "r") as fin_s3:
                with open(os.path.join(args.nmt_data_path, source_lang_abb_wmt22[0]+"2"+target_lang_abb_wmt22, "wmt22-"+source_lang_abb_flores[0]+"2"+source_lang_abb_flores[3]+"-1shot-baseline_vhendy", "result.txt"), "r") as fin_s4:
                    for line_s1, line_s2, line_s3, line_s4 in zip(fin_s1, fin_s2, fin_s3, fin_s4):
                        tmp_dict = [[source_languages[0],line_s1.strip()], [source_languages[1],line_s2.strip()], [source_languages[2],line_s3.strip()], [source_languages[3],line_s4.strip()]]
                        shots.append(tmp_dict)
    print(f"Loaded {len(shots)} pieces of source data")

    # load the LM-generated sentences
    os.makedirs(args.result_data_path, exist_ok=True)
    machine_data = []
    if os.path.exists(os.path.join(args.result_data_path, f"result.txt")):
        with open(os.path.join(args.result_data_path, f"result.txt"), "r") as fin:
            for line in fin:
                line = line.strip()
                machine_data.append(line)
        print(f"Loaded {len(machine_data)} pieces of machine-generated data")
    

    # now let's generate new sentences!
    progress_bar = tqdm.tqdm(total=len(shots))
    key_generator = key_generator_f(keys, 999999999)
    if machine_data:
        progress_bar.update(len(machine_data))
    with open(os.path.join(args.result_data_path, "result.txt"), "a", encoding='utf-8') as fout_t1:
        with open(os.path.join(args.result_data_path, "prompt.txt"), "a", encoding='utf-8') as fout_prompt:
            while len(machine_data) < len(shots):
                prompt = encode_prompt(source_languages[0], target_language, fewshot, shots[len(machine_data)], prompt_version=args.prompt_version)

                # print(prompt)
                # exit(0)

                fout_prompt.write(prompt["content"].replace("\n", "\\n") + "\n")
                prompt["content"] = prompt["content"].replace("\\n", "\n")
                if num_tokens_of_string(prompt["content"]) <= args.max_input_tokens:
                    # result = "Only prompt no request"
                    result = make_requests(
                        key_generator=key_generator,
                        engine=args.engine,
                        prompts=[prompt],
                        max_tokens=(4000 - args.max_input_tokens),
                        temperature=args.decoding_temperature,
                        top_p=args.TopP,
                        frequency_penalty=0,
                        presence_penalty=2,
                        stop_sequences=["\n\n"]
                        )[0]["response"]["choices"][0]["message"]["content"] # ["text"]
                else:
                    result = "###over length!!!"

                response = post_process_response(result)
                machine_data.append(response)
                fout_t1.write(response + "\n")
                progress_bar.update(1)

            print("finish!")
