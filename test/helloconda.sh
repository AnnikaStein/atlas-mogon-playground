#!/bin/bash

#========[ + + + + Requirements + + + + ]========#
#SBATCH --partition=smp
#SBATCH --account=atlashpc
#SBATCH -J conda_test
#SBATCH -o conda_test.%j.out

#========[ + + + + Job Steps + + + + ]========#
srun echo "Hello, world!"
# User specific aliases and functions

# ATLAS setup
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
alias setupATLAS='source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh'

function conda_initialize {
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/anstein/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/anstein/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/anstein/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/anstein/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
}

export SPANETENV=/home/anstein/ttbar/SPANet/spanet-env

conda_initialize
conda activate $SPANETENV
python -c "import torch;print(torch.cuda.is_available())"
