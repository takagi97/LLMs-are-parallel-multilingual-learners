import jsonlines
import random
import json
import os

random.seed(42)

lang_set_for_xnli_infer = ["fr", "de", "zh", "ru"] # xnli inference

lang_set_for_train = ["fr", "de", "zh", "ru", "en"] # train

lang_aug = {
    "fr": ["es","ru","de"],
    "de": ["es","ru","fr"],
    "zh": ["es","fr","de"],
    "ru": ["es","fr","de"],
    "en": ["es","fr","de"]
}

lang_map = {
    "fr": "French",
    "de": "German",
    "zh": "Chinese",
    "ru": "Russian",
    "es": "Spanish",
    "en": "English"
}


def make_training_data_v2(num):
    training_data = []
    if num != -1: # num为-1会使用全部训练数据
        avail_ids = random.sample(all_ids, num)
    else:
        avail_ids = all_ids
    for id in avail_ids:
        lang = random.sample(lang_set_for_train, 1)[0]
        if random.uniform(0, 1) < 1/8: # 按照1/3的比例不使用多语言增强
            jsonline = make_a_piece_of_data_single_language(lang, str(id))
        else: # 按照2/3的比例使用多语言增强
            jsonline = make_a_piece_of_data_multiple_languages_v2(lang, str(id))
        training_data.append(jsonline)
    return training_data

def make_a_piece_of_data_single_language(main_lang, id):
    # prompt = 'You will be presented with a pair of sentences. Your task is to determine the relationship between these two sentences. There are three possible relationships: entailment, contradiction, or neutral. \'Entailment\' means the first sentence logically implies the second one. \'Contradiction\' means the first sentence logically conflicts with the second one. \'Neutral\' means neither entailment nor contradiction holds between the sentences. Please provide a single prediction for the relationship based on these sentence pairs, without any explanation. Here is the sentence pair:\nPremise: #sen1#\nHypothesis: #sen2#\nYour prediction:'
    prompt = 'You will be presented with a pair of sentences. Your task is to determine the relationship between these two sentences. There are three possible relationships: entailment, contradiction, or neutral. Please provide a single prediction for the relationship based on these sentence pairs, without any explanation. Here is the sentence pair:\nPremise: #sen1#\nHypothesis: #sen2#\nYour prediction:'
    prompt = prompt.replace("#sen1#", xnli_dataset[main_lang+id]["sentence1"])
    prompt = prompt.replace("#sen2#", xnli_dataset[main_lang+id]["sentence2"])
    return {"instruction": prompt, "input": "", "output": xnli_dataset[main_lang+id]["gold_label"], "history": []} # "type": f"single-{main_lang}", 

def make_a_piece_of_data_multiple_languages(main_lang, id):
    # prompt = 'You will be provided with a set of sentence pairs that are semantically identical but presented in four different languages: #lang_seq#. Each pair consists of a premise and a hypothesis. Despite the language differences, the meaning of these sentences is the same across all languages. Your task is to analyze these sentence pairs and determine the relationship between the premise and the hypothesis. There are three possible relationships: entailment, contradiction, or neutral. \'Entailment\' means the first sentence logically implies the second one. \'Contradiction\' means the first sentence logically conflicts with the second one. \'Neutral\' means neither entailment nor contradiction holds between the sentences. Please provide a single prediction for the relationship based on these sentence pairs, without any explanation. Here are the sentence pairs:\n\n#sentence_pair#Your prediction:'
    prompt = 'You will be provided with a set of sentence pairs that are semantically identical but presented in four different languages: #lang_seq#. Each pair consists of a premise and a hypothesis. Your task is to analyze these sentence pairs and determine the relationship between the premise and the hypothesis. There are three possible relationships: entailment, contradiction, or neutral. Please provide a single prediction for the relationship based on these sentence pairs, without any explanation. Here are the sentence pairs:\n\n#sentence_pair#Your prediction:'
    lang_seq = lang_map[main_lang] + ", "
    sentence_pair = lang_map[main_lang] + ":\nPremise: " + xnli_dataset[main_lang+id]["sentence1"] + "\nHypothesis: " + xnli_dataset[main_lang+id]["sentence2"] + "\n\n"
    for mid_lang in lang_aug[main_lang]:
        lang_seq += lang_map[mid_lang] + ", "
        sentence_pair += lang_map[mid_lang] + ":\nPremise: " + xnli_dataset[mid_lang+id]["sentence1"] + "\nHypothesis: " + xnli_dataset[mid_lang+id]["sentence2"] + "\n\n"
    lang_seq = lang_seq.strip(", ")
    prompt = prompt.replace("#lang_seq#", lang_seq)
    prompt = prompt.replace("#sentence_pair#", sentence_pair)
    return {"instruction": prompt, "input": "", "output": xnli_dataset[main_lang+id]["gold_label"], "history": []}

