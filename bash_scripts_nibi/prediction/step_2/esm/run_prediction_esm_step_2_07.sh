#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus-per-node=nvidia_h100_80gb_hbm3_2g.20gb:1
#SBATCH --mem=32G
#SBATCH --time=3:0:0
#SBATCH --job-name=prediction-esm-step-2
#SBATCH --output=output/prediction_esm_step_2_%j.out
#SBATCH --er=output/prediction_esm_step_2_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0

cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/
# cat transformer_step_2_4_1.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_2/transformer/output/transformer_step_2_4_1_$SLURM_JOB_ID.txt
./prediction_esm_step_2.sh 0.7 07


deactivate
