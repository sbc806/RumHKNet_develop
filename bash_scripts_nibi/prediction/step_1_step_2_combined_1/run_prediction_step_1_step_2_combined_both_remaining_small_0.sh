#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus-per-node=nvidia_h100_80gb_hbm3_h3g.40gb:1
#SBATCH --mem=32G
#SBATCH --time=1-0
#SBATCH --job-name=prediction-both-step-1-step-2-combined-remaining_small-27-v3
#SBATCH --output=../step_1_step_2_combined/output/prediction_both_step_1_step_2_combined_remaining_small_27_v3_%j.out
#SBATCH --err=output/prediction_both_step_1_step_2_combined_remaining_small_27_v3_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0

cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd /home/schen123/scratch/kinases/sbc806/RumHKNet_develop/src/
# cat transformer_step_2_4_1.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_2/transformer/output/transformer_step_2_4_1_$SLURM_JOB_ID.txt
./prediction_scripts/step_1_step_2_combined/both/prediction_both_step_1_step_2_combined_v3.sh 0.2 02 unique_clustered_rep_seq_All140086RBAGs_95_90_remaining_small_27 1500 50 _v3


deactivate


