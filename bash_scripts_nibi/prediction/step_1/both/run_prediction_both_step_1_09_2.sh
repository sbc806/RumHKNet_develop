#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus-per-node=nvidia_h100_80gb_hbm3_2g.20gb:1
#SBATCH --mem=25G
#SBATCH --time=3-0
#SBATCH --job-name=prediction-both-step-1-09-2
#SBATCH --output=output/prediction_both_step_1_09_2_%j.out
#SBATCH --err=output/prediction_both_step_1_09_2_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0

cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/
# cat transformer_step_2_4_1.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_2/transformer/output/transformer_step_2_4_1_$SLURM_JOB_ID.txt
./prediction_scripts/step_1/both/prediction_both_step_1.sh 0.9 09 train_2


deactivate


