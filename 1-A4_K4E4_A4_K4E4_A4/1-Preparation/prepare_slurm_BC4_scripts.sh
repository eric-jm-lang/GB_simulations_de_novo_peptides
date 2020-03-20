#!/bin/bash

for i in 1 2 5 8; do
  for j in ff99 ff99SB ff99SBildn ff99SBnmr ff96 ff94 ff14ipq ff98 ff14SB ff14SBonlysc ff03.r1 fb15 ff15ipq; do 
  
  cd ../igb${i}_${j}


  echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J igb${i}_${j}
#SBATCH --time=100:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#SBATCH --gres=gpu:1
#
module add OpenMPI/2.0.1-gcccuda-2016.10
AMBERHOME=\"/mnt/storage/scratch/el14718/SOFTWARE/amber16\"
#
export MYDIR=\"/mnt/storage/scratch/el14718/5-Folding/9-3-A4_K4E4_A4_K4E4_A4_folded_2/igb${i}_${j}\"
#
old=HMR
cd \$MYDIR
#export CUDA_VISIBLE_DEVICES=1
for name in min1 min2 heat eq1 eq2 md1; do
#export CUDA_VISIBLE_DEVICES=1
\$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o prot1_\$name.mdout -p prot1_HMR.parm7 -c prot1_\$old.rst7 -ref prot1_HMR.rst7 -x prot1_\$name.nc -r prot1_\$name.rst7 -inf prot1_\$name.mdinfo
old=\$name
done" >  run1_bc4.slurm 

  echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J igb${i}_${j}
#SBATCH --time=100:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#SBATCH --gres=gpu:1
#
module add OpenMPI/2.0.1-gcccuda-2016.10
AMBERHOME=\"/mnt/storage/scratch/el14718/SOFTWARE/amber16\"
#
export MYDIR=\"/mnt/storage/scratch/el14718/5-Folding/9-3-A4_K4E4_A4_K4E4_A4_folded_2/igb${i}_${j}\"
#
old=md1
cd \$MYDIR
#export CUDA_VISIBLE_DEVICES=1
for name in md2; do
#export CUDA_VISIBLE_DEVICES=1
\$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o prot1_\$name.mdout -p prot1_HMR.parm7 -c prot1_\$old.rst7 -ref prot1_HMR.rst7 -x prot1_\$name.nc -r prot1_\$name.rst7 -inf prot1_\$name.mdinfo
old=\$name
done" >  run2_bc4.slurm 

cd ../1-Preparation

done

done



