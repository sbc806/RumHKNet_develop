#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus=h100_3g.40gb:1
#SBATCH --mem=80G
#SBATCH --time=3-0
#SBATCH --job-name=both-step-3-family-filtered-no-matrix-dirpath
#SBATCH --output=output/both_step_3_family_filtered_no_matrix_dirpath_%j.out
#SBATCH --err=output/both_step_3_family_filtered_no_matrix_dirpath_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/19.0.1


cd /home/schen123/links/projects/def-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806_3/RumHKNet/src/training/V3
cat both_step_3_family_filtered_no_matrix_dirpath.sh > /home/schen123/links/projects/def-guanuofa/schen123/kinases/sbc806_3/RumHKNet/bash_scripts_rorqual/step_3/both/output/both_step_3_family_filtered_no_matrix_dirpath_$SLURM_JOB_ID.txt
./both_step_3_family_filtered_no_matrix_dirpath.sh


deactivate
