#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus-per-node=h100:1
#SBATCH --mem=64G
#SBATCH --time=4-0
#SBATCH --job-name=transformer-step-1-b16-g16
#SBATCH --output=output/transformer_step_1_b16_g16_%j.out
#SBATCH --err=output/transformer_step_1_b16_g16_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0


cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/training/V3
cat transformer_step_1_b16_g16.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_1/transformer/output/transformer_step_1_b16_g16_$SLURM_JOB_ID.txt
./transformer_step_1_b16_g16.sh


deactivate
