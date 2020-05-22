Markdown Exercises
=========================
Watch Jasmine learn markdown!

*italics*
**bold**

Make a new line by adding **2** spaces at end before hitting return.

-bullet1  
-bullet2  


give that a try  


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

Run ```funannotate train``` on sorted assembly to generate PASA gene models: [funannotate_train.sh](./funannotate_train.sh)
```  
TRINITY_OUT="/home/jlm329/scratch60/trinity_scratch60/Trinity_GG.max.intron.500.sort/Trinity_GG.max.intron.500.sort_outdir"
READS="/home/jlm329/project/trix/fastq"

funannotate train -i trichoplax.scaffolds.fa.masked -o fun_train.sort \
    -l $READS/KammSenatoreAll_R1.fastq.gz \
    -r $READS/KammSenatoreAll_R2.fastq.gz \
    --trinity $TRINITY_OUT/Trinity-GG.max.intron500.sort.fasta \
    --species "Trichoplax adhaerens" \
    --cpus 10 \
    --TRINITYHOME='/home/jlm329/project/conda_envs/funannotate/opt/trinity-2.8.5/'
```  

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
Run ```funannotate predict``` on sorted assembly with evidence:  
```  
funannotate predict -i /home/jlm329/scratch60/funannotate_scratch60/predict/trichoplax.scaffolds.fa.masked \
    --species "Trichoplax adhaerens" \
    --out fun_predict.sort \
    --rna_bam $RNA/Tad_KammSenatore.merged.sort.bam \
    --optimize_augustus \
    --transcript_evidence /home/jlm329/scratch60/funannotate_scratch60/train/fun_train.sort/training/funannotate_train.trinity-GG.fasta \
    --pasa_gff /home/jlm329/scratch60/funannotate_scratch60/train/fun_train.sort/training/funannotate_train.pasa.gff3 \
    --busco_db metazoa --max_intronlen 15000 \
    --organism other -d /home/jlm329/project/trix/funannotate_db --cpus 8 \
    --repeats2evm 
 ```  
Predict output:  
```  
Program        Training-Method
  augustus       pasa           
  codingquarry   rna-bam        
  glimmerhmm     pasa           
  snap           pasa           
  Feature       Specificity   Sensitivity
  nucleotides   97.2%         96.3%      
  exons         89.4%         89.7%      
  genes         39.4%         39.0%      
  Feature       Specificity   Sensitivity
  nucleotides   97.1%         96.5%      
  exons         88.8%         89.9%      
  genes         43.8%         43.1%      
  Source         Weight   Count
  Augustus       1        4502 
  Augustus HiQ   2        7950 
  CodingQuarry   2        17978
  GlimmerHMM     1        16357
  pasa           6        7310 
  snap           1        17128
  Total          -        71225
```  
  


###