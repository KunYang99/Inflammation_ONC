library(DESeq2)
library(sva)

pheno <- readRDS('../data/pheno.rds')

edata <- readRDS('../data/count_table.rds')
table(names(edata) == pheno$id)

# filter noise
minsample <- min(table(pheno$group))
edata <- edata[which(rowSums(edata > 10) > minsample), ]

# sva
mod <- model.matrix(~as.factor(group), data = pheno)
mod0 <- cbind(mod[ ,1])
n.sv <- num.sv(edata, mod, method="be")

print(n.sv)
