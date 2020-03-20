#!/bin/bash

module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

rm *.dat
cat > traj_E4K43_xray.in <<EOF
parm ../igb5_ff14SB_E4K43/prot1_HMR.parm7
trajin ../igb5_ff14SB_E4K43/prot1_HMR.rst7
secstruct SECSTRUCT out secstruct_E4K43_xray.dat
run
writedata helicity_E4K43_xray.dat SECSTRUCT[Alpha]
EOF
cpptraj < traj_E4K43_xray.in 

cat > traj_K4E43_xray.in <<EOF
parm ../igb5_ff14SB_K4E43/prot1_HMR.parm7
trajin ../igb5_ff14SB_K4E43/prot1_HMR.rst7
secstruct SECSTRUCT out secstruct_K4E43_xray.dat
run
writedata helicity_K4E43_xray.dat SECSTRUCT[Alpha]
EOF
cpptraj < traj_K4E43_xray.in 


for i in 5; do
  for j in ff14SB ff96; do 
    for k in E4K43 K4E43; do
  

  cd ../igb${i}_${j}_${k}
  rm *.dat
  cat > traj.in <<EOF
parm prot1_HMR.parm7
trajin prot1_md1.nc
#trajin prot1_md2.nc
reference prot1_HMR.rst7
center :1-29 mass origin
rms reference out rmsd_to_ini.dat '(@CA,C,N,O)'
trajout prot1_md_centered.nc
trajout prot1_md_centered.pdb onlyframes 1
secstruct SECSTRUCT out secstruct.dat
run
writedata helicity.dat SECSTRUCT[Alpha]
EOF
  cpptraj < traj.in 

cd ../2-Analysis

done

done

done