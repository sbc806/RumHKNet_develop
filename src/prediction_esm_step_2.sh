# Binary Classification
export CUDA_VISIBLE_DEVICES="0"
dir_path="/home/schen123/projects/rrg-guanuofa/schen123/kinases"
threshold=$1
echo $threshold

python prediction_v2.py \
    --seq_type prot \
    --input_file $dir_path/test_data/step_2/extra_p_2_class_v3_kinases_only/train.fasta \
    --model_path $dir_path/models_trained/step_2/esm \
    --save_path $dir_path/predicted_results/test_data/step_2/esm/extra_p_2_class_v3_kinases_only/train_predicted_$2.csv \
    --dataset_name extra_p_2_class_v3_kinases_only \
    --dataset_type protein \
    --task_type binary_class \
    --task_level_type seq_level \
    --model_type lucaprot \
    --input_type matrix \
    --input_mode single \
    --time_str 20250913223115 \
    --step 142912 \
    --threshold $threshold \
    --print_per_num 100000 \
    --truncation_seq_length 10240 \
    --emb_dir $dir_path/embeddings/step_2/esm \
    --gpu_id 0

# Binary Classification
export CUDA_VISIBLE_DEVICES="0"
dir_path="/home/schen123/projects/rrg-guanuofa/schen123/kinases"
python prediction_v2.py \
    --seq_type prot \
    --input_file $dir_path/test_data/step_2/extra_p_2_class_v3_kinases_only/dev.fasta \
    --model_path $dir_path/models_trained/step_2/esm \
    --save_path $dir_path/predicted_results/test_data/step_2/esm/extra_p_2_class_v3_kinases_only/dev_predicted_$2.csv \
    --dataset_name extra_p_2_class_v3_kinases_only \
    --dataset_type protein \
    --task_type binary_class \
    --task_level_type seq_level \
    --model_type lucaprot \
    --input_type matrix \
    --input_mode single \
    --time_str 20250913223115 \
    --step 142912 \
    --threshold $threshold \
    --print_per_num 100000 \
    --truncation_seq_length 10240 \
    --emb_dir $dir_path/embeddings/step_2/esm \
    --gpu_id 0

python prediction_v2.py \
    --seq_type prot \
    --input_file $dir_path/test_data/step_2/extra_p_2_class_v3_kinases_only/test.fasta \
    --model_path $dir_path/models_trained/step_2/esm \
    --save_path $dir_path/predicted_results/test_data/step_2/esm/extra_p_2_class_v3_kinases_only/test_predicted_$2.csv \
    --dataset_name extra_p_2_class_v3_kinases_only \
    --dataset_type protein \
    --task_type binary_class \
    --task_level_type seq_level \
    --model_type lucaprot \
    --input_type matrix \
    --input_mode single \
    --time_str 20250913223115 \
    --step 142912 \
    --threshold $threshold \
    --print_per_num 100000 \
    --truncation_seq_length 10240 \
    --emb_dir $dir_path/embeddings/step_2/esm \
    --gpu_id 0
