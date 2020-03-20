#!/bin/bash

for i in 1 2 5 8; do
  for j in ff14SB ff03.r1 ff99SBnmr ff96 ff94 ff98; do
    for k in E4K42 K4E42; do
  
  cd ../2-Run1/igb${i}_${j}_${k}
  #sbatch md1.slurm
  sbatch md2.slurm
  cd ../../1-Preparation

done
done
done



