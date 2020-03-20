#!/bin/bash

for i in 1 2 5 8; do
  for j in ff14SB ff03.r1 ff99SBnmr ff94 ff96 ff98; do 
     for k in E4K42 K4E42; do

  cd ../2-Run1/igb${i}_${j}_${k}
  
echo "MD production for 2 us
&cntrl
 imin=0,  			           ! Not a minimisation run
 irest=1, 			           ! Restart simulation
 ntx=5, 			             ! Read coordinates and velocities from coordinate file
 nscm=1000,			           ! Reset COM every 1000 steps
 nstlim=500000000, dt=0.004,	 ! Run MD for 2 us with a timestep of 4 fs
 ntpr=2500, ntwx=25000, 		 ! Write the trajectory every 100 ps and the energies every 10 ps
 ioutfm=1,			           ! Use Binary NetCDF trajectory format (better)
 iwrap=0, 			           ! No wrapping will be performed
 ntxo=2, 			             ! NetCDF rst file
 ntwr=25000000,			       ! Write a restrt file every 100 ns steps, if negative value, the files are not overwritten
 cut=1000.0,               ! Cut-off electrostatics
 ntb=0,                    ! no periodicity
 ntc=2, ntf=2,			       ! SHAKE on all H
 ntp=0,				             ! No pressure regulation
 ntt=3,    			           ! Temperature regulation using langevin dynamics
 tempi=278.15,
 temp0=278.15,
 igb=${i},                    ! Implicit solvent
 saltcon=0.137,         ! Ionic concentration
 gamma_ln=1.0, 			       ! Langevin thermostat collision frequency
 ig=-1,				             ! Randomize the seed for the pseudo-random number generator
 ntr=0, 			             ! Flag for restraining specified atoms
 nmropt=0,			           ! NMR restraints and weight changes read
/" >  md1.i 

echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J 1_${i}_${j}_${k}
#SBATCH --time=30:00:00     # Walltime
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
old=HMR
for name in min1 min2 heat eq1 eq2 md1; do
\$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o prot1_\$name.mdout -p prot1_HMR.parm7 -c prot1_\$old.rst7 -ref prot1_HMR.rst7 -x prot1_\$name.nc -r prot1_\$name.rst7 -inf prot1_\$name.mdinfo
old=\$name
done" >  md1.slurm

echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J 2_${i}_${j}_${k}
#SBATCH --time=48:00:00     # Walltime
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



