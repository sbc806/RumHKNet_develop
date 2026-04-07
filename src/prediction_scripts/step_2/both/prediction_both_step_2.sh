# Binary Classification
export CUDA_VISIBLE_DEVICES="0"
dir_path="/home/schen123/projects/rrg-guanuofa/schen123/kinases"
dir_path_1="/home/schen123/scratch/kinases"
threshold=$1
echo $threshold
truncation_seq_length=$4
echo $truncation_seq_length
extra=$5
echo $extra

python -u prediction_v2.py \
    --seq_type prot \
    --input_file $dir_path/predictions/predictions_dataset/step_2/clustered/$3.csv \
    --model_path $dir_path_1/sbc806/RumHKNet_develop/models/step_2/both \
    --save_path $dir_path/predictions/predicted_results/step_2/both/clustered/$3_predicted_$2$5.csv \
    --dataset_name extra_p_2_class_v3_kinases_only \
    --dataset_type protein \
    --task_type binary_class \
    --task_level_type seq_level \
    --model_type lucaprot \
    --input_type seq_matrix \
    --input_mode single \
    --time_str 20251114152941 \
    --step 428736 \
    --threshold $threshold \
    --print_per_num 100000 \
    --truncation_seq_length $truncation_seq_length \
    --truncation_matrix_length $truncation_seq_length \
    --emb_dir $dir_path/embeddings/step_2/esm \
    --gpu_id 0 \
    --seq_id_idx 0 \
    --seq_idx 1 \
    --matrix_embedding_exists









