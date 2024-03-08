import sys
import jsonlines
input_file = ''

file_activate_dict = {}
sentence_activate_dict = {}
count = 0
layer_num = 0
with jsonlines.open(input_file, mode='r') as reader:
    for row in reader:
        count += 1
        layer_num = len(row)
        for layer in range(len(row)):
            if str(layer)+"eq" not in sentence_activate_dict:
                sentence_activate_dict[str(layer)+"eq"] = row[str(layer)][0]
                sentence_activate_dict[str(layer)+"le"] = row[str(layer)][1]
            else:
                sentence_activate_dict[str(layer)+"eq"] += row[str(layer)][0]
                sentence_activate_dict[str(layer)+"le"] += row[str(layer)][1]

total_activate_dict = sentence_activate_dict

avg_activate_dict = {}
all_layer_eq = 0
all_layer_le = 0
all_layer_l = 0
for layer in range(layer_num):
    avg_activate_dict[str(layer)] = [total_activate_dict[str(layer)+"eq"]/count, total_activate_dict[str(layer)+"le"]/count]
    print("layer", layer)
    print("eq zero", total_activate_dict[str(layer)+"eq"]/count)
    print("l  zero", total_activate_dict[str(layer)+"le"]/count - total_activate_dict[str(layer)+"eq"]/count)
    print("le zero（the proportion of suppressed neurons）", total_activate_dict[str(layer)+"le"]/count)
    all_layer_eq += total_activate_dict[str(layer)+"eq"]/count
    all_layer_le += total_activate_dict[str(layer)+"le"]/count
    all_layer_l += total_activate_dict[str(layer)+"le"]/count - total_activate_dict[str(layer)+"eq"]/count

print("all layer eq zero", all_layer_eq/layer_num)
print("all layer l zero", all_layer_l/layer_num)
print("all layer le zero（the proportion of suppressed neurons）", all_layer_le/layer_num)
