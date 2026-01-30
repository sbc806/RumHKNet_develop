#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus-per-node=h100:1
#SBATCH --mem=32G
#SBATCH --time=12:0:0
#SBATCH --job-name=prediction-both-step-4-extra-p-133-class-v3-batch-dev-v4
#SBATCH --output=output/prediction_both_step_4_extra_p_class_v3_batch_dev_v4_%j.out
#SBATCH --err=output/prediction_both_step_4_extra_p_class_v3_batch_dev_v4_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0

cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/
# cat transformer_step_2_4_1.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_2/transformer/output/transformer_step_2_4_1_$SLURM_JOB_ID.txt
./prediction_scripts/step_4/both/prediction_both_step_4_v4.sh 0.3 03 extra_p_133_class_v3_batch_dev 1 3432 _v4


deactivate

