library(DESeq2)
library(sva)

pheno <- readRDS('../data/pheno.rds')
pheno$age <- scale(pheno$age)

edata <- readRDS('../data/count_table.rds')
table(names(edata) == pheno$id)

# filter noise
minsample <- min(table(pheno$group))
edata <- edata[which(rowSums(edata > 10) > minsample), ]

# sva
mod <- model.matrix(~as.factor(group), data = pheno)
mod0 <- cbind(mod[ ,1])
svobj <- svaseq(as.matrix(edata), mod, mod0, n.sv=1)
sv <- as.data.frame(svobj$sv)
pheno.sva <- cbind(pheno, sv) 

# run DESeq
dds <- DESeqDataSetFromMatrix(countData = round(edata), colData = pheno.sva, design= ~ group + age + sex + race + tobacco + V1)
dds <- DESeq(dds)

# store analysis results
re <- results(dds, contrast=c("group","Patient","Control"), alpha=0.05)
re <- re[order(re$pvalue),]
re$padj <- p.adjust(re$pvalue, method='BH')
sig <- subset(re, padj < 0.05)
print(paste(nrow(sig), 'sig genes found'))
write.csv(re, 're/deseq2_coding_FEP_HC.csv')
