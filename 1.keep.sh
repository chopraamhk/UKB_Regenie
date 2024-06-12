#!/bin/bash
#
#SBATCH --job-name="r_keep"
#SBATCH -o r_keep.o%j
#SBATCH -e r_keep.e%j
#SBATCH --mail-user=<>
#SBATCH --mail-type=ALL
#SBATCH --partition="highmem","normal"

#code
module load Anaconda3/2024.02-1
conda activate plink
plink --merge-list list.txt --keep wbi_icd10 --make-bed --out ../ukb_genotype_mri_passed/output/regenie/c1_22_regenie
