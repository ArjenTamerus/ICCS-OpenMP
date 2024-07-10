#!/bin/bash

set -x
set -e

PARTITION=pvc
TIME=03:00:00
SLURM_ACCOUNT=SUPPORT-GPU
#SLURM_ACCOUNT=TRAINING-DAWN-GPU


salloc -p pvc \
    -A ${SLURM_ACCOUNT} \
    -N 1 \
    --gres=gpu:1 \
    -t 4:0:0 \
    srun --interactive \
         --preserve-env \
         --pty /bin/bash
