# Binary Classification
export CUDA_VISIBLE_DEVICES="0"
dir_path="/home/schen123/scratch/kinases"
threshold=$1
echo $threshold

python -u prediction_v2.py \
    --seq_type prot \
    --input_file $dir_path/predictions/predictions_dataset/step_1/$3.csv \
    --model_path $dir_path/sbc806/RumHKNet/models_step_1_both \
    --save_path $dir_path/predictions/predicted_results/step_1/both/$3_predicted_$2$4_$5.csv \
    --dataset_name step_1_non_kinases_preprocessed \
    --dataset_type protein \
    --task_type binary_class \
    --task_level_type seq_level \
    --model_type lucaprot \
    --input_type seq_matrix \
    --input_mode single \
    --time_str 20251114152942 \
    --step 374392 \
    --threshold $threshold \
    --print_per_num 100000 \
    --truncation_seq_length $4 \
    --emb_dir $dir_path/embeddings/step_1/esm \
    --gpu_id 0 \
    --seq_id_idx 0 \
    --seq_idx 2 \
    --matrix_embedding_exists






