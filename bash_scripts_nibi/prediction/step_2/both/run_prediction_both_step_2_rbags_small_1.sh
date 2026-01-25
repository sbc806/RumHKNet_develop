#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus-per-node=h100:1
#SBATCH --mem=32G
#SBATCH --time=3-0
#SBATCH --job-name=prediction-both-step-2-small-02-1-v3
#SBATCH --output=output/prediction_both_step_2_small_02_1_v3_%j.out
#SBATCH --err=output/prediction_both_step_2_small_02_1_v3_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0

cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/
# cat transformer_step_2_4_1.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_2/transformer/output/transformer_step_2_4_1_$SLURM_JOB_ID.txt
./prediction_scripts/step_2/both/prediction_both_step_2_v3.sh 0.3 03 step_1_clustered_newrun_rbags_02_not_contained_small_1 1500 50 _v3


deactivate



