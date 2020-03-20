MD equilibration with restraints over 200 ps
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
 igb=8,                    ! Implicit solvent
 saltcon=0.137,         ! Ionic concentration
 gamma_ln=1.0, 			       ! Langevin thermostat collision frequency
 ig=-1,				             ! Randomize the seed for the pseudo-random number generator
 ntr=1, 			             ! Flag for restraining specified atoms
 restraint_wt=0.1, 		     ! The weight (in kcal/molA2) for the positional restraints
 restraintmask='@CA,N,C,O',  	! String that specifies the restrained atoms
 nmropt=0,			           ! NMR restraints and weight changes read
/
