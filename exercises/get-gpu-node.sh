#!/bin/bash

# set -x
# set -e

PARTITION=ampere
TIME=04:00:00
SLURM_ACCOUNT=TRAINING-GPU

salloc --partition=${PARTITION} \
    --account=${SLURM_ACCOUNT} \
    --nodes=1 \
    --gres=gpu:1 \
    --time=04:00:00 \
    srun --interactive \
         --preserve-env \
         --pty /bin/bash
