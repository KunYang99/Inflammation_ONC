# Inflammation_ONC

This is a data depository for the following publication:

Kun Yang, Yuto Hasegawa, Janardhan P Bhattarai, Jun Hua, Milan Dower, Semra Etyemez, Neal Prasad, Lauren Duvall, Adrian Paez, Amy Smith, Yingqi Wang, Yun-Feng Zhang, Andrew P. Lane, Koko Ishizuka, Vidyulata Kamath, Minghong Ma, Atsushi Kamiya, and Akira Sawa. Inflammation-related pathology in the olfactory epithelium: its impact on the olfactory system in psychotic disorders. <b><i>Mol. Psychiatry</i></b>, 2024 (in press)

## Data
The "data" folder contains bulk RNA-Seq data from olfactory neuronal cells of 59 healthy controls and 44 patients with first episode psychosis.
* pheno.rds --- R object containing phenotipic information
* count_table.rds --- R object containing counts for each gene (row) and each sample (column)
* TPM.rds --- R object containing TPM (Transcripts Per Million) values for each gene (row) and each sample (column)

## Analysis 
* "DEG" folder --- contains codes for differential expression analysis
* "WGCNA" folder --- contains codes for weighted correlation network analysis
* "PubMed" folder --- contains codes for literature mining of PubMed

