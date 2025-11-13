# Binary Classification
# export CUDA_VISIBLE_DEVICES="0"
dir_path="/home/schen123/projects/rrg-guanuofa/schen123/kinases"
python prediction_v2.py \
    --seq_type prot \
    --input_file $dir_path/test_data/step_2/examples.fasta \
    --llm_truncation_seq_length 10240 \
    --model_path $dir_path/models_trained/step_2 \
    --save_path $dir_path/predicted_results/test_data/step_2/examples_predicted.csv \
    --dataset_name extra_p_2_class_v3_kinases_only \
    --dataset_type protein \
    --task_type binary_class \
    --task_level_type seq_level \
    --model_type lucaprot \
    --input_type matrix \
    --input_mode single \
    --time_str 20240924203640 \
    --step 264284 \
    --threshold 0.2 \
    --per_num 10000 \
    --gpu_id -1
