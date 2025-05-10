# VAU1-Brain-Polycomb-ncRNA-2025

## Authors
- **[Chicherin Ivan](https://github.com/Ivan-chich)**, Bioinformatics Institute (Saint-Petersburg)
- **[Kulenich Victoria](https://github.com/vickulenich/)**, Bioinformatics Institute (Saint-Petersburg)
- **[Nazarova Alina](https://github.com/)**, Bioinformatics Institute (Saint-Petersburg)

## Introduction
Polycomb is a set of proteins that regulate gene expression, especially in the human brain. They form long-range DNA loops between genes, and those loops spread gene repression programs. However, many loops are formed not between genes, but between some non-coding RNAs. Maybe some of them are brain-specific and/or have interesting functions?

## Raw data
You can find the data that was necessary for analysis in the `data` folder:
- `60591892-d938-4cdb-8545-3d84d5c16571.h5ad` - Single-cell RNA sequencing data, too large for GitHub, avaliable on [Human Brain Cell Atlas](https://cellxgene.cziscience.com/collections/283d65eb-dd53-496d-adb7-7570c7caa443)
- `polycomb_dots_hand_coords_update.tsv`, `Polycomb_proteins.csv` - Tables of genes Polycomb proteins was connected with and the Polycomb genes info
- datasets for TFs
- `ncrna_genes.txt` - List of ncRNA gene names
- `lncRNA_interaction.txt`,`miRNA_interaction.txt`,`snRNA_interaction.txt` - ncRNA interactions datasets, too large for GitHub, avaliable on [Google Drive](https://drive.google.com/drive/folders/1LXdX8x9EYX3MBPDHqZ87whL4-T9Ruhbc?usp=drive_link)
- `ncrna_targets_uniprot.txt` - List of Uniprot KB IDs for target genes
- `ncrna_targets_enrichment_results.csv` - Table of GO Enrichment analysis results for targets
- `ncrna_targets_id_conversion.txt` - List of Ensemble IDs for Polycomb, ncRNA and target genes


## Content
You can find the following results in the `notebooks` folder:
- notebooks for TFs
- *[03_ncRNA_analysis.ipynb](https://github.com/)*


## Results
### TF

### ncRNA
1. **Genes of interest selection**
We extracted all gene names from `polycomb_dots_hand_coords_update.tsv` file. The HGNC database ([HUGO Gene Nomenclature Committee](https://www.genenames.org/)[^1]) was chosen to identify ncRNAs, as it was the most up-to-date and extensive at the time of the study. The corresponding identifiers for the original list of genes were found using the online tool [SynGo](https://www.syngoportal.org/convert)[^2]. In total, 396 genes out of the original 482 had corresponding identifiers. 98 out of 396 were classified as one of the non-coding RNA classes: 86 - long ncRNA, 11 - micro RNA, 1 - small nuclear RNA.

2. **Targets searching**
The ncRNA targets were searched using [GeneCaRNA](https://www.genecards.org/genecarna)[^3],[^4] and [NPInter v5.0](http://bigdata.ibp.ac.cn/npinter5)[^5] databases. GeneCaRNA database contained less information about interactions, so we decided to use the data from NPInter database. 662 unique targets were found. They formed 3109 different interactions with the studied non-coding RNAs in 262 tissues/cell lines. We explored functions and localization of targets due to GO Enrichment analysis performed with [goscripts package](https://github.com/pmoris/goscripts).

3. **Human Brain Cells data preprocessing**
We used single-cell RNA sequencing of [Middle Temporal Gyrus dataset](https://cellxgene.cziscience.com/collections/283d65eb-dd53-496d-adb7-7570c7caa443) downloaded from Human Brain Cell Atlas dataset v1.0[^6]. The data were filtered by neuron as a cell type and by genes of interest. Then it was preprocessed using scanpy[^7]. The data contained information about 405 of the genes of interest, after the filtration 377 genes and 85092 cells remained.

4. **Coexpression analysis**
Expression data contained lots of zeros so we decided to use [CSCORE package](https://github.com/ChangSuBiostats/CS-CORE_python)[^8] instead of classic correlation analysis. To prevent versions conflict we made changes in the `CSCORE_IRLS.py` script (`np.inf` instead of `np.Inf`).

## Conclusion
We can see ... (TFs). Also we can see that a number of non-coding RNA genes can be characterized by high co-expression with both Polycomb protein genes and target genes. We can conclude that the regulation of processes in the human brain is a much more complex process than we previously assumed. But using the obtained data it is possible to do further deeper functional analysis.

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