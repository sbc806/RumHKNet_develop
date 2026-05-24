# Binary Classification
export CUDA_VISIBLE_DEVICES="0"
dir_path="/home/schen123/projects/rrg-guanuofa/schen123/kinases"
dir_path_1="/home/schen123/scratch/kinases"
threshold=$1
echo $threshold

python -u prediction_v2.py \
    --seq_type prot \
    --input_file $dir_path/predictions/predictions_dataset/step_4/clustered/$3.csv \
    --model_path $dir_path_1/sbc806_1/RumHKNet_develop/models_both_step_3_batch_1 \
    --save_path $dir_path/predictions/predicted_results/step_4/both/clustered/$3_predicted_$2$5.csv \
    --dataset_name extra_p_133_class_v3_batch \
    --dataset_type protein \
    --task_type multi_class \
    --task_level_type seq_level \
    --model_type lucaprot \
    --input_type seq_matrix \
    --input_mode single \
    --time_str 20251209201835 \
    --step 100221 \
    --threshold $threshold \
    --print_per_num 100000 \
    --truncation_seq_length $4 \
    --truncation_matrix_length $4 \
    --emb_dir $dir_path/embeddings/step_4/esm \
    --gpu_id 0 \
    --seq_id_idx 0 \
    --seq_idx 1 \
    --matrix_embedding_exists \
    --topk 10 \
    --use_batch \
    --num_batches 10










