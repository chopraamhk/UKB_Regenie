#!/bin/bash
#SBATCH --job-name="regenie_chr"
#SBATCH -o regenie_chr_%A_%a.out
#SBATCH -e regenie_chr_%A_%a.err
#SBATCH --array=1-22
#SBATCH --partition="highmem","normal"
#SBATCH --mail-user=m.chopra1@universityofgalway.ie
#SBATCH --mail-type=ALL

module load Anaconda3/2024.02-1
conda activate regenie

CHR=$SLURM_ARRAY_TASK_ID

regenie --step 1 \
  --bed /data3/mchopra/ukb_genotype_mri_passed/prune_wbi_icd10/ld_${CHR} \
  --extract /data3/mchopra/ukb_genotype_mri_passed/prune_wbi_icd10/mac_10/snps_pass_${CHR}.snplist \
  --phenoFile ../../../../../phenotypes/norm_pheno_aao.txt \
  --covarFile ../../bolt_covars.txt \
  --qt --bsize 1000 --lowmem \
  --lowmem-prefix ../../tmpdir/regenie_${CHR}_tmp \
  --out s1_mac10_${CHR}_age

