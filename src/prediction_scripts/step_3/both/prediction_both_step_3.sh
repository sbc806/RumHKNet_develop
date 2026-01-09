# Binary Classification
export CUDA_VISIBLE_DEVICES="0"
dir_path="/home/schen123/projects/rrg-guanuofa/schen123/kinases"
threshold=$1
echo $threshold

python -u prediction_v2.py \
    --seq_type prot \
    --input_file $dir_path/predictions/predictions_dataset/step_3/clustered/$3.csv \
    --model_path $dir_path/sbc806/RumHKNet/models_step_3_both_11_family \
    --save_path $dir_path/predictions/predicted_results/step_3/both/clustered/$3_predicted_$2$5.csv \
    --dataset_name step_3_11_family \
    --dataset_type protein \
    --task_type multi_class \
    --task_level_type seq_level \
    --model_type lucaprot \
    --input_type seq_matrix \
    --input_mode single \
    --time_str 20251120222923 \
    --step 133628 \
    --threshold $threshold \
    --print_per_num 100000 \
    --truncation_seq_length $4 \
    --truncation_matrix_length $4 \
    --emb_dir $dir_path/embeddings/step_3/esm \
    --gpu_id 0 \
    --seq_id_idx 0 \
    --seq_idx 1 \
    --matrix_embedding_exists









