#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus-per-node=h100:1
#SBATCH --mem=32G
#SBATCH --time=1:0:0
#SBATCH --job-name=prediction-both-step-2-sequences-2026-04-22-large-1
#SBATCH --output=output/prediction_both_step_2_sequences_2026_04_22_large_1_%j.out
#SBATCH --err=output/prediction_both_step_2_sequences_2026_04_22_large_1_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0

cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd /home/schen123/scratch/kinases/sbc806/RumHKNet_develop/src/
# cat transformer_step_2_4_1.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_2/transformer/output/transformer_step_2_4_1_$SLURM_JOB_ID.txt
./prediction_scripts/step_2/both/prediction_both_step_2.sh 0.2 02 2026_04_22_clustered95_rep_seq_step_1_kinase_large_1 34551 _v2


deactivate
