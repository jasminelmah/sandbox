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



Install and run ```interproscan```.   
- I had attempted to install ```Interproscan``` following the instructions from this repo [here](https://github.com/dunnlab/xenoturbella_annotation#functional-annotation) and, when that failed, attempted to run ```Interproscan``` from a singularity container converted from a docker container (which can be found here](https://hub.docker.com/r/blaxterlab/interproscan/)). Both failed, but if you want to read about what I did you can check ```401e659```.    
- In the end, Zack ran it for me with his installation (Interproscan v. 5.36-75.0). The script he used is [interproscan.sh](./interproscan.sh).  
- Output is ```trichoplax_IPS.xml```.  

