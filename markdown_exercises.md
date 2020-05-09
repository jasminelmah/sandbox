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

Trim with Trimmomatic: [trimm.sh](./trimm.sh)  
```
trimmomatic PE -threads 10 -phred33 senatore.R1_cat.fastq.gz senatore.R2_cat.fastq.gz trimmed/senatore_R1.paired.trimmed.fastq.gz trimmed/senatore_R1.unpaired.trimmed.fastq.gz trimmed/senatore_R2.paired.trimmed.fastq.gz trimmed/senatore_R2.unpaired.trimmed.fastq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:4:5 LEADING:5 TRAILING:5 MINLEN:25  

trimmomatic PE -threads 10 -phred33 kamm.R1.fastq.gz kamm.R2.fastq.gz trimmed/kamm_R1.paired.trimmed.fastq.gz trimmed/kamm_R1.unpaired.trimmed.fastq.gz trimmed/kamm_R2.paired.trimmed.fastq.gz trimmed/kamm_R2.unpaired.trimmed.fastq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:4:5 LEADING:5 TRAILING:5 MINLEN:25  
```
### Align reads to previous Trichoplax assembly  
Alignment of all libraries at once was too burdensome. Aligned the four Senatore libraries (SRR8674648, SRR8674649, SRR8674650, SRR8674651) and Kamm reads separately. eg. [hisat2_samtools.sh](./hisat2_samtools.sh)  

```   
hisat2 -p 20 \
  --rg-id "RGID_Tad_Kamm" --rg "RG_Tad_Kamm" \
  --summary-file /home/jlm329/project/trix/fastq/trimmed/hisat2/Tad_Kamm_hisat2.aln.stats --new-summary \
  -x /home/jlm329/project/trix/fastq/trimmed/hisat2/Tad_2019-29 \
  -1 ../kamm_R1.paired.trimmed.fastq.gz -2 ../kamm_R2.paired.trimmed.fastq.gz \
  | samtools view -bhuS - | samtools sort - -m 100G -o Tad_Kamm.bam  

```  
etc. with the other libraries.  
Then merge with samtools: [samtoolsmerge.sh](./samtoolsmerge)  
```  
samtools merge Tad_KammSenatore_merged.bam Tad_Kamm.bam SRR8674648.bam SRR8674649.bam SRR8674650.bam SRR8674651.bam  
```  

### Trinity Assembly  
Genome guided Trinity to assemble Kamm/Senatore reads. Max intron size chosen as 500 bp since max intron length in Trichoplax is 243 bp.    

Trinity version 2.9.1 executed in a singularity container in Farnam: [trinity_jm_v2.9.1.sh](./trinity_jm_v2.9.1)    
```  
singularity exec trinityrnaseq.v2.9.1.simg Trinity --genome_guided_bam Tad_KammSenatore_merged.bam --genome_guided_max_intron 500 --max_memory 250G --CPU 20  
```   

Transcriptome statistics:  
```  
################################
## Counts of transcripts, etc.
################################
Total trinity 'genes':  61000
Total trinity transcripts:      93274
Percent GC: 34.48
########################################
Stats based on ALL transcript contigs:
########################################
        Contig N10: 8455
        Contig N20: 6422
        Contig N30: 5254
        Contig N40: 4354
        Contig N50: 3610
        Median contig length: 638
        Average contig: 1619.13
        Total assembled bases: 151022434

####################################################
## Stats based on ONLY LONGEST ISOFORM per 'GENE':
#####################################################
        Contig N10: 7635
        Contig N20: 5583
        Contig N30: 4318
        Contig N40: 3361
        Contig N50: 2523
        Median contig length: 382
        Average contig: 971.13
        Total assembled bases: 59238653
``` 
### 