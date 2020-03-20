MD production for 4 us
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
  igb=1,                    ! Implicit solvent
  saltcon=0.137,         ! Ionic concentration
  gamma_ln=1.0, 			       ! Langevin thermostat collision frequency
  ig=-1,				             ! Randomize the seed for the pseudo-random number generator
  ntr=0, 			             ! Flag for restraining specified atoms
  nmropt=0,			           ! NMR restraints and weight changes read
/
