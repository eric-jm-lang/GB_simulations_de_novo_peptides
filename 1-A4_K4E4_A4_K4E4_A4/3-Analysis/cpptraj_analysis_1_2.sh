#!/bin/bash
for i in 1; do
  for j in ff14SB ff14SBonlysc ff03.r1 fb15 ff15ipq ff99 ff99SB ff99SBildn ff99SBnmr ff96 ff94 ff14ipq ff98; do 
  
  cd ../2-Run1/igb${i}_${j}
 
  cat > traj.in <<EOF
parm prot1_HMR.parm7
trajin prot1_md_centered.nc
secstruct SECSTRUCT out secstruct.dat
run
writedata anti.dat SECSTRUCT[Anti]
writedata para.dat SECSTRUCT[Para]
writedata none.dat SECSTRUCT[None]
writedata avgss.dat SECSTRUCT[avgss]



EOF
  cpptraj < traj.in 

cd ../../3-Analysis

echo "igb${i}_${j} done"
done

done



