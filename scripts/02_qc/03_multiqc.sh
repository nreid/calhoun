#!/bin/bash
#SBATCH --job-name=multiqc
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

hostname
date

#################################################################
# Aggregate reports using MultiQC
#################################################################

module load MultiQC/1.9

# run on fastp output
multiqc -f -o ../../results/fastp_multiqc ../../results/fastp_reports

# run on fastqc output
multiqc -f -o ../../results/fastqc_multiqc ../../results/fastqc_reports