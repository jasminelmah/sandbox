Markdown Exercises
=========================
Watch Jasmine learn markdown!

*italics*
**bold**

Make a new line by adding **2** spaces at end before hitting return.

-bullet1  
-bullet2  


give that a try  

### Trimmomatic  
We have found two sets of paired-end RNAseq reads for Trichoplax (Grell line):  
- [Kamm et al. 2018](https://www.ncbi.nlm.nih.gov/sra/SRR5826498)  
- [Senatore lab (unpublished)](https://www.ncbi.nlm.nih.gov/sra/SRX5470589%5Baccn%5D)  

Senatore's had four libraries of reads. Concatenate them:  
```
cat SRR8674648_1.fastq SRR8674649_1.fastq SRR8674650_1.fastq SRR8674651_1.fastq > senatore.R1_cat.fastq
``` 
and repeat for R2.  

Reads renamed and gzipped:  
kamm.R1.fastq.gz and kamm.R2.fastq.gz: Kamm's reads just renamed  
senatore.R1_cat.fastq.gz and senatore.R2_cat.fastq.gz: concatenated reads  

Trim with Trimmomatic:  
```
trimmomatic PE -threads 10 -phred33 senatore.R1_cat.fastq.gz senatore.R2_cat.fastq.gz trimmed/senatore_R1.paired.trimmed.fastq.gz trimmed/senatore_R1.unpaired.trimmed.fastq.gz trimmed/senatore_R2.paired.trimmed.fastq.gz trimmed/senatore_R2.unpaired.trimmed.fastq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:4:5 LEADING:5 TRAILING:5 MINLEN:25  

trimmomatic PE -threads 10 -phred33 kamm.R1.fastq.gz kamm.R2.fastq.gz trimmed/kamm_R1.paired.trimmed.fastq.gz trimmed/kamm_R1.unpaired.trimmed.fastq.gz trimmed/kamm_R2.paired.trimmed.fastq.gz trimmed/kamm_R2.unpaired.trimmed.fastq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:4:5 LEADING:5 TRAILING:5 MINLEN:25  
```






