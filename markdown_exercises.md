Markdown Exercises
=========================
Watch Jasmine learn markdown!

*italics*
**bold**

Make a new line by adding **2** spaces at end before hitting return.

-bullet1  
-bullet2  


give that a try

Pull out Hox sequences. Schierwater et al 2008 found 37. We did too.  
```  
## Pull out all proteins with PFAM homeodomain from gff3. 
grep -a "PF00046" Trichoplax_adhaerens_with_eggnog_names.gff3 > hox_domains_tad.gff3
## Add ##gff-version 3 to top of resulting file.
## Convert gff3 to bed
module load BEDOPS 
gff2bed < hox_domains_tad.gff3 > hox_domains_tad.bed

## Pull out correponding funannotate ids
grep -a "PF00046" Trichoplax_adhaerens_with_eggnog_names.gff3 |grep -o "FUN_\w*-T\w*" > hox_peptide_ids_tad.txt

## download FaSomeRecords
wget https://raw.githubusercontent.com/santiagosnchez/faSomeRecords/master/faSomeRecords.py
## change permissions
chmod u+x

## Sequence names in list must exactly match those in pep fasta. Regex:  
(FUN_.*)-T1
>$1-T1 $1
## save file as hox_peptide_ids_tad_corrected.txt

## Turns out there is one sequence that doesn't end in -T1. Just copy and paste the right name: >FUN_011002-T1 FUN_011002

## Pull out hox sequences
./faSomeRecords.py --fasta Trichoplax_adhaerens.proteins.fa --list hox_peptide_ids_tad_corrected.txt --outfile hox_proteins_tad.fa  
```   


  
  






