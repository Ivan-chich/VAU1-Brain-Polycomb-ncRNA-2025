# Brain Polycomb project lab notebook

Links:

- https://web.telegram.org/a/#-4738561813
- https://github.com/Ivan-chich/VAU1-Brain-Polycomb-ncRNA-2025
- https://app.holst.so/share/b/8b0c40b1-920a-461f-83ad-9014988b04e6
- https://msuru-my.sharepoint.com/:f:/g/personal/i_v_chicherin_g_lecturer_msu_ru/ErGoHKfAJ9FIq5EO8DY3Z_YBtj9RGZTYBWhUgU6FtfvR3Q

*Date: 30.01.2025*

Create Project folder **VAU1_2025**:

```{}
$ cd ~/BI/
$ mkdir VAU1_2025
```

Create environment:

```{}
$ conda create -n vau1_env python numpy pandas matplotlib seaborn scipy anaconda
```

Tasks:

- parse table TF, non-TF, ncRNA
- expression TFs, Targets
- ncRNA databases: find targets and expression

*Date: 11.02.2025*

### **View data in R:**

```{}
setwd('/home/ivan/BI/VAU1_2025')
df <- read.csv('polycomb_dots_hand_coords_update.tsv', sep = '\t')
View(df)
```

### **Extract genes**

We start with `polycomb_dots_hand_coords_update.tsv`

We use custom script `parce_tsv.py` to get gene list

**Total number of genes: 482**

Save result as **polycomb gene_list**

*Date: 19.02.2025*

### **Find DNA-binding proteins**

#### **Uniprot ID mapping**

DNA-binding properties are in a separate column

Saved as `idmapping_2025_02_11.tsv`

#### **GO annotations**

Visit https://go.princeton.edu/

Follow **Generic GO Term Finder**

Choose options:

- Ontology Aspects: Function
- Choose annotation: GOA + HGNC Xrefs - H. sapiens (Human)
- Choose Your Output Format: HTML table + GO tree view images

Save results in **GO_annotations/GO_term_finder** folder

Follow **Generic GO Term Mapper**

Choose options:

- Ontology Aspects: Function
- Organism: Homo sapiens (GOA @EBI + Ensembl)
- Choose Your Output Format: HTML table

Save results in **GO_annotations/GO_term_mapper** folder

Save both HTML pages in the corresponding folders

### **Find Partners for each factor**

Options:

- UniProt https://www.uniprot.org
- BioGRID https://thebiogrid.org
- STRING https://string-db.org
- KEGG https://www.kegg.jp
- NCBI https://ncbi.nlm.nih.gov/gene

More options:

- TRANSFAC: https://genexplain.com/transfac-product/
- ChIP-Atlas: https://chip-atlas.org/
- Ensembl: https://www.ensembl.org/index.html
- GeneCards: https://www.genecards.org/

Bioconductor R packages:

- CoRegNet http://bioconductor.riken.jp/packages/3.1/bioc/html/CoRegNet.html
- FGNet https://bioconductor.org/packages/release/bioc/html/FGNet.html

Uniprot ID Mapping: results saved as `idmapping_2025_02_19.tsv`
These results are protein-protein interactions - **not what we want!**

Useful link: https://www.biostars.org/p/2148/

### **TFTenricher**: doesn't work

Guide: https://github.com/rasma774/Tftenricher

Create Environment:

```{}
$ conda create -n TFTenricher python=3.9 numpy pandas matplotlib scipy
$ conda activate TFTenricher
```

Install:

```{}
$ git clone git@github.com:rasma774/TFTenricher.git
$ cd ./TFTenricher/
$ pip install .
```

**This script is not functional. Try something else.**

### **Tftargets**:

https://github.com/slowkow/tftargets/blob/master/README.md


```{}
install.packages('aliases2entrez')
```

Check the link:
https://www.gtexportal.org/home/multiGeneQueryPage

Run `GOtermsFinderFunction.py`. Read comments! It gives TF list

Apply printed TF list in `code/rtargets.R`

Run `code/rtargets.R` script. Read comments! It gives TF target list. Do not clear global environment in Rstudio: data will be required in the next script!

Run `code/go_enrichment_BP.R`