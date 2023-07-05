#!/bin/bash
#SBATCH --job-name=fastp_trimming
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 12
#SBATCH --mem=20G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

echo `hostname`
date

#################################################################
# Trimming/QC of reads using fastp
#################################################################
module load fastp/0.23.2
module load parallel/20180122

# set input/output directory variables
INDIR=../../data/mergedfiles/

REPORTDIR=../../results/fastp_reports
    mkdir -p $REPORTDIR
TRIMDIR=../../results/trimmed_sequences
    mkdir -p $TRIMDIR

META=../../meta/metadata.txt

# run fastp in parallel, 4 samples at a time
tail -n +2 $META | cut -f 1 | parallel -j 4 \
fastp \
	--in1 $INDIR/{}_Merged_R1.fastq.gz \
	--in2 $INDIR/{}_Merged_R2.fastq.gz \
	--out1 $TRIMDIR/{}_trim_1.fastq.gz \
	--out2 $TRIMDIR/{}_trim_2.fastq.gz \
	--json $REPORTDIR/{}_fastp.json \
	--html $REPORTDIR/{}_fastp.html