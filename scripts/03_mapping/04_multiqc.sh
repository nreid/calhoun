#!/bin/bash
#SBATCH --job-name=multiqc
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --mem=5G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

#################################################################
# Aggregate reports using MultiQC
#################################################################

module load MultiQC/1.9

# run on samtool stats output
multiqc -f -o ../../results/samtools_stats_multiqc ../../results/samtools_stats

# run on qualimap output
multiqc -f -o ../../results/qualimap_multiqc ../../results/qualimap_reports