#!/bin/bash

for i in 7 ; do
  for j in ff14SB ff14SBonlysc ff03.r1 fb15 ff15ipq ff99 ff99SB ff99SBildn ff99SBnmr ff96 ff94 ff14ipq ff98; do 
  #for j in ff14SB ff14SBonlysc ff03.r1 fb15 ff15ipq; do 
  cd ../4-Run2/igb${i}_${j}
  sbatch md1.slurm
  cd ../../1-Preparation

done

done



