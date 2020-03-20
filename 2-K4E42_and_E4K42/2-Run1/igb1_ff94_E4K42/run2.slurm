#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J igb1_ff94_E4K42
#SBATCH --time=200:00:00     # Walltime
#SBATCH -A T2        # Project Account
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
##SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#SBATCH --gres=gpu:1
#
module add apps/amber-16
#
export MYDIR="/panfs/panasas01/bluegem-t2/el14718/5-Folding/10-K4E42_and_E4K42_folded_2/igb1_ff94_E4K42"
#
old=md1
cd $MYDIR
for name in md2; do
$AMBERHOME/bin/pmemd.cuda -O -i $name.i -o prot1_$name.mdout -p prot1_HMR.parm7 -c prot1_$old.rst7 -ref prot1_HMR.rst7 -x prot1_$name.nc -r prot1_$name.rst7 -inf prot1_$name.mdinfo
old=$name
done
