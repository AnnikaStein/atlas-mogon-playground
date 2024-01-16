#!/bin/bash

#========[ + + + + Requirements + + + + ]========#
#SBATCH --partition=smp
#SBATCH --account=atlashpc

#========[ + + + + Job Steps + + + + ]========#
srun echo "Hello, world!"

