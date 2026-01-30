# Binary Classification
export CUDA_VISIBLE_DEVICES="0"
dir_path="/home/schen123/projects/rrg-guanuofa/schen123/kinases"
threshold=$1
echo $threshold
truncation_seq_length=$4
echo $truncation_seq_length
chunk_size=$5
echo $chunk_size
extra=$6
echo $extra

python -u prediction_v4.py \
    --seq_type prot \
    --input_file $dir_path/predictions/predictions_dataset/step_4/$3.csv \
    --model_path $dir_path/sbc806/RumHKNet/models_both_step_3_batch_1 \
    --save_path $dir_path/predictions/predicted_results/step_4/both/ \
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
    --truncation_seq_length $truncation_seq_length \
    --truncation_matrix_length $truncation_seq_length \
    --emb_dir $dir_path/embeddings/step_4/esm \
    --gpu_id 0 \
    --seq_id_idx 0 \
    --seq_idx 2 \
    --matrix_embedding_exists \
    --chunk_size $chunk_size \
    --save_name $3_predicted_$2_$4$extra \
    --topk 10 \
    --num_batches 10







