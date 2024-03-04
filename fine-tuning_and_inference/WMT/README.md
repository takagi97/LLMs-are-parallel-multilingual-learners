Here is our code to make inference data and conduct the main experiment of WMT on ChatGPT. The pipeline of five core scripts (```code_WMT.py```, ```code_WMT_nmt_baselines.py```, ```code_wmt_2in_1out.py```, ```code_wmt_4in_1out.py``` and ```code_wmt_7in_1out.py```) is same, i.e., reading dataset from files, intergating inputs with the template, requesting ChatGPT, saving the results. Every time of executing these scripts will receive a folder containing two files recording the whole prompts and results. The prompt files are fed to other LLMs like Qwen to conduct the main experiment.
- ```code_WMT.py```: experiments of the direct prompt
- ```code_WMT_nmt_baselines.py```: experiments of the pivot prompt
- ```code_wmt_2in_1out.py```: experiments of the PiM-1 prompt
- ```code_wmt_4in_1out.py```: experiments of the PiM-3 prompt
- ```code_wmt_7in_1out.py```: experiments of the PiM-6 prompt

We used the Shell scripts to drive these Python functions. Every shell will make the direct prompt, the pivot prompt and PiM prompt data (in PiM-1, PiM-3 and PiM-6) step by step.