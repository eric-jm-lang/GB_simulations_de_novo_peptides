#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J igb8_ff99
#SBATCH --time=100:00:00     # Walltime
#SBATCH -A T2        # Project Account
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
##SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#SBATCH --gres=gpu:1
#
module add apps/amber-16
#
export MYDIR="/panfs/panasas01/bluegem-t2/el14718/5-Folding/9-3-A4_K4E4_A4_K4E4_A4_folded_2/igb8_ff99"
#
old=HMR
cd $MYDIR
for name in min1 min2 heat eq1 eq2 md1; do
$AMBERHOME/bin/pmemd.cuda -O -i $name.i -o prot1_$name.mdout -p prot1_HMR.parm7 -c prot1_$old.rst7 -ref prot1_HMR.rst7 -x prot1_$name.nc -r prot1_$name.rst7 -inf prot1_$name.mdinfo
old=$name
done
