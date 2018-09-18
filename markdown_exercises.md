Markdown Attempts
=========================
Notebook
================
Casey Dunn
9/14/2018

Introduction and goals
----------------------

The objective of these analyses is...

Data wrangling
--------------

The first dataset we consider is for \[1\]. The data link provided in the paper is <http://compgenomics.weizmann.ac.il/tanay/?page_id=99>. This is a link to multiple studies, the relevant one seems to be this one - <http://compgenomics.weizmann.ac.il/tanay/?page_id=791>. The pages says "The archive can be downloaded here" but there is no link. There is a link to raw sequence data at <https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE111068> .

Fincher et al. 2018 \[2\], Plass et al. 2018 \[3\] and Karaiskos et al. 2017 \[4\] used DropSeq rather than MARS-seq. My current understanding is that DropSeq produces digital gene expression (DGE) matrices, where the first row are individual identifiers for each cell, and columns are genes. For Fincher \[2\], aaq1736_Table-S1 links the cell identifiers in the DGE to specific clusters/subclusters, but so far I can't find a similar document for Plass \[3\] and Karaiskos [\4\]. It must be somewhere so I will keep looking.

**Fincher et al. 2018, *Schmidtea mediterranea*:**  
- Raw data: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE111764  
- Files/Folders:  
aaq1736_Table-S1: cell descriptions - links cell identifier to cluster  
aaq1736_Table-S2: cluster and subcluster-enriched genes  
aaq1736_Table-S3  
aaq1736_Table-S4  
aaq1736_Table-S5  
dd_Smed_v4.nuc.fasta: eference transcriptome for reads from asexual animals  
uc_Smed_v2: reference transcriptome for reads from sexual animals; downloaded from http://hdl.handle.net/2142/28689, renamed from 'Supplementary File 1.txt'  
raw_DGE folder: raw digital gene expression matrices  

**Plass et al. 2018, *Schmidtea mediterranea*:**
- Raw data: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE103633
- Files/Folders:  
*dd_Smed_v6: reference transcriptome
*GSE103633_RAW.tar: raw DGE matrices

**Karaiskos et al. 2017, *Drosophila melanogaster*:**
- Files/folders:  
GSE95025_RAW.tar: raw digital expression matrices  
GSE95025_high_quality_cells_digital_expression.txt  

References
----------

1. Sebe-Pedros A, Chomsky E, Pang K, Lara-Astiaso D, Gaiti F, Mukamel Z, et al. Early metazoan cell type diversity and the evolution of multicellular gene regulation. Nature Gioscience. Nature Publishing Group; 2018;2: 1176–1188. doi:[10.1038/s41559-018-0575-6](https://doi.org/10.1038/s41559-018-0575-6)

2. Fincher C, Wurtzel O, de Hoog T, Kravarik K, Reddien P. Cell type transcriptome atlas for the planarian *Schmidtea mediterranea*. Science; 2018;eaaq1736. doi:[10.1126/science.aaq1736](https://doi.org/10.1126/science.aaq1736)

3. Plass M, Solana J, Wolf F, Ayoub S, Misios A, Glazar P, Obermayer B, Theis F, Kocks C, Rajewsky N. Cell type atlas and lineage tree of a whole complex animal by single-cell transcriptomics. Science; 2018;eaaq1723. doi:[10.1126/science.aaq1723](https://doi.org/10.1126/science.aaq1723)

4. Karaiskos N, Wahle P, Alles J, Boltengagen A, Ayoub S, Kipar C, Kocks, C, Rajewsky N, Zinzen R. The *Drosophila* embryo at single-cell transcriptome resolution. Science; 2017;358(6360): 194-199. doi:[10.1126/science.aan3235](https://doi.org/10.1126/science.aan3235)