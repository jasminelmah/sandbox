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
