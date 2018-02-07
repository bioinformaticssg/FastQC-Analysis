#!/bin/bash

#$ -N fastQC_04             # name of the job
#$ -o /data/users/$USER/BioinformaticsSG/FastQC-Analysis/fastqc_04.out   # contains what would normally be printed to stdout (the$
#$ -e /data/users/$USER/BioinformaticsSG/FastQC-Analysis/fastqc_04.err   # file name to print standard error messages to. These m$
#$ -q free64,som,asom       # request cores from the free64, som, asom queues.
#$ -pe openmp 8-64          # request parallel environment. You can include a minimum and maximum core count.
#$ -m beas                  # send you email of job status (b)egin, (e)rror, (a)bort, (s)uspend
#$ -ckpt blcr               # (c)heckpoint: writes a snapshot of a process to disk, (r)estarts the process after the checkpoint is c$

module load blcr
module load fastqc/0.11.5   # use the second to latest version, the newest version (0.11.7) does not work at the moment

DATA_DIR=/data/users/$USER/BioinformaticsSG/griffith_data/reads
QC_OUT_DIR=/data/users/$USER/BioinformaticsSG/FastQC-Analysis/fastqc_results_04
QC_HTML_DIR=/data/users/$USER/BioinformaticsSG/FastQC-Analysis/fastqc_results_04/fastqc_html_04
HTML="fastqc_html_04"

mkdir -p ${QC_OUT_DIR}          # Making the result file directory
mkdir -p ${QC_HTML_DIR}         # Making the HTML result file directory

for FILE in `find ${DATA_DIR} -name \*`; do         # Performing a loop that will use each file in the data directory, "*" is a wild card symbol and in this context matches any file in the indicated directory
    fastqc $FILE \                                  # Each file will be processed with the program "fastqc", "\" symbol indicates that more options for the program are on the next line
    -o ${QC_OUT_DIR}                                # This indicates the output directory for the result files
    
    mv ${QC_OUT_DIR}/*.html ${QC_HTML_DIR}          # Moves the HTML result files to the new HTML result file directory
done

tar -C ${QC_OUT_DIR} -czvf ${HTML}.tar.gz ${HTML}   # Compresses the HTML result file. 
                                                    # -C flag prevents the parent directories from being included in the archive
                                                    # -csvf (c)reate archive, use g(z)ip for compression, (v)erbosely shows the .tar file progress, (f)ilename appears next in the command
 
