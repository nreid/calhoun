#!/bin/bash
#SBATCH --job-name=getdata
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

hostname
date

# symlink data into data directory

# data are here: /archive/labs/CGI/CGI_Data/Jcalhoun_24RNASeq_May2023
ARCHDATA=/archive/labs/CGI/CGI_Data/Jcalhoun_24RNASeq_May2023

RAWDATA=../../data/rawdata
mkdir -p ${RAWDATA}

for FILE in $(find ${ARCHDATA} -name "*fastq.gz")
    do ln -s ${FILE} ${RAWDATA}/$(basename $FILE)
    done