model <- readRDS('re/eigengenes.rds')
egi <- model$eigengenes

pheno <- readRDS('../data/pheno.rds')
pheno$age <- scale(pheno$age)

s <- ncol(pheno)
egi$id <- rownames(egi)
dat <- merge(pheno, egi, by='id')
n <- ncol(dat)
table(dat$group)

re <- data.frame(path=rep('', (n-s)), p=rep(0, (n-s)), p2=rep(0, (n-s)))

cnt <- 0
for(i in (s+1):n){
  cnt <- cnt + 1
  fit <- t.test(dat[, i] ~ dat$group)
  re$path[cnt] <- colnames(dat)[i]
  re$p[cnt] <- fit$p.value
  
  fit <- lm(dat[, i] ~ dat$group + dat$age + dat$sex + dat$race + dat$tobacco)
  re$p2[cnt] <- summary(fit)$coefficients[2,4]
}

re <- re[order(re$p2), ]
re$padj2 <- p.adjust(re$p2, method='BH')
write.csv(re, 're/net_module_FEP_HC.csv', row.names=F)
