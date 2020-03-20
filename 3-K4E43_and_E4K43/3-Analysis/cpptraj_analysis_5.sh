#!/bin/bash

for i in 5; do
   #for j in ff14SB ff03.r1 ff99SBnmr ff96 ff94 ff98; do
    #for k in E4K43 K4E43; do
    for j in ff14SB ; do
    for k in K4E43; do
  cd ../2-Run1/igb${i}_${j}_${k}
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

cd ../../3-Analysis

echo "igb${i}_${j}_${k} done"

done

done

done