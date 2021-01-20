#!/bin/bash -login
#
#SBATCH -p serial
#SBATCH -J ana3_7
#SBATCH --time=06:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh
#
cd $SLURM_SUBMIT_DIR
#
bash cpptraj_analysis_7_2.sh > cpptraj_analysis_7_2.log
 