def make_a_piece_of_data_multiple_languages_v2(main_lang, id):
    # prompt = "You will be given a premise in multiple languages (#lang_seq#) and a hypothesis in #main_lang#. Despite the language differences, the meaning of these sentences is the same across all languages. Your task is to determine the relationship between the multilingual premises and the #main_lang# hypothesis. There are three possible relationships: entailment, contradiction, or neutral. 'Entailment' means the premises logically imply the hypothesis. 'Contradiction' means the premises logically conflict with the hypothesis. 'Neutral' means neither entailment nor contradiction holds between the premises and the hypothesis. Please provide a single prediction for the relationship, without any explanation. Here are the premises and the hypothesis:\n\n#sentence_pair#Your prediction:"
    prompt = "You will be given a premise in multiple languages (#lang_seq#) and a hypothesis in #main_lang#. Your task is to determine the relationship between the multilingual premises and the #main_lang# hypothesis. There are three possible relationships: entailment, contradiction, or neutral. Please provide a single prediction for the relationship, without any explanation. Here are the premises and the hypothesis:\n\n#sentence_pair#Your prediction:"
    lang_seq = lang_map[main_lang] + ", "
    sentence_pair = lang_map[main_lang] + " Premise: " + xnli_dataset[main_lang+id]["sentence1"] + "\n"
    for mid_lang in lang_aug[main_lang]:
        lang_seq += lang_map[mid_lang] + ", "
        sentence_pair += lang_map[mid_lang] + " Premise: " + xnli_dataset[mid_lang+id]["sentence1"] + "\n"
    lang_seq = lang_seq.strip(", ")
    sentence_pair += "\nHypothesis: " + xnli_dataset[main_lang+id]["sentence2"] + "\n\n"
    prompt = prompt.replace("#lang_seq#", lang_seq)
    prompt = prompt.replace("#sentence_pair#", sentence_pair)
    prompt = prompt.replace("#main_lang#", lang_map[main_lang])
    return {"instruction": prompt, "input": "", "output": xnli_dataset[main_lang+id]["gold_label"], "history": []} # "type": f"multiple-{main_lang}", 

def make_inference_data_single_language(lang):
    inference_data = []
    avail_ids = all_ids
    for id in avail_ids:
        jsonline = make_a_piece_of_data_single_language(lang, str(id))
        inference_data.append(jsonline)
    return inference_data

def make_inference_data_multiple_languages(lang):
    inference_data = []
    avail_ids = all_ids
    for id in avail_ids:
        jsonline = make_a_piece_of_data_multiple_languages(lang, str(id))
        inference_data.append(jsonline)
    return inference_data

def make_inference_data_multiple_languages_v2(lang):
    inference_data = []
    avail_ids = all_ids
    for id in avail_ids:
        jsonline = make_a_piece_of_data_multiple_languages_v2(lang, str(id))
        inference_data.append(jsonline)
    return inference_data

def read_test_set(lang, test_set_path, translation_path):
# 构造一个虚假的xnli_dataset实现代码复用
    xnli_dataset = {}
    all_ids = []
    test_file1 = open(os.path.join(test_set_path, f"xnli.{lang}.premise.txt"), mode='r')
    test_file2 = open(os.path.join(test_set_path, f"xnli.{lang}.hypothesis.txt"), mode='r')
    test_file3 = open(os.path.join(test_set_path, f"xnli.{lang}.label.txt"), mode='r')
    idx = 0
    for tp, th, tl in zip(test_file1.readlines(), test_file2.readlines(), test_file3.readlines()):
        xnli_dataset[lang+str(idx)] = {"sentence1":tp.strip(), "sentence2":th.strip(), "gold_label":tl.strip()}
        all_ids.append(str(idx))
        idx += 1
    
    for lang2 in lang_aug[lang]:
        translation_file1 = open(os.path.join(translation_path, f"xnli.{lang}.premise.txt-{lang2}", "result.txt"), mode='r')
        translation_file2 = open(os.path.join(translation_path, f"xnli.{lang}.hypothesis.txt-{lang2}", "result.txt"), mode='r')
        translation_file1.seek(0)
        translation_file2.seek(0)
        test_file3.seek(0)
        idx = 0
        for tp, th, tl in zip(translation_file1.readlines(), translation_file2.readlines(), test_file3.readlines()):
            xnli_dataset[lang2+str(idx)] = {"sentence1":tp.strip(), "sentence2":th.strip(), "gold_label":tl.strip()}
            idx += 1
        translation_file1.close()
        translation_file2.close()
    test_file1.close()
    test_file2.close()
    test_file3.close()
    return xnli_dataset, all_ids

    
