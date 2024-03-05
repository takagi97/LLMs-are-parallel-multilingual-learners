output_dir=wmt_main_MLP/wmt22-GPT4-eng_spa2deu-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_wmt_2in_1out.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --nshot 1 \
    --flores_src_files eng_Latn_#_spa_Latn \
    --flores_tgt_file deu_Latn \
    --source_languages English_#_Spanish \
    --target_language German \
    --source_lang_abb_flores eng_#_spa \
    --target_lang_abb_flores deu \
    --source_lang_abb_wmt22 en_#_es \
    --target_lang_abb_wmt22 de



output_dir=wmt_main_MLP/wmt22-GPT4-eng_spa_rus_fra2deu-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_wmt_4in_1out.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --nshot 1 \
    --flores_src_files eng_Latn_#_spa_Latn_#_rus_Cyrl_#_fra_Latn \
    --flores_tgt_file deu_Latn \
    --source_languages English_#_Spanish_#_Russian_#_French \
    --target_language German \
    --source_lang_abb_flores eng_#_spa_#_rus_#_fra \
    --target_lang_abb_flores deu \
    --source_lang_abb_wmt22 en_#_es_#_ru_#_fr \
    --target_lang_abb_wmt22 de



output_dir=wmt_main_MLP/wmt22-GPT4-eng_spa_rus_fra_zho_jpn_ces2deu-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_wmt_7in_1out.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --nshot 1 \
    --flores_src_files eng_Latn_#_spa_Latn_#_rus_Cyrl_#_fra_Latn_#_zho_Hans_#_jpn_Jpan_#_ces_Latn \
    --flores_tgt_file deu_Latn \
    --source_languages English_#_Spanish_#_Russian_#_French_#_Chinese_#_Japanese_#_Czech \
    --target_language German \
    --source_lang_abb_flores eng_#_spa_#_rus_#_fra_#_zho_#_jpn_#_ces \
    --target_lang_abb_flores deu \
    --source_lang_abb_wmt22 en_#_es_#_ru_#_fr_#_zh_#_jp_#_cs \
    --target_lang_abb_wmt22 de



output_dir=wmt_baseline/wmt22-eng2deu-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para English_#_en_###_German_#_de \
    --lang_para_flores English_#_eng_Latn_###_German_#_deu_Latn



output_dir=wmt_baseline/wmt22-eng2deu-5shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 5 \
    --lang_para English_#_en_###_German_#_de \
    --lang_para_flores English_#_eng_Latn_###_German_#_deu_Latn



# ################################# MIDDLE



output_dir=wmt_baseline/wmt22-en-de-zho2deu-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para Chinese_###_German \
    --lang_para_flores zho_Hans_###_deu_Latn \
    --source_lang_abb_flores eng \
    --middle_lang_abb_flores zho \
    --source_lang_abb_wmt22 en \
    --target_lang_abb_wmt22 de



output_dir=wmt_baseline/wmt22-en-de-jpn2deu-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para Japanese_###_German \
    --lang_para_flores jpn_Jpan_###_deu_Latn \
    --source_lang_abb_flores eng \
    --middle_lang_abb_flores jpn \
    --source_lang_abb_wmt22 en \
    --target_lang_abb_wmt22 de



output_dir=wmt_baseline/wmt22-en-de-ces2deu-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para Czech_###_German \
    --lang_para_flores ces_Latn_###_deu_Latn \
    --source_lang_abb_flores eng \
    --middle_lang_abb_flores ces \
    --source_lang_abb_wmt22 en \
    --target_lang_abb_wmt22 de



output_dir=wmt_baseline/wmt22-en-de-spa2deu-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para Spanish_###_German \
    --lang_para_flores spa_Latn_###_deu_Latn \
    --source_lang_abb_flores eng \
    --middle_lang_abb_flores spa \
    --source_lang_abb_wmt22 en \
    --target_lang_abb_wmt22 de



output_dir=wmt_baseline/wmt22-en-de-rus2deu-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para Russian_###_German \
    --lang_para_flores rus_Cyrl_###_deu_Latn \
    --source_lang_abb_flores eng \
    --middle_lang_abb_flores rus \
    --source_lang_abb_wmt22 en \
    --target_lang_abb_wmt22 de


output_dir=wmt_baseline/wmt22-en-de-fra2deu-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para French_###_German \
    --lang_para_flores fra_Latn_###_deu_Latn \
    --source_lang_abb_flores eng \
    --middle_lang_abb_flores fra \
    --source_lang_abb_wmt22 en \
    --target_lang_abb_wmt22 de