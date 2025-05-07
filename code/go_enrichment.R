# GO enrichment analysis:
# Read: https://yulab-smu.top/biomedical-knowledge-mining-book/clusterprofiler-go.html

# install "clusterProfiler"
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("clusterProfiler")

library("clusterProfiler")
data(geneList, package="DOSE")

# example data: rewrited in the next step
gene <- names(geneList)[abs(geneList) > 2]

# Take 'gene_entrez' from 'tftarget.R' script
gene <- gene_entrez

# Entrez gene ID
head(gene)

# Install database:
BiocManager::install("org.Hs.eg.db")
library (org.Hs.eg.db)

ggo <- groupGO(gene     = gene,
               OrgDb    = org.Hs.eg.db,
               ont      = "BP", # {"MF": 'molecular function', "BP": 'biological process', "CC": 'cellular localization'}
               level    = 3,
               readable = TRUE)

#head(ggo)

# BARPLOT:
# order=T: sort by abundance; default: sort by p-values
barplot(ggo, order=T, showCategory=20)

# Sorting along OY:
# https://support.bioconductor.org/p/9139934/

ego <- enrichGO(gene          = gene,
                universe      = names(geneList),
                OrgDb         = org.Hs.eg.db,
                ont           = "BP", # {"MF": 'molecular function', "BP": 'biological process', "CC": 'cellular localization'}
                pAdjustMethod = "BH",
                pvalueCutoff  = 0.01,
                qvalueCutoff  = 0.05,
                readable      = TRUE)
#head(ego)

gene.df <- bitr(gene, fromType = "ENTREZID",
                toType = c("ENSEMBL", "SYMBOL"),
                OrgDb = org.Hs.eg.db)

ego2 <- enrichGO(gene         = gene.df$ENSEMBL,
                 OrgDb         = org.Hs.eg.db,
                 keyType       = 'ENSEMBL',
                 ont           = "BP", # {"MF": 'molecular function', "BP": 'biological process', "CC": 'cellular localization'}
                 pAdjustMethod = "BH",
                 pvalueCutoff  = 0.01,
                 qvalueCutoff  = 0.05)
#head(ego2, 3)

ego3 <- gseGO(geneList     = geneList,
              OrgDb        = org.Hs.eg.db,
              ont          = "BP", # {"MF": 'molecular function', "BP": 'biological process', "CC": 'cellular localization'}
              minGSSize    = 100,
              maxGSSize    = 500,
              pvalueCutoff = 0.05,
              verbose      = FALSE)

goplot(ego)