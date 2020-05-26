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

Symbolic link the predict output folder to the training output folder:  
```cd ~/scratch60/funannotate_scratch60/predict/fun_predict.sort && ln -s ~/scratch60/funannotate_scratch60/train/fun_train.sort/training .```  

Install and run ```interproscan```.  
- You can follow the instructions in this repo [here](https://github.com/dunnlab/xenoturbella_annotation#functional-annotation).   
- I had trouble with installation. Funannotate has [instructions](https://funannotate.readthedocs.io/en/latest/tutorials.html) on how to use an interproscan docker image, and I converted the docker image into a singularity image. Funannotate uses the Blaxter Lab's interproscan image, which can be found [here](https://hub.docker.com/r/blaxterlab/interproscan/).  
-script: [interproscan.sh](./interproscan.sh)
```  
#Singularity is not installed in login nodes on Farnam, so use interactive:  
srun --pty -p interactive -c 2 bash

#Create Singularity image from Docker 
singularity build interproscan.img docker:blaxterlab/interproscan:latest

#Run Interproscan
singularity exec ~/project/trix/interproscan.img interproscan.sh \
-i /home/jlm329/scratch60/funannotate_scratch60/predict/fun_predict.sort/update_results/Trichoplax_adhaerens.proteins.fa \
-b interproscan.sort \
-f TSV \
--goterms

```  


