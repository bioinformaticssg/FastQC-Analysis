#!/bin/bash

#$ -N fastQC                # name of the job
#$ -o /data/users/$USER/BioinformaticsSG/FastQC/fastqc.out   # contains what would normally be printed to stdout (the$
#$ -e /data/users/$USER/BioinformaticsSG/FastQC/fastqc.err   # file name to print standard error messages to. These m$
#$ -q free64,som,asom       # request cores from the free64, som, asom queues.
#$ -pe openmp 8-64          # request parallel environment. You can include a minimum and maximum core count.
#$ -m beas                  # send you email of job status (b)egin, (e)rror, (a)bort, (s)uspend
#$ -ckpt blcr               # (c)heckpoint: writes a snapshot of a process to disk, (r)estarts the process after the checkpoint is c$

module load blcr
module load fastqc/0.11.5   # use the second to latest version, the newest version (0.11.7) does not work at the moment

DATA_DIR=/data/users/$USER/BioinformaticsSG/griffith_data/reads
QC_OUT_DIR=/data/users/$USER/BioinformaticsSG/FastQC/fastqc_01

FILE="HBR_1_R1.fq.gz"

mkdir -p ${QC_OUT_DIR}

for FILE in `find ${DATA_DIR} -name ${FILE}`; do 
    fastqc $FILE \
    -o ${QC_OUT_DIR}
done
