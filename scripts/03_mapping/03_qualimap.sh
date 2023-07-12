#!/bin/bash 
#SBATCH --job-name=qualimap
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=50G
#SBATCH --qos=general
#SBATCH --mail-user=
#SBATCH --partition=general

hostname
date

##################################
# calculate stats on alignments
##################################
# this time we'll use qualimap

# load software--------------------------------------------------------------------------
module load qualimap/2.2.1
module load parallel/20180122

# input, output directories--------------------------------------------------------------

INDIR=../../results/alignments
OUTDIR=../../results/qualimap_reports
mkdir -p ${OUTDIR}

# gtf annotation is required here. already on xanadu. ENSEMBL 105
GTF=/isg/shared/databases/alignerIndex/animal/homo_sapiens/105/Homo_sapiens.GRCh38.105.gtf

# accession list
META=../../meta/metadata.txt

# run qualimap in parallel
tail -n +2 ${META} | cut -f 1 | \
parallel -j 5 \
    qualimap \
        rnaseq \
        -bam ${INDIR}/{}.bam \
        -gtf ${GTF} \
        -outdir ${OUTDIR}/{} \
        --java-mem-size=10G  