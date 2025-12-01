#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus-per-node=h100:1
#SBATCH --mem=64G
#SBATCH --time=7-0
#SBATCH --job-name=prediction-both-step-1-train-0-10000
#SBATCH --output=output/prediction_both_step_1_train_0_10000_%j.out
#SBATCH --er=output/prediction_both_step_1_train_0_10000_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/19.0.1

cd /home/schen123/scratch/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/
# cat transformer_step_2_4_1.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_2/transformer/output/transformer_step_2_4_1_$SLURM_JOB_ID.txt
./prediction_scripts/step_1/both/prediction_both_step_1.sh 0.3 03 34551 train_0_10000


deactivate


