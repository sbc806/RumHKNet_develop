#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus-per-node=h100_3g.40gb:1
#SBATCH --mem=32G
#SBATCH --time=4-0
#SBATCH --job-name=2026_04_27_transformer-step-3-batch
#SBATCH --output=output/2026_04_27_transformer_step_3_batch_%j.out
#SBATCH --err=output/2026_04_27_transformer_step_3_batch_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/19.0.1


cd /home/schen123/links/projects/def-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet_develop/src/training/V3
cat 2026_04_27_transformer_step_3_batch.sh > /home/schen123/links/projects/def-guanuofa/schen123/kinases/sbc806/RumHKNet_develop/bash_scripts_rorqual/step_3/transformer/output/2026_04_27_transformer_step_3_batch_$SLURM_JOB_ID.txt
./2026_04_27_transformer_step_3_batch.sh


deactivate
