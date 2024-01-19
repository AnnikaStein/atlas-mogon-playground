#!/bin/bash

#========[ + + + + Requirements + + + + ]========#
#SBATCH --partition=smp
#SBATCH --account=atlashpc
#SBATCH -J spanet_test
#SBATCH -o spanet_test.%j.out
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mem-per-cpu 2828

#========[ + + + + Job Steps + + + + ]========#

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

# ======== Do the actual training ========
cd /home/anstein/ttbar/SPANet
python -m spanet.train -of options_files/full_hadronic_ttbar/example.json --gpus 0 >> this_log.txt
cp this_log.txt /gpfs/fs7/atlas/anstein/spanet_out/spanet_output/this_log.txt

