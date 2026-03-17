#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus-per-node=h100:1
#SBATCH --mem=32G
#SBATCH --time=3-0
#SBATCH --job-name=prediction-both-step-1-step-2-combined-blastp-small-0-v3
#SBATCH --output=output/prediction_both_step_1_step_2_combined_blastp_small_0_v3_%j.out
#SBATCH --err=output/prediction_both_step_1_step_2_combined_blastp_small_0_v3_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0

cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd /home/schen123/scratch/kinases/sbc806/RumHKNet_develop/src/
# cat transformer_step_2_4_1.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_2/transformer/output/transformer_step_2_4_1_$SLURM_JOB_ID.txt
./prediction_scripts/step_1_step_2_combined/both/prediction_both_step_1_step_2_combined_v3.sh 0.2 02 histidine_blastp_ko_no_rumhknet_small_1 1500 50 _v3


deactivate

