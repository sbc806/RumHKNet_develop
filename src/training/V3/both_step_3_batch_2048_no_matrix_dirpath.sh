#!/bin/bash
export CUDA_VISIBLE_DEVICES=0
# random seed
seed=1211

# for dataset
DATASET_NAME="extra_p_133_class_v3_batch"
DATASET_TYPE="protein"
# for task
TASK_TYPE="multi_class"
TASK_LEVEL_TYPE="seq_level"
LABEL_TYPE="extra_p_133_class"

# for input
## seq, vector, matrix, seq_matrix, seq_vector
### sequence + embedding channels
INPUT_TYPE="seq_matrix"
## single or pair
INPUT_MODE="single"
TRUNC_TYPE="right"

# for model
MODEL_TYPE="lucaprot"
CONFIG_NAME="lucaprot_config.json"
FUSION_TYPE="concat"
dropout_prob=0.1
fc_size=256
classifier_size=$fc_size
BEST_METRIC_TYPE="f1"
loss_type="cce"

## for sequence channel
SEQ_MAX_LENGTH=3432
hidden_size=2048
intermediate_size=4096
num_attention_heads=8
num_hidden_layers=1
### pooling type: none, max, mean, value_attention
SEQ_POOLING_TYPE="value_attention"
# word-level
codes_file="step_3_all_sequences_corpus_codes_30000.txt"
seq_subword="step_3_all_sequences_corpus_subword_vocab_30000.txt"

## for embedding channel
embedding_input_size=2560
matrix_max_length=3432
### pooling type: none, max, value_attention
MATRIX_POOLING_TYPE="value_attention"
### embedding llm
llm_version="esm2"
llm_type="esm"
llm_step="3B"

# for training
## max epochs
num_train_epochs=50
## accumulation gradient steps
gradient_accumulation_steps=4
# 间隔多少个step在log文件中写入信息（实际上是gradient_accumulation_steps与logging_steps的最小公倍数, 这里是4000）
logging_steps=1000
## checkpoint的间隔step数。-1表示按照epoch粒度保存checkpoint
save_steps=-1
## warmup_steps个step到达peak lr
warmup_steps=2000
## 最大迭代step次数(这么多次后，peak lr1变为lr2, 需要根据epoch,样本数量,n_gpu,batch_size,gradient_accumulation_steps进行估算）
## -1自动计算
max_steps=-1
## batch size for one GPU
batch_size=16
## 最大学习速率(peak learning rate)
learning_rate=2e-4
## data loading buffer size
buffer_size=4096
## tokenizer dir
tokenizer_dir=step_3
## positive weight
weight=13,212,7,8,21,31,3,10,4,27,28,3,363,589,6,2,20,1,4,37,32,179,17,30,14,110,1.2,4,12,11,64
weight=1
# weight=20,14,30,2,600,20,1,13,10,18,6,1,8,32,4,4,11,64,7,3,4,180,30,12,3,110,27,28,369,37,215
weight=1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4,5,5,6,6,6,6,7,7,7,7,7,7,7,8,8,8,8,9,9,9,9,9,11,11,11,11,13,13,13,13,13,14,14,14,14,14,15,15,16,17,18,20,20,22,23,26,29,30,32,33,33,33,34,36,36,38,40,40,41,43,43,44,45,45,46,48,49,49,50,54,54,54,56,57,60,61,63,70,74,75,83,85,86,89,89,92,108,138,147,200,205,242,346,467,744,1004,3349,6698,1435
weight=0.11074463418874006,0.11168330452632248,0.1242982812716562,0.14693473840353874,0.1935657465598299,0.19917787728974515,0.1997818666770326,0.20254067281902974,0.2588106665427092,0.2686371677857746,0.2825175416573067,0.3008318010386397,0.3266795667432278,0.3787401781241342,0.4074221441682064,0.4146097214562249,0.4149093568113967,0.4160260900698952,0.42254358427874966,0.43649527860054177,0.5074257613731298,0.5977706425814648,0.6096498832031535,0.6915869953665785,0.6948153578968167,0.7154730336612405,0.7508991087584432,0.770625509122759,0.8471357567612117,0.8749862900229018,0.9133663704716336,0.9440479281360554,0.9869381213347711,0.992054315002515,1.0039500449850582,1.1250873544443416,1.2200400819900388,1.2884937576387265,1.3678733934905336,1.3973616238091753,1.4256161866176615,1.4352900107411386,1.452407672596743,1.5486751560983383,1.568010936431989,1.5822094606595227,1.5853301893787723,1.6336634268598325,1.7079524139716056,1.7130486061701569,1.7564737893685263,1.8502817818025727,1.8920960593574332,1.9265637728068974,1.9518271151409363,1.9787356130355431,2.2364006845159645,2.274370135865981,2.3723801830432043,2.3794032149645874,2.626674529460907,2.700814536340852,2.756386851903421,2.7715945035001295,2.7986156198295182,2.8142941387081146,2.830149316954358,2.8522441661285933,2.9291632872268134,2.9879643346283924,3.0013532711539863,3.139696898496241,3.259377153345651,3.4173571684312822,3.7073911716560777,4.002800826768116,4.0107904491768345,4.566831852358169,4.603450206271693,5.239650625912891,5.980375044754744,6.135590885610974,6.409588564713219,6.742973204824141,6.765676818308397,6.788533834586466,6.893331097899122,7.215102387926729,7.228079190782712,7.669488607013718,8.005601653536232,8.005601653536232,8.286210371289048,8.642606516290726,8.661232823437905,8.990630939765522,9.031038269831884,9.133663704716337,9.324389860963313,9.754398131250456,9.874231032125769,9.972238288027762,10.097517663505498,10.803258145363408,10.92068486433475,10.980360737910349,11.225731927584324,11.54831043125054,12.104855512274662,12.32764426403432,12.717759588845531,14.101094842369081,14.995567276399955,15.165328415378069,16.745050125313284,17.1744103849367,17.32246564687581,17.86138680033417,17.941125134264233,18.519871106337273,21.723308270676693,27.715945035001297,29.550088456435205,40.188120300751876,41.00828602117539,48.41942204909865,69.28986258750324,93.46074488546948,148.84489000278475,200.9406015037594,669.8020050125314,1339.6040100250627,287.05800214822773

