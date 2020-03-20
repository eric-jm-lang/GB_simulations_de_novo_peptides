#!/bin/bash

rm *.dat
cat > traj_E4K42_xray.in <<EOF
parm ../igb8_ff14SB_E4K42/prot1_HMR.parm7
trajin ../igb8_ff14SB_E4K42/prot1_HMR.rst7
secstruct SECSTRUCT out secstruct_E4K42_xray.dat
run
writedata helicity_E4K42_xray.dat SECSTRUCT[Alpha]
EOF
cpptraj < traj_E4K42_xray.in 

cat > traj_K4E42_xray.in <<EOF
parm ../igb8_ff14SB_K4E42/prot1_HMR.parm7
trajin ../igb8_ff14SB_K4E42/prot1_HMR.rst7
secstruct SECSTRUCT out secstruct_K4E42_xray.dat
run
writedata helicity_K4E42_xray.dat SECSTRUCT[Alpha]
EOF
cpptraj < traj_K4E42_xray.in 


for i in 1 2 5 8; do
  for j in ff14SB ff03.r1 ff99 ff99SB ff99SBildn ff99SBnmr ff96 ff94 ff14ipq ff98; do 
    for k in E4K42 K4E42; do
  
  module add apps/amber-16
  cd ../igb${i}_${j}_${k}
  rm *.dat
  cat > traj.in <<EOF
parm prot1_HMR.parm7
trajin prot1_md1.nc
trajin prot1_md2.nc
reference prot1_HMR.rst7
center :1-21 mass origin
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
