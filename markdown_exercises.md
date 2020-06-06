Markdown Exercises
=========================
Watch Jasmine learn markdown!

*italics*
**bold**

Make a new line by adding **2** spaces at end before hitting return.

-bullet1  
-bullet2  


give that a try

- Parse out eggNOG gene names and transfer to gff3 file from ```funannotate annotate``` run using [eggParse.py](./eggParse.py) by Ben Evans.  
```   
#output is hardcoded on line 47. Chose `Trichoplax_adhaerens_with_eggnog_names.gff3`.
module load Python/3.7.0-foss-2018b
python eggParse.py Trichoplax_adhaerens.gff3 query_seqs.fa.emapper_MM__83if57l.annotations 
```  
Went from 752 gene names to 6,653!    

### Genome Browser  
- Downsample reads for genome browser.  
```  
module load SAMtools/1.9-foss-2018b  
# These are the trimmed RNAseq reads.  
samtools view -bs 42.01 Tad_KammSenatore.merged.sort.bam > Tad_KammSenatore.merged.sort.subsampled.bam  
```  
TBD...  

### Synteny Analysis  
- Convert gff3 file from ```funannotate annotate``` to bed.  
```  
module load BEDOPS  
gff2bed < Trichoplax_adhaerens.gff3 > Trichoplax_adhaerens.bed  
```  


  
  






