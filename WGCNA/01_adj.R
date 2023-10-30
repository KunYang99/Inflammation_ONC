library(DESeq2)
library(WGCNA)
library(sva)

# read phenotyping data
pheno <- readRDS('../data/pheno.rds')
pheno$age <- scale(pheno$age)

# filter noise
tpm <- readRDS('../data/TPM.rds')
table(names(tpm) == pheno$id)

tpm <- tpm[which(rowSums(tpm > 0.1) > 0.7*ncol(tpm)), ]
tpm <- log(tpm + 1)

# sva
mod <- model.matrix(~as.factor(group), data = pheno)
mod0 <- cbind(mod[ ,1])
svobj <- svaseq(as.matrix(tpm), mod, mod0, n.sv=1)
sv <- as.data.frame(svobj$sv)
pheno.sva <- cbind(pheno, sv) 

uwv <- data.matrix(pheno.sva[, c('age', 'race', 'sex', 'tobacco', 'V1')])
retCovMat <- data.matrix(pheno.sva[, c('group')])
eBLM <- empiricalBayesLM(data = t(tpm), removedCovariates = uwv, retainedCovariates = retCovMat, weights = NULL, weightType = "empirical", stopOnSmallWeights = TRUE, tol = 1e-4, maxIterations = 1000, scaleMeanToSamples = NULL, robustPriors = TRUE, automaticWeights = "bicov", aw.maxPOutliers = 0.1, verbose = 5, indent = 3)

saveRDS(eBLM$adjustedData, 're/TPM_adj.rds')
