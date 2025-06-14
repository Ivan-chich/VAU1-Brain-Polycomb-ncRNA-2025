# VAU1-Brain-Polycomb-ncRNA-2025

## Authors
- **[Chicherin Ivan](https://github.com/Ivan-chich)**, Bioinformatics Institute (Saint-Petersburg)
- **[Kulenich Victoria](https://github.com/vickulenich/)**, Bioinformatics Institute (Saint-Petersburg)
- **[Nazarova Alina](https://github.com/privetttppoka)**, Bioinformatics Institute (Saint-Petersburg)

## Introduction
Polycomb is a set of proteins that regulate gene expression, especially in the human brain. They form long-range DNA loops between genes, and those loops spread gene repression programs. However, many loops are formed not between genes, but between some non-coding RNAs. Maybe some of them are brain-specific and/or have interesting functions?

## Raw data

You can find the data that was necessary for analysis in the `data` folder:

- `60591892-d938-4cdb-8545-3d84d5c16571.h5ad` - Single-cell RNA sequencing data, too large for GitHub, avaliable on [Human Brain Cell Atlas](https://cellxgene.cziscience.com/collections/283d65eb-dd53-496d-adb7-7570c7caa443)
- `polycomb_dots_hand_coords_update.tsv`, `Polycomb_proteins.csv` - Tables of genes Polycomb proteins was connected with and the Polycomb genes info
- Trancription factors datasets: [TRRUST](http://www.grnpedia.org/trrust/)[^9], [TRED](https://cb.utdallas.edu/cgi-bin/TRED/tred.cgi?process=home)[^10], [ENCODE](http://hgdownload.cse.ucsc.edu/goldenpath/hg19/encodeDCC/wgEncodeRegTfbsClustered/)[^11]. Operated via `code/tftargets.R` script
- `ncrna_genes.txt` - List of ncRNA gene names
- `lncRNA_interaction.txt`,`miRNA_interaction.txt`,`snRNA_interaction.txt` - ncRNA interactions datasets, too large for GitHub, avaliable on [Google Drive](https://drive.google.com/drive/folders/1LXdX8x9EYX3MBPDHqZ87whL4-T9Ruhbc?usp=drive_link)
- `ncrna_targets_uniprot.txt` - List of Uniprot KB IDs for target genes
- `ncrna_targets_enrichment_results.csv` - Table of GO Enrichment analysis results for targets
- `ncrna_targets_id_conversion.txt` - List of Ensemble IDs for Polycomb, ncRNA and target genes


## Content

#### Code folder:

- *[03_ncRNA_analysis.ipynb](https://github.com/)* analysis of ncRNAs
- *[correletion_counts.ipynb](https://github.com/privetttppoka/VAU1-Brain-Polycomb-ncRNA-2025/blob/Alina/code/correletion_counts.ipynb)* – single-cell data preprocessing, CS-CORE coexpression matrix construction
- *[tf_targets_search.ipynb](https://github.com/privetttppoka/VAU1-Brain-Polycomb-ncRNA-2025/blob/Alina/code/tf_targets_search.ipynb)* – Polycomb target gene extraction, transcription factor/target identification, GO annotation
- **`CS_CORE_PcG.ipynb`**: Polycomb genes coexpression, UMAPS and t-SNE done by Ivan Chicherin
- **`go_enrichment.R`**: R sctipt for GO terms enrichment
- **`GOtermsFinderFunction.py`**: script for filtration of GO annotation uotput based on selected terms
- **`parce_tsv.py`**: script for extraction of gene set from the dataset containing annotated chromosome long-range contacts
- **`tftargets.R`, `tftargets.rda`, `tftargets.RData`**: TFTARGET script and supplementary files for finding target genes regulated by transcription factors
- **`union_intersection.py`, `VennDiagrams.ipynb`**: scripts for building unions and intersections between gene sets found by two researchers (in this work: Ivan and Alina)

#### GO_annotations folder:

- The outputs for GO terms analysis of the target genes regulated by Polycomb-controlled transcription factors.
- The output is divided between two folders for `GO_term_finder` and `GO-term_mapper` tools
- in each tool output contains `Function`, `Pathway` and `Subcellular localization` terms

## Results

### TF
1. **Genes of interest selection and TF searching**  
We extracted all gene names from the `polycomb_dots_hand_coords_update.tsv` file. For selecting transcription factor genes, we used the databases [https://simchrom.intbio.org/](https://simchrom.intbio.org/) and [https://humantfs.ccbr.utoronto.ca/download.php](https://humantfs.ccbr.utoronto.ca/download.php). Out of 482 genes, 202 were selected as transcription factors.

2. **Transcription Factors targets searching**  
The targets of transcription factors were obtained using the [tftargets](https://github.com/slowkow/tftargets) package. For the selected transcription factors, a total of 664 targets were identified. Gene Ontology (GO) annotation was performed for these targets, and the results can be found in the file: `images/GO_enrichment_TF_targets.png`.

3. **Human Brain Cells data preprocessing**  
We used single-cell RNA sequencing data from the [Middle Temporal Gyrus dataset](https://cellxgene.cziscience.com/collections/283d65eb-dd53-496d-adb7-7570c7caa443), downloaded from the Human Brain Cell Atlas dataset v1.0[^6]. Standard preprocessing of single-cell data was performed using **scanpy**[^7]. All cell types were included in the subsequent analysis. We filtered the data based on genes of interest (Polycomb-Transcription Factors-targets), leaving 620 genes for further analysis.

4. **Coexpression analysis**  
The expression data contained many zeros, so we decided to use the [CSCORE package](https://github.com/ChangSuBiostats/CS-CORE_python)[^8] instead of classical correlation analysis. The resulting coexpression matrix can be found in the file: `images/coexpression_polycomb_TF_targets.pdf`.

### ncRNA
1. **Genes of interest selection**  
We extracted all gene names from `polycomb_dots_hand_coords_update.tsv` file. The HGNC database ([HUGO Gene Nomenclature Committee](https://www.genenames.org/)[^1]) was chosen to identify ncRNAs, as it was the most up-to-date and extensive at the time of the study. The corresponding identifiers for the original list of genes were found using the online tool [SynGo](https://www.syngoportal.org/convert)[^2]. In total, 396 genes out of the original 482 had corresponding identifiers. 98 out of 396 were classified as one of the non-coding RNA classes: 86 - long ncRNA, 11 - micro RNA, 1 - small nuclear RNA.

2. **Targets searching**  
The ncRNA targets were searched using [GeneCaRNA](https://www.genecards.org/genecarna)[^3],[^4] and [NPInter v5.0](http://bigdata.ibp.ac.cn/npinter5)[^5] databases. GeneCaRNA database contained less information about interactions, so we decided to use the data from NPInter database. 662 unique targets were found. They formed 3109 different interactions with the studied non-coding RNAs in 262 tissues/cell lines. We explored functions and localization of targets due to GO Enrichment analysis performed with [goscripts package](https://github.com/pmoris/goscripts).

3. **Human Brain Cells data preprocessing**  
We used single-cell RNA sequencing of [Middle Temporal Gyrus dataset](https://cellxgene.cziscience.com/collections/283d65eb-dd53-496d-adb7-7570c7caa443) downloaded from Human Brain Cell Atlas dataset v1.0[^6]. The data were filtered by neuron as a cell type and by genes of interest. Then it was preprocessed using scanpy[^7]. The data contained information about 405 of the genes of interest, after the filtration 377 genes and 85092 cells remained.

4. **Coexpression analysis**  
Expression data contained lots of zeros so we decided to use [CSCORE package](https://github.com/ChangSuBiostats/CS-CORE_python)[^8] instead of classic correlation analysis. To prevent versions conflict we made changes in the `CSCORE_IRLS.py` script (`np.inf` instead of `np.Inf`). The resulting coexpression matrix can be found in the file: images/coexpression.pdf

## Conclusion
Polycomb genes provide two-leveled mechanism of transcriptional control. The first level is composed of primary targets: transcription factors and ncRNAs. The second level involves secondary target genes directly regulated by primary targets. PcG genes, their primary (transcription factors) and secondary target genes have non-uniform coexpression pattern, which demonstrates discrete clusters of high positive and negative values. Also we can see that a number of non-coding RNA genes can be characterized by high co-expression with both Polycomb protein genes and target genes. We can conclude that the regulation of processes in the human brain is a much more complex process than we previously assumed. But using the obtained data it is possible to do further deeper functional analysis.

## Dependencies
This project was implemented using Windows 10 x64 and Ubuntu 22.04.2 LTS. The code was developed utilizing Python 3.12.0 (VSCode) and R 4.3.3 (RStudio). External libraries are utilized, so please upload the requirements.txt file to your virtual environment.

## References
[^1]: Seal RL, Braschi B, Gray K, Jones TEM, Tweedie S, Haim-Vilmovsky L, Bruford EA. Genenames.org: the HGNC resources in 2023. Nucleic Acids Res. PMID: 36243972 DOI: 10.1093/nar/gkac888
[^2]: Koopmans et al., 2019, Neuron. PMID:31171447
[^3]: GeneCaRNA: a comprehensive gene-centric database of human non-coding RNAs in the GeneCards Suite (PMID: 33676929; Citations: 98). Barshir R, Fishilevich F, Iny-Stein T, Zelig O, Mazor Y, Guan-Golan Y, Safran M, Lancet D. Journal of Molecular Biology (2021), 433 (11), p.166913, DOI: 10.1016/j.jmb.2021.166913
[^4]: Expanding and Enriching the LncRNA Gene–Disease Landscape Using the GeneCaRNA Database (Citations: 1). Aggarwal S., Rosenblum C., Gould M., Ziman S., Barshir R., Zelig O., Guan-Golan Y., Iny-Stein T., Safran M., Pietrokovski S., Lancet D. Biomedicines 2024, 12(6), 1305
[^5]: Yu Zheng, Huaxia Luo, Xueyi Teng, Xinpei Hao, Xiaoyu Yan, Yiheng Tang, Wanyu Zhang, Yuanxin Wang, Peng Zhang, Yanyan Li, Yi Zhao, Runsheng Chen, Shunmin He, NPInter v5.0: ncRNA interaction database in a new era, Nucleic Acids Research, Volume 51, Issue D1, 6 January 2023, Pages D232–D239, https://doi.org/10.1093/nar/gkac1002
[^6]: Kimberly Siletti et al., Transcriptomic diversity of cell types across the adult human brain. Science382, eadd7046(2023). DOI: 10.1126/science.add7046
[^7]: Wolf, F., Angerer, P. & Theis, F. SCANPY: large-scale single-cell gene expression data analysis. Genome Biol 19, 15 (2018). https://doi.org/10.1186/s13059-017-1382-0
[^8]: Su, C., Xu, Z., Shan, X. et al. Cell-type-specific co-expression inference from single cell RNA-sequencing data. Nat Commun 14, 4846 (2023). https://doi.org/10.1038/s41467-023-40503-7
[^9]: Han, H., Shim, H., Shin, D., Shim, J. E., Ko, Y., Shin, J., Kim, H., Cho, A., Kim, E., Lee, T., Kim, H., Kim, K., Yang, S., Bae, D., Yun, A., Kim, S., Kim, C. Y., Cho, H. J., Kang, B., Shin, S., … Lee, I. (2015). TRRUST: a reference database of human transcriptional regulatory interactions. Scientific reports, 5, 11432. https://doi.org/10.1038/srep11432
[^10]: Jiang, C., Xuan, Z., Zhao, F., & Zhang, M. Q. (2007). TRED: a transcriptional regulatory element database, new entries and other development. Nucleic acids research, 35(Database issue), D137–D140. https://doi.org/10.1093/nar/gkl1041
[^11]: ENCODE Project Consortium (2012). An integrated encyclopedia of DNA elements in the human genome. Nature, 489(7414), 57–74. https://doi.org/10.1038/nature11247
