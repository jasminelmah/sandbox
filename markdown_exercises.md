Markdown Exercises
=========================
Watch Jasmine learn markdown!

*italics*
**bold**

Make a new line by adding **2** spaces at end before hitting return.

-bullet1  
-bullet2  


give that a try  



### Align reads to sorted Trichoplax assembly  
Aligned trimmed reads to ```scaffolds.reduced.sort.fa```, the _sorted and renamed_ scaffolds created with ```funannotate sort```. All new files created herein include 'sort' in its name.   

I first created the hisat2 [genome index](./hisat2_gen_index.sh).  
```  
hisat2-build scaffolds.reduced.sort.fa Tad_2019-29.sort  
```  
Then the four Senatore libraries (SRR8674648, SRR8674649, SRR8674650, SRR8674651) and the Kamm reads were aligned separately. eg. see script [hisat2_samtools.sh](./hisat2_samtools.sh).   

```   
hisat2 -p 20 \
  --rg-id "RGID_Tad_Kamm.sort" --rg "RG_Tad_Kamm.sort" \
  --summary-file /home/jlm329/scratch60/hisat2_scratch60/Tad_Kamm_hisat2.sort.aln.stats --new-summary \
  -x /home/jlm329/scratch60/hisat2_scratch60/Tad_2019-29.sort \
  -1 ~/project/trix/fastq/trimmed/kamm_R1.paired.trimmed.fastq.gz -2 ~/project/trix/fastq/trimmed/kamm_R2.paired.trimmed.fastq.gz \
  | samtools view -bhuS - | samtools sort - -m 100G -o Tad_Kamm.sort.bam  
```  
etc. with the other libraries.  

_Current position_: I will continue to correct the following as I move fowards.   

Then merge with samtools: [samtoolsmerge.sh](./samtoolsmerge)  
```  
samtools merge Tad_KammSenatore.merged.sort.bam SRR8674648.sort.bam SRR8674649.sort.bam SRR8674650.sort.bam SRR8674651.sort.bam Tad_Kamm.sort.bam
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
### Funannotate  
Install funannotate, download funannotate db, confirm successful installation:  
```  
#confirm all dependencies installed. If signalp version is > 4.1, will show up as error but will not affect annotation pipeline. Install ete3 and emapper.py manually.  
funannotate check --show-versions  
#download BUSCO metazoa db
funannotate setup -i all -b metazoa -d funannotate_db  
#confirm successful installation  
funannotate test -t all --cpus 10  
```  
Run funannotate train to generate PASA gene models using previously assembled genome-guided Trinity transcriptome: [funnannotate_train.sh](./funannotate_train.sh)  
```  
funannotate train -i trichoplax.scaffolds.fa.masked -o fun_train \
    -l $READS/KammSenatoreAll_R1.fastq.gz \
    -r $READS/KammSenatoreAll_R2.fastq.gz \
    --trinity $TRINITY_OUT/Trinity-GG_max500.fasta \
    --species "Trichoplax adhaerens" \
    --cpus 10 \
    --TRINITYHOME='/home/jlm329/project/conda_envs/funannotate/opt/trinity-2.8.5/'
  ```  

First run of ```funanannotate train``` came back with empty files and this slurm error  buried in the job error file:    
```  
slurmstepd: error: _is_a_lwp: open() /proc/27543/status failed: No such file or directory  
```
Reran without changing anything and was successful.  



###