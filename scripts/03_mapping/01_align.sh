#!/bin/bash
#SBATCH --job-name=align
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 8
#SBATCH --mem=25G
#SBATCH --partition=xeon
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mia.nahom@uconn.edu
#SBATCH -o %x_%A_%a.out
#SBATCH -e %x_%A_%a.err
#SBATCH --array=[1-24]

echo `hostname`

#################################################################
# Align reads to genome
#################################################################
module load hisat2/2.2.1
module load samtools/1.16.1

INDIR=../../results/trimmed_sequences
OUTDIR=../../results/alignments
mkdir -p ${OUTDIR}


# align using hisat2 to ENSEMBL v105 human genome. already indexed and on xanadu
INDEX=/isg/shared/databases/alignerIndex/animal/homo_sapiens/105/HISAT2/Homo_sapiens

META=../../meta/metadata.txt

NUM=${SLURM_ARRAY_TASK_ID}

SAMPLE=$(cat ${META} | sed -n ${NUM}p )
echo ${SAMPLE}

# run hisat2
hisat2 \
        -p 6 \
        -x $INDEX \
        -1 $INDIR/${SAMPLE}_trim_1.fastq.gz \
        -2 $INDIR/${SAMPLE}_trim_2.fastq.gz | \
samtools view -@ 1 -S -h -u - | \
samtools sort -@ 1 -T ${SAMPLE} - >${OUTDIR}/${SAMPLE}.bam

# index bam files
samtools index ${OUTDIR}/${SAMPLE}.bam