if __name__=="__main__":
    # 此脚本用来造训练数据、推断数据 lef格式

    # make training file
    xnli_dataset = {} # en#NUM
    all_ids = []
    with jsonlines.open("/mnt/muyongyu/fpn/multi_lang/myy_files/NLU/XNLI/xnli.dev.jsonl", mode='r') as reader:
        for row in reader:
            xnli_dataset[row["language"]+row["pairID"]] = row
            all_ids.append(row["pairID"])
    all_ids = set(all_ids)
    with open("/mnt/muyongyu/fpn/multi_lang/myy_files/NLU/XNLI/train_file/12.12/xnli-train_all-only_sent1_b1m7.json", mode='w') as writer:
        training_data = make_training_data_v2(-1) # 使用全部训练数据（dev）2490条
        training_data = json.dumps(training_data, ensure_ascii=False)
        writer.write(training_data)

    
    # # make inference files
    # for lang in lang_set_for_xnli_infer:
    #     xnli_dataset, all_ids = read_test_set(lang, "/mnt/muyongyu/fpn/multi_lang/myy_files/NLU/XNLI/xnli_extract", "/mnt/muyongyu/fpn/multi_lang/myy_files/NLU/XNLI/chatgpt_translation")
    #     with open(f"/mnt/muyongyu/fpn/multi_lang/myy_files/NLU/XNLI/infer_file/12.10/xnli_{lang}_single.json", mode='w') as writer:
    #         inference_data = make_inference_data_single_language(lang)
    #         inference_data = json.dumps(inference_data, ensure_ascii=False)
    #         writer.write(inference_data)
    #     for lang2 in lang_aug[lang]:
    #         with open(f"/mnt/muyongyu/fpn/multi_lang/myy_files/NLU/XNLI/infer_file/12.10/xnli_{lang}_single_{lang2}.json", mode='w') as writer:
    #             inference_data = make_inference_data_single_language(lang2)
    #             inference_data = json.dumps(inference_data, ensure_ascii=False)
    #             writer.write(inference_data)
    #     # with open("/mnt/muyongyu/fpn/multi_lang/myy_files/NLU/XNLI/infer_file/xnli_{lang}_mlp.json", mode='w') as writer:
    #     #     inference_data = make_inference_data_multiple_languages(lang)
    #     #     inference_data = json.dumps(inference_data, ensure_ascii=False)
    #     #     writer.write(inference_data)
    #     with open(f"/mnt/muyongyu/fpn/multi_lang/myy_files/NLU/XNLI/infer_file/12.10/xnli_{lang}_mlp-only_sent1.json", mode='w') as writer:
    #         inference_data = make_inference_data_multiple_languages_v2(lang)
    #         inference_data = json.dumps(inference_data, ensure_ascii=False)
    #         writer.write(inference_data)

    # # make inference files WO json!
    # for lang in lang_set_for_xnli_infer:
    #     xnli_dataset, all_ids = read_test_set(lang, "/mnt/muyongyu/fpn/multi_lang/myy_files/NLU/XNLI/xnli_extract", "/mnt/muyongyu/fpn/multi_lang/myy_files/NLU/XNLI/chatgpt_translation")
    #     with open(f"/mnt/muyongyu/fpn/multi_lang/myy_files/NLU/XNLI/infer_file/12.9/xnli_{lang}_single.txt", mode='w') as writer:
    #         inference_data = make_inference_data_single_language(lang)
    #         for line in inference_data:
    #             writer.write(line["instruction"].replace("\n", "\\n")+"\n")
    #     for lang2 in lang_aug[lang]:
    #         with open(f"/mnt/muyongyu/fpn/multi_lang/myy_files/NLU/XNLI/infer_file/12.9/xnli_{lang}_single_{lang2}.txt", mode='w') as writer:
    #             inference_data = make_inference_data_single_language(lang2)
    #             for line in inference_data:
    #                 writer.write(line["instruction"].replace("\n", "\\n")+"\n")
    #     # with open(f"/mnt/muyongyu/fpn/multi_lang/myy_files/NLU/XNLI/infer_file/12.9/xnli_{lang}_mlp.txt", mode='w') as writer:
    #     #     inference_data = make_inference_data_multiple_languages(lang)
    #     #     for line in inference_data:
    #     #         writer.write(line["instruction"].replace("\n", "\\n")+"\n")
    #     with open(f"/mnt/muyongyu/fpn/multi_lang/myy_files/NLU/XNLI/infer_file/12.9/xnli_{lang}_mlp-only_sent1.txt", mode='w') as writer:
    #         inference_data = make_inference_data_multiple_languages_v2(lang)
    #         for line in inference_data:
    #             writer.write(line["instruction"].replace("\n", "\\n")+"\n")