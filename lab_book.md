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

  Answer: try both.
  If you want, see ancestral reconstruction model (tutorial on Beast2 website)
  Bayesian Skyline plot.

  NOTE: For B-D models, the sampling time is informative so to get some Information
  we should have the same amount of proportion of sampling per time unit.
  This is not as important for coalescent model.

2. How to subsample the data?
* Western Urban, Western Rural, Western Area
* Bombali, Tomboli, Koniadugu
* in Libera: Monserato

3. Priors --> use the ones from the paper at first and then try some more
* Important: mutation rate (= clock rate) of the Ebola virus
 - set prior on the location rate matrix (e.g. frequency of flights)
 - death rates (in a mathematical sense, B-D rate); this usually means sbd dying or
 quarantined, removed from the population
 - substitution model: HKY + Gamma or GTR + Gamma

## Obs
* discard unknown locations initially --> yes, do so
* alignment length: 18996 (our data), but paper says 18992!

* id2 = accession nr from GenBank

* to infer population size --> samples from one regions
* to infer migration rate -> samples from more regions
* check WHO website on Ebola


Week 2 (10.04.2019 - 17.04.2019)
================================
Analyze different subsamples of the data as follows:
* Jasmine: Conakry + Dubreka + Coyah (Guinea)
* Andreea: Western Urban, Area, Rural (Sierra Leone)
* Jeanne: Montserredo (Liberia)

Recover infection dyamics in those samples.
Then, work together (still has to be determined how) on determining the
location where the epidemic began.

## Notes
1. When we infer population size with the population size with the Bayesian Skyline Plot, we infer the effective number of infected individuals.

Questions for Wednesday
=======================
1. Discuss about choice of priors:
    1.1 become uninfectious rate
    1.2. origin
    1.3. reproductive number
    1.4. sampling proportion
2. Show them results from coalescent and b-d model analysis and discuss relevance etc. What would be the desired output of those analysis?
3. Discus SCOTTI tutorial, discrete phylogeography & other tutorials for inferring the origin of the epidemic
4. Difference between burn-in and preburnin?
