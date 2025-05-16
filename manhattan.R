#For quick manhattan plot
```{r}
library(qqman)
age_int <-  read.table("/home/mchopra/Documents/PhD-Year1/snpXage_regenie/AGE_ADD-INT_SNPxAGE_1_22.regenie", header = TRUE, sep = " ")

# Rename columns for qqman
manhattan_data <- data.frame(
  SNP = age_int$ID,
  CHR = age_int$CHROM,
  BP = age_int$GENPOS,
  P = 10^(-age_int$LOG10P)
)

manhattan_data

# Plot Manhattan
manhattan(manhattan_data, 
          genomewideline = -log10(5e-8), 
          suggestiveline = -log10(1e-5), 
          main = "SNP × Age Interaction GWAS")

colnames(age_int)  

age_int$P <- 10^(-age_int$LOG10P)

write.table(age_int, file = "/home/mchopra/Documents/PhD-Year1/snpXage_regenie/converted_p_AGE_ADD-INT_SNPxAGE_1_22.regenie", quote = F, row.names = F)
```

The above file can be used for FUMA input as well. P value threshold is 1e-5 - suggestive line (since not many SNPS crossed the genomewide line (5e-8).
