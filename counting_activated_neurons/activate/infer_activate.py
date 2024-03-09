# pip install -q transformers accelerate
from transformers import AutoModelForCausalLM, AutoTokenizer
import sys
import os
from tqdm import tqdm
import jsonlines

os.environ['CUDA_VISIBLE_DEVICES']=""
checkpoint = ""

file_name = ""
input_file = f"{file_name}.txt"
activate_proportion_file = f"{file_name}-proportion-{checkpoint}.jsonl"
activate_index_file = f"{file_name}-index-{checkpoint}.jsonl"
output_file = f"{file_name}-result-{checkpoint}.txt"
sys_prompt_flag = False
sys_prompt = "<|im_start|>system\nYou are a helpful assistant.<|im_end|>\n<|im_start|>user\n<|custom|><|im_end|>\n<|im_start|>assistant\n"
interactivate_flag = False

count = 0
tokenizer = AutoTokenizer.from_pretrained(checkpoint)
model = AutoModelForCausalLM.from_pretrained(checkpoint, torch_dtype="auto", device_map="auto", activate_file=[activate_proportion_file, activate_index_file])

def Infer(text):
    inputs = tokenizer.encode(text, return_tensors="pt").to("cuda")
    outputs = model.generate(inputs, max_new_tokens=100, do_sample=True, temperature=0.01)

    sentence_activate_index_dict = {}
    with jsonlines.open(activate_index_file, mode='r') as reader:
        for row in reader:
            for layer in range(len(row)):
                if str(layer) not in sentence_activate_index_dict:
                    sentence_activate_index_dict[str(layer)] = row[str(layer)]
                else:
                    sentence_activate_index_dict[str(layer)] = [sentence_activate_index_dict[str(layer)][i] + row[str(layer)][i] for i in range(len(row[str(layer)]))]
    with jsonlines.open(activate_index_file, mode='w') as writer:
        writer.write(sentence_activate_index_dict)
    return tokenizer.decode(outputs[0])

def InterActivate():
    while True:
        print("########## ready ##########")
        input_text = input()
        output_text = Infer(input_text)
        print(output_text)


def ReadFile(input_file, row):
    with open(input_file, mode='r', encoding='UTF-8') as f:
        lines = f.readlines()
        tmp_row = 0
        for line in tqdm(lines):
            if tmp_row >= row:
                line = line[:-1]
                line = line.replace("\\n","\n").strip()
                if sys_prompt_flag is True:
                    line = sys_prompt.replace("<|custom|>", line)
                print(line)
                output_text = Infer(line)
                print(output_text)
                with open(output_file, 'a+', encoding='utf-8') as writer:
                    writer.write(output_text.replace('<pad> ','').replace('</s>','').replace('\n','\\n')+'\n')
                print(f"{tmp_row} is infer finished")
            tmp_row += 1

if count == 0:
    if os.path.exists(activate_index_file):
        print("the file already exit, please check!!!")
        exit(0)

    with open(activate_proportion_file, 'w') as f:
        pass
    with open(activate_index_file, 'w') as f:
        pass

if interactivate_flag:
    InterActivate()
else:
    ReadFile(input_file, count)
