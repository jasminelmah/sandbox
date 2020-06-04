Markdown Exercises
=========================
Watch Jasmine learn markdown!

*italics*
**bold**

Make a new line by adding **2** spaces at end before hitting return.

-bullet1  
-bullet2  


give that a try


Run ```funannotate update``` to fix gene models: [update.sh](./update.sh)
```  
funannotate update -i ../predict/fun_predict.sort/ --cpus 10 \
  -l KammSenatoreAll_R1.fastq.gz \
  -r KammSenatoreAll_R2.fastq.gz	
```  
Results:   
```   
Total Gene Models:	13,181
Total transcripts:	13,863
New Gene Models:	94
No Change:		7,666
Update UTRs:		5,409
Exons Changed:		11
Exons/CDS Changed:	1
Dropped Models:		0
CDS AED:		0.006
mRNA AED:		0.077
```  



- Run ```eggNOG-mapper``` using the online submission portal [here](http://eggnog-mapper.embl.de/).  
Settings: taxonomic scope: auto adjust for each query; orthology restrictions: transfer annotation from any ortholog; GO evidence: experimental; minimum e-value: 0.001, minimum bitscore: 60, minimum % query coverage: 20; minimum % subject coverage: 0. With the exception of the GO evidence, these are the default settings.  
Output: query_seqs.fa.emapper_MM__83if57l.annotations  

- Run ```funannotate annotate```: [annotate.sh](./annotate.sh)  
```  
funannotate annotate -i /home/jlm329/scratch60/funannotate_scratch60/predict/fun_predict.sort \
    --gff /home/jlm329/scratch60/funannotate_scratch60/predict/fun_predict.sort/update_results/Trichoplax_adhaerens.gff3 \
    --genbank /home/jlm329/scratch60/funannotate_scratch60/predict/fun_predict.sort/update_results/Trichoplax_adhaerens.gbk \
    --species "Trichoplax adhaerens" \
    --eggnog /home/jlm329/scratch60/funannotate_scratch60/annotate/query_seqs.fa.emapper_MM__83if57l.annotations \
    --iprscan /home/jlm329/scratch60/interproscan_scratch60/trichoplax_IPS.xml \
    --busco_db metazoa \
    --cpus 16
 ```  
 First run produced this error:  
 ```  
 [06/04/20 01:40:55]:   File "/gpfs/ysm/project/dunn/jlm329/conda_envs/funannotate/lib/python2.7/site-packages/funannotate/aux_scripts/funannotate-BUSCO2.py", line 65
    print "AUGUSTUS_CONFIG_PATH environmental variable not set, exiting"
          ^
SyntaxError: Missing parentheses in call to 'print'. Did you mean print("AUGUSTUS_CONFIG_PATH environmental variable not set, exiting")?
```  
Added parentheses to this line in ```funannotate-BUSCO.py``` and it worked.  
  






