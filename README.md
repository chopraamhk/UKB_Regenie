#Installation
```
module load Anaconda3/2024.02-1
conda create -n regenie_env -c conda-forge -c bioconda regenie
conda activate regenie_env
regenie --help
```

tutorial: https://rgcgithub.github.io/regenie/recommendations/

1. Keep.sh #merge all the chromosomes and keep only the samples you want to analyse
2. qc.sh ##to perform the quality checks
3. Regenie Step1
4. Regenie Step2
