output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/1.26-MLP-5-shot/wmt22-GPT4-isl_spa2eng-5shot-v8

# rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_wmt_2in_1out.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --nshot 5 \
    --flores_src_files isl_Latn_#_spa_Latn \
    --flores_tgt_file eng_Latn \
    --source_languages Icelandic_#_Spanish \
    --target_language English \
    --source_lang_abb_flores isl_#_spa \
    --target_lang_abb_flores eng \
    --source_lang_abb_wmt22 is_#_es \
    --target_lang_abb_wmt22 en \
    --engine gpt-3.5-turbo-0613



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/1.26-MLP-5-shot/wmt22-GPT4-isl_spa_rus_fra2eng-5shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_wmt_4in_1out.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --nshot 5 \
#     --flores_src_files isl_Latn_#_spa_Latn_#_rus_Cyrl_#_fra_Latn \
#     --flores_tgt_file eng_Latn \
#     --source_languages Icelandic_#_Spanish_#_Russian_#_French \
#     --target_language English \
#     --source_lang_abb_flores isl_#_spa_#_rus_#_fra \
#     --target_lang_abb_flores eng \
#     --source_lang_abb_wmt22 is_#_es_#_ru_#_fr \
#     --target_lang_abb_wmt22 en \
#     --engine gpt-3.5-turbo-0613



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/1.26-MLP-5-shot/wmt22-GPT4-isl_spa_rus_fra_ita_ces_deu2eng-5shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_wmt_7in_1out.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --nshot 5 \
#     --flores_src_files isl_Latn_#_spa_Latn_#_rus_Cyrl_#_fra_Latn_#_ita_Latn_#_ces_Latn_#_deu_Latn \
#     --flores_tgt_file eng_Latn \
#     --source_languages Icelandic_#_Spanish_#_Russian_#_French_#_Italian_#_Czech_#_German \
#     --target_language English \
#     --source_lang_abb_flores isl_#_spa_#_rus_#_fra_#_ita_#_ces_#_deu \
#     --target_lang_abb_flores eng \
#     --source_lang_abb_wmt22 is_#_es_#_ru_#_fr_#_it_#_cs_#_de \
#     --target_lang_abb_wmt22 en \
#     --engine gpt-3.5-turbo-0613



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-isl2eng-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 1 \
#     --lang_para Icelandic_#_is_###_English_#_en \
#     --lang_para_flores Icelandic_#_isl_Latn_###_English_#_eng_Latn \
#     --engine gpt-3.5-turbo-0613



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-isl2eng-5shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 5 \
#     --lang_para Icelandic_#_is_###_English_#_en \
#     --lang_para_flores Icelandic_#_isl_Latn_###_English_#_eng_Latn \
#     --engine gpt-3.5-turbo-0613



# # ################################# MIDDLE



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-is-en-deu2eng-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT_nmt_baselines.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 1 \
#     --lang_para German_###_English \
#     --lang_para_flores deu_Latn_###_eng_Latn \
#     --source_lang_abb_flores isl \
#     --middle_lang_abb_flores deu \
#     --source_lang_abb_wmt22 is \
#     --target_lang_abb_wmt22 en



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-is-en-ita2eng-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT_nmt_baselines.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 1 \
#     --lang_para Italian_###_English \
#     --lang_para_flores ita_Latn_###_eng_Latn \
#     --source_lang_abb_flores isl \
#     --middle_lang_abb_flores ita \
#     --source_lang_abb_wmt22 is \
#     --target_lang_abb_wmt22 en



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-is-en-ces2eng-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT_nmt_baselines.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 1 \
#     --lang_para Czech_###_English \
#     --lang_para_flores ces_Latn_###_eng_Latn \
#     --source_lang_abb_flores isl \
#     --middle_lang_abb_flores ces \
#     --source_lang_abb_wmt22 is \
#     --target_lang_abb_wmt22 en



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-is-en-spa2eng-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT_nmt_baselines.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 1 \
#     --lang_para Spanish_###_English \
#     --lang_para_flores spa_Latn_###_eng_Latn \
#     --source_lang_abb_flores isl \
#     --middle_lang_abb_flores spa \
#     --source_lang_abb_wmt22 is \
#     --target_lang_abb_wmt22 en



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-is-en-rus2eng-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT_nmt_baselines.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 1 \
#     --lang_para Russian_###_English \
#     --lang_para_flores rus_Cyrl_###_eng_Latn \
#     --source_lang_abb_flores isl \
#     --middle_lang_abb_flores rus \
#     --source_lang_abb_wmt22 is \
#     --target_lang_abb_wmt22 en



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-is-en-fra2eng-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT_nmt_baselines.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 1 \
#     --lang_para French_###_English \
#     --lang_para_flores fra_Latn_###_eng_Latn \
#     --source_lang_abb_flores isl \
#     --middle_lang_abb_flores fra \
#     --source_lang_abb_wmt22 is \
#     --target_lang_abb_wmt22 en