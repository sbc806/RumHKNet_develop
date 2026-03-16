#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus=h100:1
#SBATCH --mem=256G
#SBATCH --time=7-0
#SBATCH --job-name=esm-step-1-step-2-combined-no-matrix-dirpath
#SBATCH --output=output/esm_step_1_step_2_combined_no_matrix_dirpath_%j.out
#SBATCH --err=output/esm_step_1_step_2_combined_no_matrix_dirpath_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0


cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd /home/schen123/scratch/kinases/sbc806/RumHKNet_develop/src/training/V3
cat esm_step_1_step_2_combined_no_matrix_dirpath.sh > /home/schen123/scratch/kinases/sbc806/RumHKNet_develop/bash_scripts_nibi/step_1/esm/output/esm_step_1_step_2_combined_no_matrix_dirpath_$SLURM_JOB_ID.txt
./esm_step_1_step_2_combined_no_matrix_dirpath.sh


deactivate
