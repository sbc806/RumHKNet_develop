#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus-per-node=h100:1
#SBATCH --mem=32G
#SBATCH --time=1-0
#SBATCH --job-name=prediction-both-step-1-9342-all-proteins-newrun-1-large-sorted
#SBATCH --output=output/prediction_both_step_1_9342_all_proteins_newrun_1_large_sorted_%j.out
#SBATCH --err=output/prediction_both_step_1_9342_all_proteins_newrun_1_large_sorted_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0

cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd /home/schen123/scratch/kinases/sbc806/RumHKNet_develop/src/
# cat transformer_step_2_4_1.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_2/transformer/output/transformer_step_2_4_1_$SLURM_JOB_ID.txt
./prediction_scripts/step_1/both/prediction_both_step_1.sh 0.2 02 9342_all_proteins_newrun_1_large_sorted 34551 _v2


deactivate
