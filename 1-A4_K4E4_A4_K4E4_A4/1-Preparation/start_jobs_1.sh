#!/bin/bash

#for i in 5 ; do
  #for j in ff99 ff99SB ff99SBildn ff99SBnmr ff96 ff94 ff14ipq ff98; do #note that it is in oldff/leaprc.ff99 for example

for i in 1 2 5; do
  for j in ff14SB ff14SBonlysc ff03.r1 fb15 ff15ipq; do

#for i in 1 2 5; do
  #for j in ff14SB ff14SBonlysc ff03.r1 fb15 ff15ipq ff99 ff99SB ff99SBildn ff99SBnmr ff96 ff94 ff14ipq ff98; do

  
  cd ../2-Run1/igb${i}_${j}
  #sbatch md1.slurm
  sbatch md2.slurm
  cd ../../1-Preparation

done

done



