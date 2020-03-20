#!/bin/bash

for i in 1 2 5 8; do
  for j in ff14SB ff03.r1; do
    for k in E4K43 K4E43; do
  
  cd ../2-Run1/igb${i}_${j}_${k}
  sbatch md12.slurm
  cd ../../1-Preparation

done
done
done

