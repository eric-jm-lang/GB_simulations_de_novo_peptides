#!/bin/bash

for i in 2; do
  for j in ff14SB ff14SBonlysc ff03.r1 fb15 ff15ipq ff99 ff99SB ff99SBildn ff99SBnmr ff96 ff94 ff14ipq ff98; do 
  
  cd ../2-Run1/igb${i}_${j}
  rm *.dat
  cat > traj.in <<EOF
parm prot1_HMR.parm7
trajin prot1_md1.nc
trajin prot1_md2.nc
reference prot1_HMR.rst7
center :1-33 mass origin
rms reference out rmsd_to_ini.dat '(@CA,C,N,O)'
trajout prot1_md_centered.nc
trajout prot1_md_centered.pdb onlyframes 1
secstruct SECSTRUCT out secstruct.dat
run
writedata helicity.dat SECSTRUCT[Alpha]
EOF
  cpptraj < traj.in 

cd ../../3-Analysis

echo "igb${i}_${j} done"
done

done



