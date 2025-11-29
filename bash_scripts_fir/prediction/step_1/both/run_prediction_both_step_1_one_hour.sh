#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus-per-node=nvidia_h100_80gb_hbm3_2g.20gb:1
#SBATCH --mem=28G
#SBATCH --time=1:0:0
#SBATCH --job-name=prediction-both-step-1-five-sequences
#SBATCH --output=output/prediction_both_step_1_five_sequences_%j.out
#SBATCH --er=output/prediction_both_step_1_five_sequences_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/19.0.1

cd /home/schen123/scratch/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/
# cat transformer_step_2_4_1.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_2/transformer/output/transformer_step_2_4_1_$SLURM_JOB_ID.txt
./prediction_scripts/step_1/both/prediction_both_step_1.sh 0.5 05 train_five_sequences


deactivate

