#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus=h100:1
#SBATCH --mem=300G
#SBATCH --time=7-0
#SBATCH --job-name=both-step-1-no-matrix-dirpath
#SBATCH --output=output/both_step_1_no_matrix_dirpath_%j.out
#SBATCH --err=output/both_step_1_no_matrix_dirpath_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/19.0.1


cd /home/schen123/links/projects/def-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806_2/RumHKNet/src/training/V3
cat both_step_1_no_matrix_dirpath.sh > /home/schen123/links/projects/def-guanuofa/schen123/kinases/sbc806_2/RumHKNet/bash_scripts_rorqual/step_1/both/output/both_step_1_no_matrix_dirpath_$SLURM_JOB_ID.txt
./both_step_1_no_matrix_dirpath.sh


deactivate

