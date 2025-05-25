library(rstudioapi)

# Getting the path of your current open file
current_path = rstudioapi::getActiveDocumentContext()$path 
setwd(dirname(current_path ))
print( getwd() )

# Recruit tftargets
devtools::install_github("slowkow/tftargets")

#install Bioconductor:limma
# https://www.bioconductor.org/packages/release/bioc/html/limma.html
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("limma")

# Install 'aliases2entrez':
# https://cran.rstudio.com/web/packages/aliases2entrez/aliases2entrez.pdf
# https://www.rdocumentation.org/packages/aliases2entrez/versions/0.1.2

install.packages('aliases2entrez')

# recruit libraruies:
library(aliases2entrez)
library(tftargets)
library(dplyr)

# read dataset
df = read.csv('/home/ivan/BI/VAU1_2025/GO_annotations/GO_term_mapper/Function/13613_slimTerms.tsv', sep='\t')

# take all transcription factors from 'GOtermsFinderFunction.py' output
dna_binding = c('ALX1', 'ALX4', 'ARX', 'BARHL1', 'BARHL2', 'BARX1', 'BHLHE22', 'BSX', 'CBX2', 'CDX2', 'DBX1', 'DLX1', 'DLX2', 'DLX5', 'DLX6', 'DMBX1', 'DMRT1', 'DMRT2', 'DMRT3', 'DMRTA2', 'EBF1', 'EBF2', 'EBF3', 'EMX2', 'EN1', 'EN2', 'EOMES', 'EVX2', 'FERD3L', 'FEZF1', 'FEZF2', 'FLI1', 'FOXA1', 'FOXA2', 'FOXB1', 'FOXB2', 'FOXC2', 'FOXD1', 'FOXD2', 'FOXD3', 'FOXE1', 'FOXF1', 'FOXL1', 'FOXL2', 'GATA2', 'GATA3', 'GATA4', 'GATA6', 'GBX2', 'GFI1', 'GSC', 'GSX2', 'GTF3C2', 'HAND1', 'HAND2', 'HEY2', 'HIST1H1B', 'HLX', 'HOXA1', 'HOXA10', 'HOXA11', 'HOXA13', 'HOXA2', 'HOXA3', 'HOXA4', 'HOXA5', 'HOXA6', 'HOXA7', 'HOXA9', 'HOXB1', 'HOXB2', 'HOXB3', 'HOXB4', 'HOXB5', 'HOXB6', 'HOXB7', 'HOXB8', 'HOXB9', 'HOXC10', 'HOXC11', 'HOXC12', 'HOXC13', 'HOXC4', 'HOXC5', 'HOXC8', 'HOXC9', 'HOXD1', 'HOXD10', 'HOXD11', 'HOXD12', 'HOXD13', 'HOXD3', 'HOXD4', 'HOXD8', 'HOXD9', 'IRX3', 'IRX5', 'ISL1', 'ISL2', 'LBX1', 'LEF1', 'LHX2', 'LHX4', 'LHX5', 'LHX6', 'LHX8', 'LHX9', 'LIN28B', 'LMX1A', 'LMX1B', 'MCIDAS', 'MECOM', 'MEIS1', 'MEIS2', 'MNX1', 'MSX1', 'MSX2', 'NEUROG2', 'NFIB', 'NKX2-3', 'NKX2-4', 'NKX2-5', 'NKX2-6', 'NKX6-1', 'NR2E1', 'NR2F2', 'NR4A2', 'NR5A2', 'OLIG1', 'OLIG2', 'OLIG3', 'ONECUT1', 'ONECUT2', 'OSR2', 'OTP', 'OTX2', 'PAX2', 'PAX3', 'PAX5', 'PAX6', 'PAX7', 'PAX8', 'PAX9', 'PHOX2B', 'PITX1', 'PITX2', 'POU4F1', 'POU4F2', 'POU4F3', 'PRDM1', 'PROX1', 'PTF1A', 'RUNX3', 'SALL1', 'SATB2', 'SHOX2', 'SIM1', 'SIM2', 'SIX1', 'SIX2', 'SIX3', 'SIX6', 'SKOR1', 'SKOR2', 'SOX1', 'SOX14', 'SOX17', 'SOX2', 'SOX21', 'SOX3', 'SP8', 'SP9', 'TAL1', 'TBR1', 'TBX15', 'TBX18', 'TBX2', 'TBX20', 'TBX3', 'TBX5', 'TCF21', 'TFAP2B', 'TFAP2D', 'TGIF1', 'TLX3', 'TWIST1', 'UNCX', 'VAX1', 'VAX2', 'VGLL2', 'WT1', 'ZFHX3', 'ZFHX4', 'ZIC1', 'ZIC2', 'ZIC3', 'ZIC4', 'ZIC5', 'ZNF883')

# Initialize empty vector
tf_targets = c()

# Iterate throughout 'dna_binding' and add results in 'tf_targets'
for (item in dna_binding){
  tf_targets <- c(tf_targets, TRRUST[[item]])
}

## Convert HGNC Symbol/Alias to Entrez:

# import the correspondence file
file <- system.file("extdata", "HGNC.txt", package = "aliases2entrez")
HGNC <- read.delim(file)

# run the main function
ids <- convert_symbols(tf_targets, HGNC)

# save converted names in 'gene_entrez' variable:
gene_entrez <- as.character(dplyr::pull(ids, entrezID))

# save results as file:
library(data.table)
fwrite(list(tf_targets), file = "../data/tf_targets.csv")
