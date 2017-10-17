#!/bin/bash

TASK=$1

for outfile in ${TASK}??????.ou
do
    echo ${outfile}
    paste ${TASK}.in ${TASK}.exp ${outfile} | grep -v '\s\(\S*\)\s\1'
done
