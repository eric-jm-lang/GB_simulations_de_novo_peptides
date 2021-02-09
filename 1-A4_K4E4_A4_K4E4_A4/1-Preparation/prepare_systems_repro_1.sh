#!/bin/bash

for i in 8; do
  for j in ff96; do #note that it is in oldff/leaprc.ff99 for example
  for k in 1 2 3; do
  mkdir ../5-Reproducibility/igb${i}_${j}_${k}
  cp prot1_capped.pdb ../5-Reproducibility/igb${i}_${j}_${k}
  cd ../5-Reproducibility/igb${i}_${j}_${k}
  
  if (("$i" == 1)); then
    radii='mbondi'
    echo $radii
  elif (("$i" == 8)); then
    radii='mbondi3'
    echo $radii
  elif (("$i" == 7)); then
    radii='bondi'
    echo $radii
  else
    radii='mbondi2'
    echo $radii
  fi
  
  cat > tleap_$i.in <<EOF
source oldff/leaprc.$j 
set default PBRadii $radii
prot1 = loadPDB prot1_capped.pdb
saveAmberParm prot1 prot1.parm7 prot1.rst7
quit
EOF
  tleap -f tleap_$i.in #> tleap_$i.out
  
  cat > parmed_$i.in <<EOF
parm prot1.parm7
HMassRepartition
outparm prot1_HMR.parm7
quit
EOF
  parmed -O -i parmed_$i.in #> parmed_$i.out
  
  ambpdb -p prot1.parm7 -ext -c prot1.rst7 > prot1.pdb
  
  cp prot1.rst7 prot1_HMR.rst7
  
  echo "Initial minimization of hydrogens in generalized Born
&cntrl
 imin=1, 	 						  ! Turn on minimazation
 ncyc=100,             ! Number of steepest descent steps
 maxcyc=1000,          ! Total number of miniization cycles
 ntmin=1,               ! Steepest descent for ncyc steps , then conjugate gradient
 cut=1000.0,              ! Cut-off electrostatics
 ntpr=10,               ! Print out energy information every ntpr steps
 ntr=1,                 ! Restraints turn on
 ntb=0,                 ! no periodicity
 ntxo=1,
 igb=${i},                    ! Implicit solvent
 saltcon=0.137,         ! Ionic concentration
 restraint_wt=10.0,     ! kcal/mol/A**2 restraint force constant
 restraintmask='!@H=', ! @H=: any atom name starting with H
 nmropt=0
/" >  min1.i
  
  echo "Initial minimization of hydrogens in generalized Born
&cntrl
 imin=1, 	 						  ! Turn on minimization
 ncyc=500,             ! Number of steepest descent steps
 maxcyc=10000,          ! Total number of minimization cycles
 ntmin=1,               ! Steepest descent for ncyc steps , then conjugate gradient
 cut=9999.0,              ! Cut-off electrostatics
 ntb=0,                 ! no periodicity
 ntxo=1,
 ntpr=10,               ! Print out energy information every ntpr steps
 igb=${i},                    ! Implicit solvent
 saltcon=0.137,         ! Ionic concentration
 ntr=0,                 ! Restraints turn off
 nmropt=0
/" >  min2.i  


echo "Initial minimization of hydrogens in generalized Born
&cntrl
imin=1, 	 						  ! Turn on minimization
ncyc=500,             ! Number of steepest descent steps
maxcyc=10000,          ! Total number of minimization cycles
ntmin=1,               ! Steepest descent for ncyc steps , then conjugate gradient
cut=9999.0,              ! Cut-off electrostatics
ntb=0,                 ! no periodicity
ntxo=1,
ntpr=10,               ! Print out energy information every ntpr steps
igb=${i},                    ! Implicit solvent
saltcon=0.137,         ! Ionic concentration
ntr=0,                 ! Restraints turn off
nmropt=0
/" >  min2.i  

  echo "MD heating of system over 200 ps
&cntrl
 imin=0,  			           ! Not a minimisation run
 irest=0, 			           ! Restart simulation
 ntx=1, 			             ! Read coordinates but not velocities from ASCII formatted inpcrd coordinate file
 nscm=1000,			           ! Reset COM every 1000 steps
 nstlim=50000, dt=0.004,	 ! Run MD for 200 ps with a timestep of 4 fs
 ntpr=250, ntwx=2500, 		 ! Write the trajectory every 10 ps and the energies every 1 ps
 ioutfm=1,			           ! Use Binary NetCDF trajectory format (better)
 iwrap=0, 			           ! No wrapping will be performed
 ntxo=2, 			             ! NetCDF rst file
 ntwr=10000,			           ! Write a restrt file every 10 ps steps, if negative value, the files are not overwritten
 cut=9999.0,               ! Cut-off electrostatics
 ntb=0,                    ! no periodicity
 ntc=2, ntf=2,			       ! SHAKE on all H
 ntp=0,				             ! No pressure regulation
 ntt=3,    			           ! Temperature regulation using langevin dynamics
 tempi=10.0,
 temp0=278.15,
 igb=${i},                    ! Implicit solvent
 saltcon=0.137,         ! Ionic concentration
 gamma_ln=1.0, 			       ! Langevin thermostat collision frequency
 ig=-1,				             ! Randomize the seed for the pseudo-random number generator
 ntr=1, 			             ! Flag for restraining specified atoms
 restraint_wt=10.0, 		     ! The weight (in kcal/molA2) for the positional restraints
 restraintmask='@CA,N,C,O',  	! String that specifies the restrained atoms
 nmropt=1,			           ! NMR restraints and weight changes read
