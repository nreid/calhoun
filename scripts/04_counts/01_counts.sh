#!/bin/bash
#SBATCH --job-name=htseq_count
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 5
#SBATCH --mem=40G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

echo `hostname`
date

#################################################################
# Generate Counts 
#################################################################
module load htseq/0.13.5
module load parallel/20180122

INDIR=../../results/alignments
OUTDIR=../../results/counts
mkdir -p ${OUTDIR}

# accession list
META=../../meta/metadata.txt

# gtf annotation is required here. already on xanadu. ENSEMBL 105
GTF=/isg/shared/databases/alignerIndex/animal/homo_sapiens/105/Homo_sapiens.GRCh38.105.gtf

# run htseq-count on each sample, up to 5 in parallel
tail -n +2 ${META} | cut -f 1 | \
parallel -j 5 \
    "htseq-count \
        -s no \
        -r pos \
        -f bam $INDIR/{}.bam \
        $GTF \
        > $OUTDIR/{}.counts"