#!/bin/bash
#SBATCH --job-name=buscoProt
#SBATCH -p general
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=4G
#SBATCH -t 0-01:00:00
#SBATCH -o busco.predict1%j.finalannotprot.sort.out
#SBATCH -e busco.predict1%j.finalannotprot.sort.err
#SBATCH --mail-user=jasmine.mah@yale.edu
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

cd /home/jlm329/scratch60/busco_scratch60

# -z for compressed output -> doesn't work for BUSCO4 

#BUSCO run for output from funannotate predict that was run with no extra evidence.  
#singularity exec ~/project/trix/busco/busco4.sif busco \
#       -i /home/jlm329/scratch60/funannotate_scratch60/predict_simple/fun_predict_nosort.simple/predict_results/Trichoplax_adhaerens.proteins.fa \
#       --cpu 16 \
#       -o BUSCO_nosort_simple \
#       -l /home/jlm329/project/trix/busco/metazoa_odb10 -m prot
       
#BUSCO on proteins from funannotate predict     
#singularity exec ~/project/trix/busco/busco4.sif busco \
#       -i /home/jlm329/scratch60/funannotate_scratch60/predict/fun_predict.sort/predict_results/Trichoplax_adhaerens.proteins.fa \
#       --cpu 16 \
#       -o BUSCO_predict1 \
#      -l /home/jlm329/project/trix/busco/metazoa_odb10 -m prot

#BUSCO on final proteins from funannotate annotate    
singularity exec ~/project/trix/busco/busco4.sif busco \
       -i /home/jlm329/scratch60/funannotate_scratch60/predict/fun_predict.sort/annotate_results/Trichoplax_adhaerens.proteins.fa \
       --cpu 16 \
       -o BUSCO_annot \
      -l /home/jlm329/project/trix/busco/metazoa_odb10 -m prot