# model building time
time_str=$(date "+%Y%m%d%H%M%S")

cd ../..
python -u run.py \
  --train_data_dir ../kinases_dataset/$DATASET_NAME/$DATASET_TYPE/$TASK_TYPE/train/ \
  --dev_data_dir ../kinases_dataset/$DATASET_NAME/$DATASET_TYPE/$TASK_TYPE/dev/ \
  --test_data_dir ../kinases_dataset/$DATASET_NAME/$DATASET_TYPE/$TASK_TYPE/test/ \
  --buffer_size $buffer_size \
  --dataset_name $DATASET_NAME \
  --dataset_type $DATASET_TYPE \
  --task_type $TASK_TYPE \
  --task_level_type $TASK_LEVEL_TYPE \
  --model_type $MODEL_TYPE \
  --input_type $INPUT_TYPE \
  --input_mode $INPUT_MODE \
  --label_type $LABEL_TYPE \
  --seq_subword \
  --codes_file ../subword/$tokenizer_dir/$codes_file \
  --label_filepath ../kinases_dataset/$DATASET_NAME/$DATASET_TYPE/$TASK_TYPE/label.txt  \
  --output_dir ../models_both_step_3_batch/$DATASET_NAME/$DATASET_TYPE/$TASK_TYPE/$MODEL_TYPE/$INPUT_TYPE/$time_str \
  --log_dir ../logs/$DATASET_NAME/$DATASET_TYPE/$TASK_TYPE/$MODEL_TYPE/$INPUT_TYPE/$time_str \
  --tb_log_dir ../tb-logs/$DATASET_NAME/$DATASET_TYPE/$TASK_TYPE/$MODEL_TYPE/$INPUT_TYPE/$time_str \
  --config_path ../config/$MODEL_TYPE/$CONFIG_NAME \
  --seq_vocab_path ../vocab/$tokenizer_dir/$seq_subword \
  --seq_pooling_type $SEQ_POOLING_TYPE \
  --matrix_pooling_type $MATRIX_POOLING_TYPE \
  --fusion_type $FUSION_TYPE \
  --do_train \
  --do_eval \
  --do_predict \
  --do_metrics \
  --evaluate_during_training \
  --per_gpu_train_batch_size=$batch_size \
  --per_gpu_eval_batch_size=$batch_size \
  --gradient_accumulation_steps=$gradient_accumulation_steps \
  --learning_rate=$learning_rate \
  --lr_update_strategy step \
  --lr_decay_rate 0.95 \
  --num_train_epochs=$num_train_epochs \
  --overwrite_output_dir \
  --seed $seed \
  --loss_type $loss_type \
  --best_metric_type $BEST_METRIC_TYPE \
  --seq_max_length=$SEQ_MAX_LENGTH \
  --embedding_input_size $embedding_input_size \
  --matrix_max_length=$matrix_max_length \
  --trunc_type=$TRUNC_TYPE \
  --weight $weight \
  --save_all \
  --llm_version $llm_version \
  --llm_type $llm_type \
  --llm_step $llm_step \
  --ignore_index -100 \
  --hidden_size $hidden_size \
  --intermediate_size $intermediate_size \
  --num_attention_heads $num_attention_heads \
  --num_hidden_layers $num_hidden_layers \
  --dropout_prob $dropout_prob \
  --classifier_size $classifier_size \
  --seq_fc_size $fc_size \
  --matrix_fc_size $fc_size \
  --vector_fc_size $fc_size \
  --emb_activate_func gelu \
  --fc_activate_func gelu \
  --classifier_activate_func gelu \
  --warmup_steps $warmup_steps \
  --beta1 0.9 \
  --beta2 0.99 \
  --weight_decay 0.01 \
  --save_steps $save_steps \
  --max_steps $max_steps \
  --logging_steps $logging_steps \
  --max_grad_norm 1.0 \
  --embedding_complete \
  --embedding_complete_seg_overlap \
  --matrix_embedding_exists \
  --matrix_add_special_token \
  --no_token_type_embeddings \
  --no_position_embeddings \
  --use_rotary_position_embeddings \
  --num_batches 10
