#!/bin/bash
#
#SBATCH --job-name="s2"
#SBATCH -o s2.o%j
#SBATCH -e s2.e%j
#SBATCH --mail-user=<>
#SBATCH --mail-type=ALL
#SBATCH --partition="highmem","normal"

module load Anaconda3/2024.02-1
conda activate regenie_env
regenie --step 2 
        --bgen c1_22_regenie.bgen 
        --phenoFile ../all.phenos 
        --covarFile ../traits/covars_100K.txt 
        --qt
#       --firth --approx      #firth is if we have given a binary trait. It will not work in the case of a continuous variable, and we havea  continuous variable - age :D 
        --interaction age
        --pred ../step1/ukb_step1_sim_pred.list 
        --bsize 400 
        --out test_bin_out
