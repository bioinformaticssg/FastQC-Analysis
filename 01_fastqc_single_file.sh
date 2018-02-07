#!/bin/bash

#$ -N fastQC_01                # name of the job
#$ -o /data/users/$USER/BioinformaticsSG/FastQC-Analysis/fastqc_01.out   # contains what would normally be printed to stdout (the$
#$ -e /data/users/$USER/BioinformaticsSG/FastQC-Analysis/fastqc_01.err   # file name to print standard error messages to. These m$
#$ -q free64,som,asom       # request cores from the free64, som, asom queues.
#$ -pe openmp 8-64          # request parallel environment. You can include a minimum and maximum core count.
#$ -m beas                  # send you email of job status (b)egin, (e)rror, (a)bort, (s)uspend
#$ -ckpt blcr               # (c)heckpoint: writes a snapshot of a process to disk, (r)estarts the process after the checkpoint is c$

module load blcr
module load fastqc/0.11.5   # use the second to latest version, the newest version (0.11.7) does not work at the moment

DATA_DIR=/data/users/$USER/BioinformaticsSG/griffith_data/reads              # The directory where the data we want to analyze is located
QC_OUT_DIR=/data/users/$USER/BioinformaticsSG/FastQC-Analysis/fastqc_01      # The directory where we want the result files to go

FILE="HBR_1_R1.fq.gz"       # The file we want to analyze

mkdir -p ${QC_OUT_DIR}      # Making the result file directory

for FILE in `find ${DATA_DIR} -name ${FILE}`; do       # Performing a loop that will use each file in our data directory
    fastqc $FILE \                                     # Each file will be processed with the program "fastqc", "\" symbol indicates that more options for the program are on the next line 
    -o ${QC_OUT_DIR}                                   # This indicates the output directory for the result files
done
