#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus=nvidia_h100_80gb_hbm3_40g.43:1
#SBATCH --mem=100G
#SBATCH --time=5-0
#SBATCH --job-name=both-step-3-11-512-family-no-matrix-dirpath
#SBATCH --output=output/both_step_3_11_512_family_no_matrix_dirpath_%j.out
#SBATCH --err=output/both_step_3_11_512_family_no_matrix_dirpath_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0


cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/training/V3
cat both_step_3_11_family_no_matrix_dirpath.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_3/both/output/both_step_3_11_family_512_no_matrix_dirpath_$SLURM_JOB_ID.txt
./both_step_3_11_family_no_matrix_dirpath.sh


deactivate

