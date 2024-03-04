output_dir=wmt_main_MLP/wmt22-GPT4-eng_spa2zho-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_wmt_2in_1out.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --nshot 1 \
    --flores_src_files eng_Latn_#_spa_Latn \
    --flores_tgt_file zho_Hans \
    --source_languages English_#_Spanish \
    --target_language Chinese \
    --source_lang_abb_flores eng_#_spa \
    --target_lang_abb_flores zho \
    --source_lang_abb_wmt22 en_#_es \
    --target_lang_abb_wmt22 zh



output_dir=wmt_main_MLP/wmt22-GPT4-eng_spa_rus_fra2zho-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_wmt_4in_1out.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --nshot 1 \
    --flores_src_files eng_Latn_#_spa_Latn_#_rus_Cyrl_#_fra_Latn \
    --flores_tgt_file zho_Hans \
    --source_languages English_#_Spanish_#_Russian_#_French \
    --target_language Chinese \
    --source_lang_abb_flores eng_#_spa_#_rus_#_fra \
    --target_lang_abb_flores zho \
    --source_lang_abb_wmt22 en_#_es_#_ru_#_fr \
    --target_lang_abb_wmt22 zh



output_dir=wmt_main_MLP/wmt22-GPT4-eng_spa_rus_fra_jpn_ces_deu2zho-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_wmt_7in_1out.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --nshot 1 \
    --flores_src_files eng_Latn_#_spa_Latn_#_rus_Cyrl_#_fra_Latn_#_jpn_Jpan_#_ces_Latn_#_deu_Latn \
    --flores_tgt_file zho_Hans \
    --source_languages English_#_Spanish_#_Russian_#_French_#_Japanese_#_Czech_#_German \
    --target_language Chinese \
    --source_lang_abb_flores eng_#_spa_#_rus_#_fra_#_jpn_#_ces_#_deu \
    --target_lang_abb_flores zho \
    --source_lang_abb_wmt22 en_#_es_#_ru_#_fr_#_jp_#_cs_#_de \
    --target_lang_abb_wmt22 zh



output_dir=wmt_baseline/wmt22-eng2zho-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para English_#_en_###_Chinese_#_zh \
    --lang_para_flores English_#_eng_Latn_###_Chinese_#_zho_Hans



output_dir=wmt_baseline/wmt22-eng2zho-5shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 5 \
    --lang_para English_#_en_###_Chinese_#_zh \
    --lang_para_flores English_#_eng_Latn_###_Chinese_#_zho_Hans



# ################################# MIDDLE



output_dir=wmt_baseline/wmt22-en-zh-deu2zho-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para German_###_Chinese \
    --lang_para_flores deu_Latn_###_zho_Hans \
    --source_lang_abb_flores eng \
    --middle_lang_abb_flores deu \
    --source_lang_abb_wmt22 en \
    --target_lang_abb_wmt22 zh



output_dir=wmt_baseline/wmt22-en-zh-jpn2zho-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para Japanese_###_Chinese \
    --lang_para_flores jpn_Jpan_###_zho_Hans \
    --source_lang_abb_flores eng \
    --middle_lang_abb_flores jpn \
    --source_lang_abb_wmt22 en \
    --target_lang_abb_wmt22 zh



output_dir=wmt_baseline/wmt22-en-zh-ces2zho-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para Czech_###_Chinese \
    --lang_para_flores ces_Latn_###_zho_Hans \
    --source_lang_abb_flores eng \
    --middle_lang_abb_flores ces \
    --source_lang_abb_wmt22 en \
    --target_lang_abb_wmt22 zh



output_dir=wmt_baseline/wmt22-en-zh-spa2zho-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para Spanish_###_Chinese \
    --lang_para_flores spa_Latn_###_zho_Hans \
    --source_lang_abb_flores eng \
    --middle_lang_abb_flores spa \
    --source_lang_abb_wmt22 en \
    --target_lang_abb_wmt22 zh



output_dir=wmt_baseline/wmt22-en-zh-rus2zho-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para Russian_###_Chinese \
    --lang_para_flores rus_Cyrl_###_zho_Hans \
    --source_lang_abb_flores eng \
    --middle_lang_abb_flores rus \
    --source_lang_abb_wmt22 en \
    --target_lang_abb_wmt22 zh


output_dir=wmt_baseline/wmt22-en-zh-fra2zho-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para French_###_Chinese \
    --lang_para_flores fra_Latn_###_zho_Hans \
    --source_lang_abb_flores eng \
    --middle_lang_abb_flores fra \
    --source_lang_abb_wmt22 en \
    --target_lang_abb_wmt22 zh