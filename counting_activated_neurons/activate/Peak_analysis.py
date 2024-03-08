import numpy as np
import matplotlib as mpl
from matplotlib import pyplot as plt
import mpl_toolkits.axisartist as axisartist
import os
import jsonlines

os.environ["KMP_DUPLICATE_LIB_OK"]="TRUE"
mpl.rcParams['font.family'] = 'STKAITI'

file_list = [] # the list of input file
select_proportion = 1 # the proportion of selected neuron

color_list = ["c", "r", "b", "g", "y", "m"]
layer_num = 0
data_list_all = []

for file in file_list:
    data_list = []
    with jsonlines.open(file, mode='r') as reader:
        for row in reader:
            layer_num = len(row)
            for layer in range(len(row)):
                for index in range(len(row[str(layer)])):
                    data_list.append((layer, index, row[str(layer)][index]))

    data_list_sort = sorted(data_list, key=lambda x: (-x[2], x[0], x[1]))
    data_len = len(data_list_sort)
    data_list_sort_sub = data_list_sort[ : int(data_len*select_proportion)]
    data_list_all.append(data_list_sort_sub)

fig = plt.figure()

ax_1 = axisartist.Subplot(fig, 211)
fig.add_axes(ax_1)
for i in range(len(data_list_all)):
    data_list_sort_sub = data_list_all[i]
    ax_1_x=[]
    ax_1_y=[]
    for id in range(len(data_list_sort_sub)):
        if data_list_sort_sub[id][2] > 0:
            ax_1_x.append(id)
            ax_1_y.append(data_list_sort_sub[id][2])
    plt.plot(np.array(ax_1_x), np.array(ax_1_y), c=color_list[i], label=file_list[i])
plt.axis([0, len(data_list_all[0]) * 1.01, data_list_all[-1][-1][2] * 0.9, data_list_all[-1][0][2] * 1.1])
plt.ylabel(f'#Times Being Activated', fontsize=5)
plt.title(f'top{select_proportion} neurons', fontsize=8)
plt.legend(fontsize=4)

ax_2 = axisartist.Subplot(fig, 212)
fig.add_axes(ax_2)
for i in range(len(data_list_all)):
    data_list_sort_sub = data_list_all[i]
    ax_2_x=[i for i in range(layer_num)]
    ax_2_y=[0 for _ in range(layer_num)]
    for id in range(len(data_list_sort_sub)):
        if data_list_sort_sub[id][2] > 0:
            ax_2_y[data_list_sort_sub[id][0]] += 1
    plt.plot(np.array(ax_2_x), np.array(ax_2_y), c=color_list[i], label=file_list[i])
plt.xlim([0, layer_num])
plt.xlabel('#Layer', fontsize=5)
plt.ylabel(f'#Times Being Activated', fontsize=5)
plt.title(f'top{select_proportion} neurons', fontsize=8)
plt.legend(fontsize=4)
plt.savefig(f"Peak-anasisly-{file_list[0]}-{select_proportion}.png", dpi=1000)
plt.show()
