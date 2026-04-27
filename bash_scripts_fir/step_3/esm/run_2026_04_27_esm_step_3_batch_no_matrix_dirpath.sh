#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus=nvidia_h100_80gb_hbm3_3g.40gb:1
#SBATCH --mem=100G
#SBATCH --time=7:0:0
#SBATCH --job-name=2026-04-27-esm-step-3-batch-no-matrix-dirpath
#SBATCH --output=output/2026_04_27_esm_step_3_batch_no_matrix_dirpath_%j.out
#SBATCH --err=output/2026_04_27_esm_step_3_batch_no_matrix_dirpath_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/19.0.1


cd /home/schen123/scratch/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet_develop/src/training/V3
cat 2026_04_27_esm_step_3_batch_no_matrix_dirpath.sh > /home/schen123/scratch/kinases/sbc806/RumHKNet/bash_scripts_fir/step_3/esm/output/2026_04_27_esm_step_3_batch_no_matrix_dirpath_$SLURM_JOB_ID.txt
./2026_04_27_esm_step_3_batch_no_matrix_dirpath.sh


deactivate





