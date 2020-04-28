Markdown Exercises
=========================
Watch Jasmine learn markdown!

*italics*
**bold**

Make a new line by adding **2** spaces at end before hitting return.

-bullet1  
-bullet2  


give that a try  

### Trinity Assembly  
Genome guided Trinity to assemble Kamm/Senatore reads. Max intron size chosen as 500 bp since max intron length in Trichoplax is 243 bp.    
Trinity version 2.9.1 executed in a singularity container in Farnam:    
```  
singularity exec trinityrnaseq.v2.9.1.simg Trinity --genome_guided_bam Tad_KammSenatore_merged.bam --genome_guided_max_intron 5000 --max_memory 250G --CPU 20  
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