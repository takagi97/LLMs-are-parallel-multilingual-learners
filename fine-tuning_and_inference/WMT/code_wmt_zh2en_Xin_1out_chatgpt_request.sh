output_dir=wmt_main_MLP/wmt22-GPT4-zho_spa2eng-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_wmt_2in_1out.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --nshot 1 \
    --flores_src_files zho_Hans_#_spa_Latn \
    --flores_tgt_file eng_Latn \
    --source_languages Chinese_#_Spanish \
    --target_language English \
    --source_lang_abb_flores zho_#_spa \
    --target_lang_abb_flores eng \
    --source_lang_abb_wmt22 zh_#_es \
    --target_lang_abb_wmt22 en



output_dir=wmt_main_MLP/wmt22-GPT4-zho_spa_rus_fra2eng-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_wmt_4in_1out.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --nshot 1 \
    --flores_src_files zho_Hans_#_spa_Latn_#_rus_Cyrl_#_fra_Latn \
    --flores_tgt_file eng_Latn \
    --source_languages Chinese_#_Spanish_#_Russian_#_French \
    --target_language English \
    --source_lang_abb_flores zho_#_spa_#_rus_#_fra \
    --target_lang_abb_flores eng \
    --source_lang_abb_wmt22 zh_#_es_#_ru_#_fr \
    --target_lang_abb_wmt22 en



output_dir=wmt_main_MLP/wmt22-GPT4-zho_spa_rus_fra_jpn_ces_deu2eng-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_wmt_7in_1out.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --nshot 1 \
    --flores_src_files zho_Hans_#_spa_Latn_#_rus_Cyrl_#_fra_Latn_#_jpn_Jpan_#_ces_Latn_#_deu_Latn \
    --flores_tgt_file eng_Latn \
    --source_languages Chinese_#_Spanish_#_Russian_#_French_#_Japanese_#_Czech_#_German \
    --target_language English \
    --source_lang_abb_flores zho_#_spa_#_rus_#_fra_#_jpn_#_ces_#_deu \
    --target_lang_abb_flores eng \
    --source_lang_abb_wmt22 zh_#_es_#_ru_#_fr_#_jp_#_cs_#_de \
    --target_lang_abb_wmt22 en



output_dir=wmt_baseline/wmt22-zho2eng-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para Chinese_#_zh_###_English_#_en \
    --lang_para_flores Chinese_#_zho_Hans_###_English_#_eng_Latn



output_dir=wmt_baseline/wmt22-zho2eng-5shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 5 \
    --lang_para Chinese_#_zh_###_English_#_en \
    --lang_para_flores Chinese_#_zho_Hans_###_English_#_eng_Latn



# ################################# MIDDLE



output_dir=wmt_baseline/wmt22-zh-en-deu2eng-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para German_###_English \
    --lang_para_flores deu_Latn_###_eng_Latn \
    --source_lang_abb_flores zho \
    --middle_lang_abb_flores deu \
    --source_lang_abb_wmt22 zh \
    --target_lang_abb_wmt22 en



output_dir=wmt_baseline/wmt22-zh-en-jpn2eng-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para Japanese_###_English \
    --lang_para_flores jpn_Jpan_###_eng_Latn \
    --source_lang_abb_flores zho \
    --middle_lang_abb_flores jpn \
    --source_lang_abb_wmt22 zh \
    --target_lang_abb_wmt22 en



output_dir=wmt_baseline/wmt22-zh-en-ces2eng-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para Czech_###_English \
    --lang_para_flores ces_Latn_###_eng_Latn \
    --source_lang_abb_flores zho \
    --middle_lang_abb_flores ces \
    --source_lang_abb_wmt22 zh \
    --target_lang_abb_wmt22 en



output_dir=wmt_baseline/wmt22-zh-en-spa2eng-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para Spanish_###_English \
    --lang_para_flores spa_Latn_###_eng_Latn \
    --source_lang_abb_flores zho \
    --middle_lang_abb_flores spa \
    --source_lang_abb_wmt22 zh \
    --target_lang_abb_wmt22 en



output_dir=wmt_baseline/wmt22-zh-en-rus2eng-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para Russian_###_English \
    --lang_para_flores rus_Cyrl_###_eng_Latn \
    --source_lang_abb_flores zho \
    --middle_lang_abb_flores rus \
    --source_lang_abb_wmt22 zh \
    --target_lang_abb_wmt22 en



output_dir=wmt_baseline/wmt22-zh-en-fra2eng-1shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python code_WMT_nmt_baselines.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --shot_n 1 \
    --lang_para French_###_English \
    --lang_para_flores fra_Latn_###_eng_Latn \
    --source_lang_abb_flores zho \
    --middle_lang_abb_flores fra \
    --source_lang_abb_wmt22 zh \
    --target_lang_abb_wmt22 en