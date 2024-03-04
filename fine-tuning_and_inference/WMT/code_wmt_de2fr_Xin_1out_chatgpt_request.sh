# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_main_MLP/wmt22-GPT4-deu_spa2fra-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_wmt_2in_1out.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --nshot 1 \
#     --flores_src_files deu_Latn_#_spa_Latn \
#     --flores_tgt_file fra_Latn \
#     --source_languages German_#_Spanish \
#     --target_language French \
#     --source_lang_abb_flores deu_#_spa \
#     --target_lang_abb_flores fra \
#     --source_lang_abb_wmt22 de_#_es \
#     --target_lang_abb_wmt22 fr \
#     --engine gpt-3.5-turbo-0613



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_main_MLP/wmt22-GPT4-deu_spa_rus_ita2fra-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_wmt_4in_1out.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --nshot 1 \
#     --flores_src_files deu_Latn_#_spa_Latn_#_rus_Cyrl_#_ita_Latn \
#     --flores_tgt_file fra_Latn \
#     --source_languages German_#_Spanish_#_Russian_#_Italian \
#     --target_language French \
#     --source_lang_abb_flores deu_#_spa_#_rus_#_ita \
#     --target_lang_abb_flores fra \
#     --source_lang_abb_wmt22 de_#_es_#_ru_#_it \
#     --target_lang_abb_wmt22 fr \
#     --engine gpt-3.5-turbo-0613



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_main_MLP/wmt22-GPT4-deu_spa_rus_ita_zho_jpn_ces2fra-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_wmt_7in_1out.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --nshot 1 \
#     --flores_src_files deu_Latn_#_spa_Latn_#_rus_Cyrl_#_ita_Latn_#_zho_Hans_#_jpn_Jpan_#_ces_Latn \
#     --flores_tgt_file fra_Latn \
#     --source_languages German_#_Spanish_#_Russian_#_Italian_#_Chinese_#_Japanese_#_Czech \
#     --target_language French \
#     --source_lang_abb_flores deu_#_spa_#_rus_#_ita_#_zho_#_jpn_#_ces \
#     --target_lang_abb_flores fra \
#     --source_lang_abb_wmt22 de_#_es_#_ru_#_it_#_zh_#_jp_#_cs \
#     --target_lang_abb_wmt22 fr \
#     --engine gpt-3.5-turbo-0613

# ######### eng

output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/1.26-MLP-5-shot/wmt22-GPT4-deu_eng2fra-5shot-v8

