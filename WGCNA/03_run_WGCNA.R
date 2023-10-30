library(WGCNA)

datExpr <- readRDS('re/TPM_adj.rds')
power <- 7

net = blockwiseModules(datExpr, power = power, maxBlockSize = 10000,
                       TOMType = "unsigned", minModuleSize = 30,
                       reassignThreshold = 0, mergeCutHeight = 0.25,
                       numericLabels = TRUE, pamRespectsDendro = FALSE,
                       saveTOMs = FALSE,
                       saveTOMFileBase = "oneTOM",
                       deepSplit = 3,
                       corType = 'bicor',
                       verbose = 3)

saveRDS(net, "re/wgcna_all.rds")

moduleColors <- labels2colors(net$colors)
MEs <- moduleEigengenes(datExpr, moduleColors, softPower = power)
saveRDS(MEs, 're/eigengenes.rds')

map <- data.frame(gene = colnames(datExpr), module=moduleColors)
write.csv(map, 're/gene_module_all.csv', row.names=F)
