Initial minimization of hydrogens in generalized Born
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
 igb=1,                    ! Implicit solvent
 saltcon=0.137,         ! Ionic concentration
 restraint_wt=10.0,     ! kcal/mol/A**2 restraint force constant
 restraintmask='!@H=', ! @H=: any atom name starting with H
 nmropt=0
/
