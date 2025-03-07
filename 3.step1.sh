#!/bin/bash
#
#SBATCH --job-name="s1"
#SBATCH -o s1.o%j
#SBATCH -e s1.e%j
#SBATCH --mail-user=<>
#SBATCH --mail-type=ALL
#SBATCH --partition="highmem","normal"

module load Anaconda3/2024.02-1
conda activate regenie_env

regenie --step 1 
        --bed c1_22_regenie 
        --extract qc/qc_pass.snplist 
        --keep qc/qc_pass.id 
        --phenoFile ../../phenotypes/norm_pheno_aao.txt 
        --covarFile ../../output/after_pca_wbi/makeCovar/qcovars7.txt 
        --qt --bsize 1000 --lowmem --lowmem-prefix tmpdir/regenie_tmp_preds 
        --out step1/test_step1_B