rm -rf $output_dir/*

mkdir -p $output_dir
proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_wmt_2in_1out.py \
    --result_data_path $output_dir \
    --prompt_version 8 \
    --nshot 5 \
    --flores_src_files deu_Latn_#_eng_Latn \
    --flores_tgt_file fra_Latn \
    --source_languages German_#_English \
    --target_language French \
    --source_lang_abb_flores deu_#_eng \
    --target_lang_abb_flores fra \
    --source_lang_abb_wmt22 de_#_en \
    --target_lang_abb_wmt22 fr \
    --engine gpt-3.5-turbo-0613



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/1.26-MLP-5-shot/wmt22-GPT4-deu_eng_rus_spa2fra-5shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_wmt_4in_1out.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --nshot 5 \
#     --flores_src_files deu_Latn_#_eng_Latn_#_rus_Cyrl_#_spa_Latn \
#     --flores_tgt_file fra_Latn \
#     --source_languages German_#_English_#_Russian_#_Spanish \
#     --target_language French \
#     --source_lang_abb_flores deu_#_eng_#_rus_#_spa \
#     --target_lang_abb_flores fra \
#     --source_lang_abb_wmt22 de_#_en_#_ru_#_es \
#     --target_lang_abb_wmt22 fr \
#     --engine gpt-3.5-turbo-0613



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/1.26-MLP-5-shot/wmt22-GPT4-deu_eng_rus_spa_zho_ita_ces2fra-5shot-v8

# rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_wmt_7in_1out.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --nshot 5 \
#     --flores_src_files deu_Latn_#_eng_Latn_#_rus_Cyrl_#_spa_Latn_#_zho_Hans_#_ita_Latn_#_ces_Latn \
#     --flores_tgt_file fra_Latn \
#     --source_languages German_#_English_#_Russian_#_Spanish_#_Chinese_#_Italian_#_Czech \
#     --target_language French \
#     --source_lang_abb_flores deu_#_eng_#_rus_#_spa_#_zho_#_ita_#_ces \
#     --target_lang_abb_flores fra \
#     --source_lang_abb_wmt22 de_#_en_#_ru_#_es_#_zh_#_it_#_cs \
#     --target_lang_abb_wmt22 fr \
#     --engine gpt-3.5-turbo-0613



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-deu2fra-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 1 \
#     --lang_para German_#_de_###_French_#_fr \
#     --lang_para_flores German_#_deu_Latn_###_French_#_fra_Latn \
#     --engine gpt-3.5-turbo-0613




# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-deu2fra-5shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 5 \
#     --lang_para German_#_de_###_French_#_fr \
#     --lang_para_flores German_#_deu_Latn_###_French_#_fra_Latn \
#     --engine gpt-3.5-turbo-0613



# # ################################# MIDDLE



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-de-fr-zho2fra-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT_nmt_baselines.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 1 \
#     --lang_para Chinese_###_French \
#     --lang_para_flores zho_Hans_###_fra_Latn \
#     --source_lang_abb_flores deu \
#     --middle_lang_abb_flores zho \
#     --source_lang_abb_wmt22 de \
#     --target_lang_abb_wmt22 fr



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-de-fr-eng2fra-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT_nmt_baselines.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 1 \
#     --lang_para English_###_French \
#     --lang_para_flores eng_Latn_###_fra_Latn \
#     --source_lang_abb_flores deu \
#     --middle_lang_abb_flores eng \
#     --source_lang_abb_wmt22 de \
#     --target_lang_abb_wmt22 fr



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-de-fr-jpn2fra-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT_nmt_baselines.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 1 \
#     --lang_para Japanese_###_French \
#     --lang_para_flores jpn_Jpan_###_fra_Latn \
#     --source_lang_abb_flores deu \
#     --middle_lang_abb_flores jpn \
#     --source_lang_abb_wmt22 de \
#     --target_lang_abb_wmt22 fr



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-de-fr-ces2fra-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT_nmt_baselines.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 1 \
#     --lang_para Czech_###_French \
#     --lang_para_flores ces_Latn_###_fra_Latn \
#     --source_lang_abb_flores deu \
#     --middle_lang_abb_flores ces \
#     --source_lang_abb_wmt22 de \
#     --target_lang_abb_wmt22 fr



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-de-fr-spa2fra-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT_nmt_baselines.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 1 \
#     --lang_para Spanish_###_French \
#     --lang_para_flores spa_Latn_###_fra_Latn \
#     --source_lang_abb_flores deu \
#     --middle_lang_abb_flores spa \
#     --source_lang_abb_wmt22 de \
#     --target_lang_abb_wmt22 fr



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-de-fr-rus2fra-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT_nmt_baselines.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 1 \
#     --lang_para Russian_###_French \
#     --lang_para_flores rus_Cyrl_###_fra_Latn \
#     --source_lang_abb_flores deu \
#     --middle_lang_abb_flores rus \
#     --source_lang_abb_wmt22 de \
#     --target_lang_abb_wmt22 fr



# output_dir=/mnt/muyongyu/fpn/multi_lang/myy_files/results/wmt_1shot_chatgpt_request/need_request/wmt_baseline/wmt22-de-fr-ita2fra-1shot-v8

# # rm -rf $output_dir/*

# mkdir -p $output_dir
# proxychains4 python /mnt/muyongyu/fpn/multi_lang/myy_files/request_scripts/code_WMT_nmt_baselines.py \
#     --result_data_path $output_dir \
#     --prompt_version 8 \
#     --shot_n 1 \
#     --lang_para Italian_###_French \
#     --lang_para_flores ita_Latn_###_fra_Latn \
#     --source_lang_abb_flores deu \
#     --middle_lang_abb_flores ita \
#     --source_lang_abb_wmt22 de \
#     --target_lang_abb_wmt22 fr