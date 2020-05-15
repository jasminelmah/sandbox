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
Previous run with alignments to unsorted genome found that max intron 500 with Trinity v.2.9.1 produced the fewest number of genes (61,000).  

```
singularity exec ~/project/trix/trinity/trinityrnaseq.v2.9.1.simg Trinity --genome_guided_bam ~/scratch60/hisat2_scratch60/bam_files/Tad_KammSenatore.merged.sort.bam  --genome_guided_max_intron 500 --output Trinity_GG.max.intron.500.sort_outdir --max_memory 250G --CPU 20  
```  
Transcriptome statistics for genome-guided assembly on sorted genome.  
```  
################################
## Counts of transcripts, etc.
################################
Total trinity 'genes':  59341
Total trinity transcripts:      90797
Percent GC: 34.48

########################################
Stats based on ALL transcript contigs:
########################################

        Contig N10: 8545
        Contig N20: 6467
        Contig N30: 5302
        Contig N40: 4418
        Contig N50: 3653

        Median contig length: 638
        Average contig: 1642.93
        Total assembled bases: 149172970
        
#####################################################
## Stats based on ONLY LONGEST ISOFORM per 'GENE':
#####################################################

        Contig N10: 7715
        Contig N20: 5643
        Contig N30: 4377
        Contig N40: 3409
        Contig N50: 2595

        Median contig length: 379
        Average contig: 979.55
        Total assembled bases: 58127671
```  

### Funannotate  
Install funannotate, download funannotate db, confirm successful installation:  
```  
#install funannotate  
module load miniconda  
conda create -c conda-forge -c bioconda -n funannotate funannotate  

#install dependencies
#signalp: add executable to funannotate/bin/ and library to funannotate/lib.  
#ete3 and emapper.py (eggnog-mapper) by conda. Move emapper db (/data) to ~/miniconda2/lib/python2.7/site-packages

#confirm all dependencies installed.  
funannotate check --show-versions  

#download BUSCO metazoa db
funannotate setup -i all -b metazoa -d funannotate_db 

#confirm successful installation  
funannotate test -t all --cpus 10  
```  

Run ```funannotate train```: TBD  

Test run ```funannotate predict``` with no evidence:  
```  
module load Biopython/1.69-foss-2016a-Python-2.7.11

funannotate predict -i /home/jlm329/scratch60/funannotate_scratch60/train_simple/trichoplax.scaffolds.fa.masked \
            -o fun_train.no_sort.simple -s "Trichoplax adhaerens" --cpus 10 --organism other --busco_db metazoa
```  
Run BUSCO on protein sequences obtained from funannotate predict test run.  
```  
singularity exec ~/project/trix/busco/busco4.sif busco \
       -i /home/jlm329/scratch60/funannotate_scratch60/predict_simple/fun_predict_nosort.simple/predict_results/Trichoplax_adhaerens.proteins.fa \
       --cpu 16 \
       -o BUSCO_nosort_simple \
       -l /home/jlm329/project/trix/busco/metazoa_odb10 -m prot
```  
BUSCO results for predicted proteins from test run.  
```  
        C:84.6%[S:84.0%,D:0.6%],F:7.0%,M:8.4%,n:954        
        807     Complete BUSCOs (C)                        
        801     Complete and single-copy BUSCOs (S)        
        6       Complete and duplicated BUSCOs (D)         
        67      Fragmented BUSCOs (F)                      
        80      Missing BUSCOs (M)                         
        954     Total BUSCO groups searched    
```  



###