Initial minimization of hydrogens in generalized Born
&cntrl
imin=1, 	 						  ! Turn on minimization
ncyc=500,             ! Number of steepest descent steps
maxcyc=10000,          ! Total number of minimization cycles
ntmin=1,               ! Steepest descent for ncyc steps , then conjugate gradient
cut=9999.0,              ! Cut-off electrostatics
ntb=0,                 ! no periodicity
ntxo=1,
ntpr=10,               ! Print out energy information every ntpr steps
igb=2,                    ! Implicit solvent
saltcon=0.137,         ! Ionic concentration
ntr=0,                 ! Restraints turn off
nmropt=0
/
