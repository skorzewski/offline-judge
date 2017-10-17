#!/bin/bash

TASK=$1

for outfile in ${TASK}??????.ou
do
    echo ${outfile}
    paste ${TASK}.in ${TASK}.exp ${outfile} | grep -vP '\t(.*)\s?\t\1' | column -nts$'\t'
done
