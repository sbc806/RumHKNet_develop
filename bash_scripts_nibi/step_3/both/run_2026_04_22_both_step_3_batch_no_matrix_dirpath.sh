#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus=h100:1
#SBATCH --mem=100G
#SBATCH --time=12:0:0
#SBATCH --job-name=2026-04-22-both-step-3-batch-no-matrix-dirpath
#SBATCH --output=output/2026_04_22_both_step_3_batch_no_matrix_dirpath_%j.out
#SBATCH --err=output/2026_04_22_both_step_3_batch_no_matrix_dirpath_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0


cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd /home/schen123/scratch/kinases/sbc806/RumHKNet_develop/src/training/V3
cat 2026_04_22_both_step_3_batch_no_matrix_dirpath.sh > /home/schen123/scratch/kinases/sbc806/RumHKNet_develop/bash_scripts_nibi/step_3/both/output/2026_04_22_both_step_3_batch_no_matrix_dirpath_$SLURM_JOB_ID.txt
./2026_04_22_both_step_3_batch_no_matrix_dirpath.sh


deactivate
