#!/bin/bash

#$ -N fastQC_01                # name of the job
#$ -o /data/users/$USER/BioinformaticsSG/FastQC-Analysis/fastqc_01.out   # contains what would normally be printed to stdout (the$
#$ -e /data/users/$USER/BioinformaticsSG/FastQC-Analysis/fastqc_01.err   # file name to print standard error messages to. These m$
#$ -q free64,som,asom       # request cores from the free64, som, asom queues.
#$ -pe openmp 8-64          # request parallel environment. You can include a minimum and maximum core count.
#$ -m beas                  # send you email of job status (b)egin, (e)rror, (a)bort, (s)uspend
#$ -ckpt blcr               # (c)heckpoint: writes a snapshot of a process to disk, (r)estarts the process after the checkpoint is c$

module load blcr
module load fastqc/0.11.7

# The directory where the data we want to analyze is located
DATA_DIR=/data/users/$USER/BioinformaticsSG/griffith_data/reads
# The directory where we want the result files to go
QC_OUT_DIR=/data/users/$USER/BioinformaticsSG/FastQC-Analysis/fastqc_01      

# The file we want to analyze
FILE="HBR_1_R1.fq.gz"       

# Making the result file directory
mkdir -p ${QC_OUT_DIR}     

# Here we are performing a loop that will use each file in our data directory as input
# Each file will be processed with the program "fastqc", "\" symbol indicates that more options for the program are on the next line 
# (--outdir) indicates the output directory for the result files

for FILE in `find ${DATA_DIR} -name ${FILE}`; do
    fastqc $FILE \
    --outdir ${QC_OUT_DIR}
done
