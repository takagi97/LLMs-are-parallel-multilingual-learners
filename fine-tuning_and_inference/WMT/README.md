Here is our code to make inference data and conduct the main experiments of WMT on ChatGPT. The pipelines of the five core scripts (```code_WMT.py```, ```code_WMT_nmt_baselines.py```, ```code_wmt_2in_1out.py```, ```code_wmt_4in_1out.py``` and ```code_wmt_7in_1out.py```) are the same, i.e., reading datasets from files, integrating inputs with the template, requesting ChatGPT, and saving the results. Every time these scripts are executed, they generate a folder containing two files that record the whole prompts and results. The prompt files are fed into other LLMs like Qwen to conduct the main experiments.

- ```code_WMT.py```: experiments of the direct prompt
- ```code_WMT_nmt_baselines.py```: experiments of the pivot prompt
- ```code_wmt_2in_1out.py```: experiments of the PiM-1 prompt
- ```code_wmt_4in_1out.py```: experiments of the PiM-3 prompt
- ```code_wmt_7in_1out.py```: experiments of the PiM-6 prompt

We used the Shell scripts to drive these Python functions. Every shell will generate the direct prompt, the pivot prompt and PiM prompt data (in PiM-1, PiM-3 and PiM-6) sequentially.
