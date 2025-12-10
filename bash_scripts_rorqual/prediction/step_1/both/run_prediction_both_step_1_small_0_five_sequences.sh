#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus-per-node=h100:1
#SBATCH --mem=32G
#SBATCH --time=0:5:0
#SBATCH --job-name=prediction-both-step-1-small-0-v3-five-sequences
#SBATCH --output=output/prediction_both_step_1_small_0_v3_five_sequences_%j.out
#SBATCH --err=output/prediction_both_step_1_small_0_v3_five_sequences_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/19.0.1

cd /home/schen123/links/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/
# cat transformer_step_2_4_1.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_2/transformer/output/transformer_step_2_4_1_$SLURM_JOB_ID.txt
./prediction_scripts/step_1/both/prediction_both_step_1_v3_rorqual.sh 0.3 03 clustered_rep_seq95_small_0_five_sequences 1500 50 _v3


deactivate



