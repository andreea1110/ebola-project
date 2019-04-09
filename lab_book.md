# Lab Book
# West African Ebola Genomes


## Information about the virus data
- RNA virus, about 20 kb long
- data set composed of 1610 aligned genomes sequenced from isolates
collected during the 2014-2016 West African outbreak.
- don't use all sequences for one analysis
- sub-sample data (from fasta file):
    * randomly
    * focus on individual geographical regions (for skyline plots for e.g.)

## Possible research questions
    1. Can you recover infection dynamics?
    2. Where did the epidemic begin?


Week 1 (03.04.2019 - 10.04.2019)
================================
## Tasks
1. Create project structure

## Data
* 209 sequences from Liberia (LBR) (3.8% of known and suspected cases)
* 1031 sequences from Sierra Leone (SLE) (8%)
* 368 sequences from Guinea (GIN) (9.2%)

## Results from paper
* Answer to question 2:
"Molecular clock dating indicates that the most recent common ancestor
of the epidemic existed between December 2013 and February 2014
(**mean, 22 Jan 2014; 95% credible interval (CI), 16 Dec 2013–20 Feb 2014**)
and phylogeographic estimation assigns this ancestor to
the **Guéckédou prefecture, Nzérékoré region, Guinea**, with high
credibility"

## Questions
1. What model is the most appropriate for our data?
* Structured Coalescent  
  - *MultiTypeTree* (Structured Coalescent tutorial), or *MASCOT* (is this what the authors of the paper used?)
* Multi-type Birth Death
  - StarBeast, Structured Birth-Death tutorial

2. How to subsample the data?

3. Priors --> use the ones from the paper at first and then try some more
* Important: mutation rate of the Ebola virus

## Obs
* discard unknown locations initially
* alignment length: 18996 (our data), but paper says 18992!
