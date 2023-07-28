#!/bin/bash
#SBATCH -A b1042
#SBATCH -p genomics-gpu
#SBATCH -t 16:00:00
#SBATCH -N 1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=120G
#SBATCH --ntasks-per-node=12
#SBATCH --mail-user=rogangrant2022@u.northwestern.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --job-name='230118_SCVI_integration'

module load R/4.1.1

Rscript /home/rag0151/aging_microglia_flu/230118_human_microglia_flu_SCVI_integration_cleaned.r