/
&wt
  TYPE='TEMP0', ISTEP1=0, ISTEP2=50000,
  VALUE1=10.0, VALUE2=278.15,
/
&wt TYPE='END' /" >  heat.i  

  echo "MD equilibration with restraints over 200 ps
&cntrl
 imin=0,  			           ! Not a minimisation run
 irest=1, 			           ! Restart simulation
 ntx=5, 			             ! Read coordinates and velocities from coordinate file
 nscm=1000,			           ! Reset COM every 1000 steps
 nstlim=50000, dt=0.004,	 ! Run MD for 200 ps with a timestep of 4 fs
 ntpr=250, ntwx=2500, 		 ! Write the trajectory every 10 ps and the energies every 1 ps
 ioutfm=1,			           ! Use Binary NetCDF trajectory format (better)
 iwrap=0, 			           ! No wrapping will be performed
 ntxo=2, 			             ! NetCDF rst file
 ntwr=10000,			           ! Write a restrt file every 10 ps steps, if negative value, the files are not overwritten
 cut=9999.0,               ! Cut-off electrostatics
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
 ntr=1, 			             ! Flag for restraining specified atoms
 restraint_wt=1.0, 		     ! The weight (in kcal/molA2) for the positional restraints
 restraintmask='@CA,N,C,O',  	! String that specifies the restrained atoms
 nmropt=0,			           ! NMR restraints and weight changes read
/" >  eq1.i    

  echo "MD equilibration with restraints over 200 ps
&cntrl
 imin=0,  			           ! Not a minimisation run
 irest=1, 			           ! Restart simulation
 ntx=5, 			             ! Read coordinates and velocities from coordinate file
 nscm=1000,			           ! Reset COM every 1000 steps
 nstlim=50000, dt=0.004,	 ! Run MD for 200 ps with a timestep of 4 fs
 ntpr=250, ntwx=2500, 		 ! Write the trajectory every 10 ps and the energies every 1 ps
 ioutfm=1,			           ! Use Binary NetCDF trajectory format (better)
 iwrap=0, 			           ! No wrapping will be performed
 ntxo=2, 			             ! NetCDF rst file
 ntwr=10000,			           ! Write a restrt file every 10 ps steps, if negative value, the files are not overwritten
 cut=9999.0,               ! Cut-off electrostatics
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
 ntr=1, 			             ! Flag for restraining specified atoms
 restraint_wt=0.1, 		     ! The weight (in kcal/molA2) for the positional restraints
 restraintmask='@CA,N,C,O',  	! String that specifies the restrained atoms
 nmropt=0,			           ! NMR restraints and weight changes read
/" >  eq2.i 

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

  echo "MD production for 4 us
&cntrl
  imin=0,  			           ! Not a minimisation run
  irest=1, 			           ! Restart simulation
  ntx=5, 			             ! Read coordinates and velocities from coordinate file
  nscm=1000,			           ! Reset COM every 1000 steps
  nstlim=1000000000, dt=0.004,	 ! Run MD for 4 us with a timestep of 4 fs
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
/" >  md2.i

echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J ${k}_${i}_${j}
#SBATCH --time=5-00:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=14 # number of tasks per node
#SBATCH --gres=gpu:1
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh
#
cd \$SLURM_SUBMIT_DIR
#
old=HMR
for name in min1 min2 heat; do
mpirun -n 12 \$AMBERHOME/bin/pmemd.MPI -O -i \$name.i -o prot1_\$name.mdout -p prot1_HMR.parm7 -c prot1_\$old.rst7 -ref prot1_HMR.rst7 -x prot1_\$name.nc -r prot1_\$name.rst7 -inf prot1_\$name.mdinfo
old=\$name
done

old=heat
for name in eq1 eq2 md1 md2; do
\$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o prot1_\$name.mdout -p prot1_HMR.parm7 -c prot1_\$old.rst7 -ref prot1_HMR.rst7 -x prot1_\$name.nc -r prot1_\$name.rst7 -inf prot1_\$name.mdinfo
old=\$name
done" >  md1.slurm

cd ../../1-Preparation

done

done

done

