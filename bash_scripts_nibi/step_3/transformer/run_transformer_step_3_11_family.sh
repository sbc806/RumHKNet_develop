#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus-per-node=nvidia_h100_80gb_hbm3_3g.40gb:1
#SBATCH --mem=32G
#SBATCH --time=3-0
#SBATCH --job-name=transformer-step-3-11-family
#SBATCH --output=output/transformer_step_3_11_family_%j.out
#SBATCH --err=output/transformer_step_3_11_family_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0


cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/training/V3
cat transformer_step_3_11_family.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_3/transformer/output/transformer_step_3_11_family_$SLURM_JOB_ID.txt
./transformer_step_3_11_family.sh


deactivate
