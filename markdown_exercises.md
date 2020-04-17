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

Reads renamed and gzipped (big files - send in a job to gzip):  
kamm.R1.fastq.gz and kamm.R2.fastq.gz: Kamm's reads just renamed  
senatore.R1_cat.fastq.gz and senatore.R2_cat.fastq.gz: concatenated reads  

Trim with Trimmomatic:  
```
trimmomatic PE -threads 10 -phred33 senatore.R1_cat.fastq.gz senatore.R2_cat.fastq.gz trimmed/senatore_R1.paired.trimmed.fastq.gz trimmed/senatore_R1.unpaired.trimmed.fastq.gz trimmed/senatore_R2.paired.trimmed.fastq.gz trimmed/senatore_R2.unpaired.trimmed.fastq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:4:5 LEADING:5 TRAILING:5 MINLEN:25  

trimmomatic PE -threads 10 -phred33 kamm.R1.fastq.gz kamm.R2.fastq.gz trimmed/kamm_R1.paired.trimmed.fastq.gz trimmed/kamm_R1.unpaired.trimmed.fastq.gz trimmed/kamm_R2.paired.trimmed.fastq.gz trimmed/kamm_R2.unpaired.trimmed.fastq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:4:5 LEADING:5 TRAILING:5 MINLEN:25  
```


Hisat2/Samtools run: 

```  
hisat2 -p 20 \
  --rg-id "RGID_Tad_Kamm" --rg "RG_Tad_Kamm" \
  --summary-file /home/jlm329/project/trix/fastq/trimmed/hisat2/Tad_Kamm_hisat2.aln.stats --new-summary \
  -x /home/jlm329/project/trix/fastq/trimmed/hisat2/Tad_2019-29 \
  -1 ../kamm_R1.paired.trimmed.fastq.gz -2 ../kamm_R2.paired.trimmed.fastq.gz \
  | samtools view -bhuS - | samtools sort - -m 100G -o Tad_Kamm.bam
```  

Kamm alignment stats:    
```  
HISAT2 summary stats:
        Total pairs: 74046691
                Aligned concordantly or discordantly 0 time: 5652036 (7.63%)
                Aligned concordantly 1 time: 65949314 (89.06%)
                Aligned concordantly >1 times: 2008964 (2.71%)
                Aligned discordantly 1 time: 436377 (0.59%)
        Total unpaired reads: 11304072
                Aligned 0 time: 8108359 (71.73%)
                Aligned 1 time: 2971833 (26.29%)
                Aligned >1 times: 223880 (1.98%)
        Overall alignment rate: 94.52%
```   


