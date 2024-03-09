import matplotlib.pyplot as plt
import numpy as np
import sys
import jsonlines
from matplotlib.colors import Normalize

file = ""
layer_num = 0

data_list = []
with jsonlines.open(file, mode='r') as reader:
    for row in reader:
        layer_num = len(row)
        for layer in range(len(row)):
            data_list.append(row[str(layer)])

data_np = np.array(data_list)
# data_np = 1*(data_np-np.min(data_np))/(np.max(data_np)-np.min(data_np))
# data_np = data_np[: ,0:2000]

norm_heatmap = Normalize()
plt.imshow(data_np, cmap='hot', interpolation='nearest', aspect='auto', origin='lower', norm=norm_heatmap)
plt.yticks(range(0, layer_num, 5), fontsize=10)
plt.xticks(fontsize=10)
plt.ylabel('#Layer')
plt.title(file, fontsize=6)
cb=plt.colorbar()
cb.ax.tick_params(labelsize=10)

plt.savefig(f"One-{file}.png", dpi=1000, bbox_inches = 'tight')
plt.show()
