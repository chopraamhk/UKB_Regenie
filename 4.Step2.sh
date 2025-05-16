#!/bin/bash
#
#SBATCH --job-name="s2"
#SBATCH -o s2.o%j
#SBATCH -e s2.e%j
#SBATCH --mail-user=m.chopra1@universityofgalway.ie
#SBATCH --mail-type=ALL
#SBATCH --partition="highmem","normal"
#SBATCH --array=1-22

module load Anaconda3/2024.02-1
conda activate regenie
CHR=$SLURM_ARRAY_TASK_ID

regenie --step 2 \
        --bgen ../../../../wbi_removedICD10/bgen/chr${CHR}.bgen \
        --phenoFile ../../../../../phenotypes/norm_pheno_aao.txt \
        --covarFile ../../bolt_covars.txt \
        --qt --interaction AGE --pred ../step1/s1_mac10_${CHR}_age_pred.list \
        --bsize 1000 
        --out AGE_${CHR}


#combine all files and sort them from chr1 to 22  
{ for f in $(ls out_*_AAo_distensibility.regenie | sort -t'_' -k2,2n); do tail -n +2 "$f"; done; } > 1_22_all.regenie

#find unique tests and separate them to visualise and finding independent snps
 awk '{print $9}' AGE_1_22_AAo_distensibility.regenie | sort | uniq

#ADD-CONDTL
#ADD-INT_2DF
#ADD-INT_SNP
#ADD-INT_SNPxAGE

grep -w 'ADD-INT_SNP' AGE_1_22_AAo_distensibility.regenie > AGE_ADD-INT_SNP_1_22.regenie
grep 'ADD-CONDTL' AGE_1_22_AAo_distensibility.regenie > AGE_ADD-CONDTL_1_22.regenie
grep 'ADD-INT_2DF' AGE_1_22_AAo_distensibility.regenie > AGE_ADD-INT_2DF_1_22.regenie
grep 'ADD-INT_SNPxAGE' AGE_1_22_AAo_distensibility.regenie > AGE_ADD-INT_SNPxAGE_1_22.regenie

# Don't forget to add header in the above files..
#below was just to find the centred age - if we are interested in age_centered x snp interactions. age centered = age - mean 
awk -F'\t' -v col=13 'BEGIN {OFS="\t"} NR==1 {print $0, "agec" col} NR>1 {print $0, $col - 54.85}' bolt_covars.txt > bolt_covars_agec.txt
