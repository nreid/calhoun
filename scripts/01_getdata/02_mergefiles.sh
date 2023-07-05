#!/bin/bash
#SBATCH --job-name=mergelanes
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 12
#SBATCH --mem=15G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

echo `hostname`
date


###### merging files (concatenate)#########

INDIR=../../data/rawdata
OUTDIR=../../data/mergedfiles
mkdir -p ${OUTDIR}

META=../../meta/metadata.txt

###### Concatenate files together #########

for i in $(tail -n +2 ${META} | cut -f 1)
    do echo "Merging R1"

cat ${INDIR}/"$i"_L001_R1_001.fastq.gz $INDIR/"$i"_L002_R1_001.fastq.gz >> $OUTDIR/"$i"_Merged_R1.fastq.gz

       echo "Merging R2"

cat $INDIR/"$i"_L001_R2_001.fastq.gz $INDIR/"$i"_L002_R2_001.fastq.gz >> $OUTDIR/"$i"_Merged_R2.fastq.gz

done;