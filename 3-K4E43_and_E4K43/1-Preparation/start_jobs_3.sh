#!/bin/bash

for i in 8; do
  for j in ff14SB ff94 ff98 ff99SBnmr; do
    for k in E4K43 K4E43; do

  cd ../2-Run1/igb${i}_${j}_${k}
  sbatch md2.slurm
  cd ../../1-Preparation

done
done
done
