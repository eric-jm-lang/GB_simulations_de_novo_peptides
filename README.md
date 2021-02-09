## Benchmark of implicit solvent - force field combinations to study *de Novo* peptides
### Author: Eric J. M. Lang - University of Bristol

Experimental description and characterization of the studied peptides can be found in:
Baker, E., Bartlett, G., Crump, M. et al. Local and macroscopic electrostatic interactions in single α-helices. 
*Nat Chem Biol* **11**, 221–228 (2015). https://doi.org/10.1038/nchembio.1739


A total of 5 peptides are studied here:
1. A<sub>4</sub>(K<sub>4</sub>E<sub>4</sub>)A<sub>4</sub>(K<sub>4</sub>E<sub>4</sub>)A<sub>4</sub> with an experimental helicity of 97%.
2. (K<sub>4</sub>E<sub>4</sub>)<sub>2</sub> and (E<sub>4</sub>K<sub>4</sub>)<sub>2</sub> with experimental helicity of 22% and 65%, resp.
3. (K<sub>4</sub>E<sub>4</sub>)<sub>3</sub> and (E<sub>4</sub>K<sub>4</sub>)<sub>3</sub> with experimental helicity of 62% and 74%, resp.


5 implicit solvent models (GB models) were tested:
- GBHCT, igb=1
- GBOBC, igb=2
- GBOBC2, igb=5
- GBn, igb=7
- GBn2, igb=8


13 force fields were tested:
ff94,ff96,ff98,ff99, ff99SB, ff99SBildn, ff99SBnmr, ff03.r1, ff14SB, ff14SBonlysc, ff14ipq, fb15, ff15ipq


Simulations were performed with Amber16
