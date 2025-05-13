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


{ for f in out_*_AAo_distensibility.regenie; do tail -n +2 "$f"; done; } > 1_22_all.regenie
#or a better way to do this-- 
{ for f in $(ls out_*_AAo_distensibility.regenie | sort -t'_' -k2,2n); do tail -n +2 "$f"; done; } > 1_22_all.regenie


awk -F'\t' -v col=13 'BEGIN {OFS="\t"} NR==1 {print $0, "agec" col} NR>1 {print $0, $col - 54.85}' bolt_covars.txt > bolt_covars_agec.txt

