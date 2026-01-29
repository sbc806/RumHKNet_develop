#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus-per-node=h100:1
#SBATCH --mem=32G
#SBATCH --time=1-0
#SBATCH --job-name=prediction-both-step-3-small-02-v4
#SBATCH --output=output/prediction_both_step_3_small_02_v4_%j.out
#SBATCH --err=output/prediction_both_step_3_small_02_v4_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0

cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/
# cat transformer_step_2_4_1.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_2/transformer/output/transformer_step_2_4_1_$SLURM_JOB_ID.txt
./prediction_scripts/step_3/both/prediction_both_step_3_v3.sh 0.3 03 step_3_clustered_newrun_rbags_predicted_02_small_remaining 1500


deactivate


