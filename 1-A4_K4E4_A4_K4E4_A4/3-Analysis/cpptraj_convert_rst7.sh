#!/bin/bash

for i in 1 2 5 7 8; do
  for j in ff14SB ff14SBonlysc ff03.r1 fb15 ff15ipq ff99 ff99SB ff99SBildn ff99SBnmr ff96 ff94 ff14ipq ff98; do 
  
  cd ../2-Run1/igb${i}_${j}
  cat > traj.in <<EOF
parm prot1_HMR.parm7
trajin prot1_md2.rst7
reference prot1_HMR.rst7
center :1-33 mass origin
rms reference out rmsd_to_ini.dat '(@CA,C,N,O)'
trajout prot1_md_last_centered.rst7
run
EOF
  cpptraj < traj.in 

cd ../../3-Analysis

echo "igb${i}_${j} done"
done

done



