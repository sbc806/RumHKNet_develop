#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus-per-node=nvidia_h100_80gb_hbm3_3g.40gb:1
#SBATCH --mem=32G
#SBATCH --time=8:0:0
#SBATCH --job-name=prediction-both-step-2-9342-all-proteins-remove2-small-3
#SBATCH --output=output/prediction_both_step_2_9342_all_proteins_remove2_small_3_%j.out
#SBATCH --err=output/prediction_both_step_2_9342_all_proteins_remove2_small_3_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0

cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd /home/schen123/scratch/kinases/sbc806_1/RumHKNet_develop/src/
# cat transformer_step_2_4_1.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_2/transformer/output/transformer_step_2_4_1_$SLURM_JOB_ID.txt
./prediction_scripts/step_2/both/prediction_both_step_2.sh 0.2 02 9342_all_proteins_remove2_step_1_kinase_small_3 34551 _v2


deactivate
