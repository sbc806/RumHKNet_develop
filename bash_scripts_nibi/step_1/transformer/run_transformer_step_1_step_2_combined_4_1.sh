#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus-per-node=h100_3g.40gb:1
#SBATCH --mem=32G
#SBATCH --time=3-0
#SBATCH --job-name=transformer-step-1-step-2-combined-4-1
#SBATCH --output=output/transformer_step_1_step_2_combined_4_1_%j.out
#SBATCH --err=output/transformer_step_1_step_2_combined_4_1_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0


cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd /home/schen123/scratch/kinases/sbc806/RumHKNet_develop/src/training/V3
cat transformer_step_1_step_2_combined_4_1.sh > /home/schen123/scratch/kinases/sbc806/RumHKNet_develop/bash_scripts_nibi/step_1/transformer/output/transformer_step_1_step_2_combined_4_1_$SLURM_JOB_ID.txt
./transformer_step_1_step_2_combined_4_1.sh


deactivate
