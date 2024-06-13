#!/bin/bash
#
#SBATCH --job-name="qc"
#SBATCH -o qc.o%j
#SBATCH -e qc.e%j
#SBATCH --mail-user=<>
#SBATCH --mail-type=ALL
#SBATCH --partition="highmem","normal"

module load plink2
plink2 --bfile c1_22_regenie --maf 0.01 --mac 100 --geno 0.1 --hwe 1e-15 --mind 0.1 --write-snplist --write-samples --no-id-header --out qc/qc_pass
