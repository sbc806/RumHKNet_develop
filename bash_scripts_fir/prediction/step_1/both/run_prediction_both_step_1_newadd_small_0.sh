#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus-per-node=h100:1
#SBATCH --mem=32G
#SBATCH --time=3-0
#SBATCH --job-name=prediction-both-step-1-sequences-small-0
#SBATCH --output=output/prediction_both_step_1_sequences_small_0_%j.out
#SBATCH --err=output/prediction_both_step_1_sequences_small_0_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/19.0.1

cd /home/schen123/scratch/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/
# cat transformer_step_2_4_1.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_2/transformer/output/transformer_step_2_4_1_$SLURM_JOB_ID.txt
./prediction_scripts/step_1/both/prediction_both_step_1_v3_fir.sh 0.2 02 clustered_rep_seq95_small_10 1500 50 _v3


deactivate
