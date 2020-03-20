#!/bin/bash

for i in 8; do
  for j in  ff14SB ff94 ff98 ff99SBnmr; do #note that it is in oldff/leaprc.ff99 for example
    for k in E4K43 K4E43; do
    
      cd ../2-Run1/igb${i}_${j}_${k}
echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J 1_${i}_${j}_${k}
#SBATCH --time=72:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#SBATCH --gres=gpu:1
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh
#
cd \$SLURM_SUBMIT_DIR
#
old=md1
for name in md2; do
\$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o prot1_\$name.mdout -p prot1_HMR.parm7 -c prot1_\$old.rst7 -ref prot1_HMR.rst7 -x prot1_\$name.nc -r prot1_\$name.rst7 -inf prot1_\$name.mdinfo
old=\$name
done" >  md2.slurm


cd ../../1-Preparation

done
done
done



