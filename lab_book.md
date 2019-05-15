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

Answers:
1.
Origin: time when the first infected individual arrived in the reasonably well-mixed population
certainly prior to our first sample, can be much older
the density for the origin can then have two peaks: means that the two hypotheses for the two time points are supported. Leads to poorly mixing chain (since it has to explore the first peak, and then the second)
to set the prior, look at the quantiles and think in ages
take the last date and then substract the values of the quantiles

x-axis: unit of the samples we entered
samples 2014.3, 2014.5, 2014.6 are turned in "age before the last sample", hence 0.3, 0.1, 0, with time going backward
BEAST uses ages, which is more correct than time
BEAST ignores dates
if median of origin = 7: means the epidemics started 7 before the last sample

become uninfectious rate and reproductive number: we can set very restrictive/informative priors since very well-known data

If the analysis isn't mixing in a particular region, turn to another region
some posteriors are very difficult to explore

sampling proportion: use those from the article
no need to be too precise (2 or 5 % doesn't make a difference)

clock model: try both strict clock and relaxed model
if you don't see a striking difference, stick to strict clock
allowing for a little bit of variation can make a difference
according to Tim, with our dataset, shouldn't make a difference, but still try both

2. Reproductive numbers for the BDSKY (Andreea's analysis)
sometimes below 1
go to R, change the time axis of the timegrid
times : younger sample - timegrid

population size for coalescent skyline: 2014.0 is January 1st
2014.5 is June
2014.99 is December 31st

3. discrete phylogeography: assumes constant sampling rate
can be a really good tool if you're aware of this assumption
subsample with care, divide the countries in different regions

Tanja: if we subsample the sequences, we have to make the regions coarser
we need a certain number of sequences per region to infer the tree
otherwise, no information on migration between regions

Tim: would this really be a problem?
for the root location, not really
but for migration, you would have to set a different prior for each entry of the migration matrix which has the size of the number of regions

One idea: only take the first 200 sequences in time, hoping they do not come from 200 different locations (which shouldn't be the case)

Here we don't have so many differences in sampling according to locations, but it could be that we have lots of samples from Sierra Leone even if it isn't the origin of the epidemics, so do the full analysis too to have more support.

use the fixed tree they infered and run the phylogeographic analysis on it

to infer the tree, 1600 sequences will take very very long


4. burnin and pre-burnin: don't touch it!
nonzero pre-burnin: throws away the beginning of the analysis
much safer to set it to 0 and then do not consider the first part of the chain
in Tracer, trend at the beginning, then no more obvious trend => you should get rid of that trend

Run two analysis in parallel: both might seem to be mixing well but each of them reaches a different peak
if ESS value of overall posterior is still low, just run the analysis for longer

To compare between the regions, set the same priors (except for sampling proportion)
but clock rate has to be the same for all of us

To infer regional dynamics, the tree of the article is online, on github if we don't want to spend too much time infering it
Take monophyletic clades

we can also talk about limitations at the end of our talk

Week 3 (06.05.2019 - 12.05.2019)
================================

For next week, already start to think about how we want to present our results
Ideally come with some slides ready

Presentations on the 29th from 11 to 13:15
might be that other people from the group come out of interest, but those marking us are Tanja, Tim and Rachel

Tanja:
## Origin of the epidemics

**Discrete phylogeography (Jasmine)**

only plugs data in formulaes --> relatively short

perhaps run it longer (doesn't seem to be stuck, but try to run it 4 times longer to get ESS values > 200)

origin inferred is close to the one in the paper, but not exactly the same one.

Site model: use the paper's

discrete phylogeography: one coalescent for the whole tree --> only one pop size estimate

epidemics transmission is modelled as a nucleotide substitution (flipping a coin): leads to bias

**MASCOT (Andreea)**

models a structured population with 10 pop size estimates

evaluates differential equations

with 200 sequences (10 different locations): very slow

with 50 sequences (4 different locations): still very slow, bad mixing

40'000 iterations in 24 hours

error message, too many iterations

BEAST has trouble inferring the clock rate

if we had time, we would run the analysis with the last 1400 sequences, then take posterior information for the 200 first

EBOLA doesn't mutate so much --> take the mean and variance of the clock rate's posterior of the paper, and set a narrow log normal posterior with these mean and variance. It will help the mixing.  If the clock rate is very constrained, so is the tree height.

Use the same priors for all our origin analyses (especially site model and clock rate).

For migration rate, use the default parameter (except if they are very informative about something wrong)

Try to use only the first 50 sequences with the 4 locations

SCOTTI and and birth death model should run approximately for the same amount of time, and a reasonable one with the first 50 sequences

**Birth-Death Model**

with 50 sequences: should take 2-3 days

even more differential equations to evaluate than MASCOT --> even slower

The more parameters to infer, the more time it takes.

proposed distribution has to be accepted to carry on. But if it is often rejected, you explore way more states than what actually appears on your log file. If the model is more complex, it is more likely we end up at places where the likelihood is very low.
If we have 100 parameters and update all of them as the same time, after a million steps we have only updated all of them 10'000 times.

Compare our posterior probabilities

## Inferring the local dynamics

We infer reproductive numbers when we have a lot of branching (--> lots of transmissions if there is a single location)

higher Re if we have a lot of transmissions

but with our non-monophyletic clades, lots of branchings means there was a lot of migration to our area --> higher Re means a lot of migration

More likely a branching corresponds to a migration even than a transmission

## Advice for the presentation

Focus on the structure analysis, but present also the problem of knowing exactly the structure of the data

For the common parts: the presentation skills are graded individually, the content in common

background: already explain why 50 sequences

Each of us presents the analysis with her model: for example, Andreea would be responsible for the MASCOT part and if questions were to be asked on this model, it would likely be asked to her.

## To do:

change clock rate prior according to paper for all the 4 analyses

Launch the 4 analyses with 50 sequences on the longest queue of the cluster

If we have 4 root locations, show a cake diagram of posteriors for each model (read the log file into R and then plot a diagram)

Week 7 (15.05.2019 - 22.05.2019)
================================
- Scotti and Discrete Phylogeography also use a structured coalescent model as Mascot,
but they also use the number of samples per location as an informative prior
- clock rate posterior is ucld.mean in paper results (in tracer)
- compute the start of the epidemics (date) by subtracting the treeHeight from
tracer from the date of the most recent sample

## Discussion with Tim

**MASCOT and discrete phylogeography yield different results**

You do expect different results from these methods.

In discrete phylogeography, the sample location distribution is treated as data. So if you have lots of samples from the same location, the model will assume the epidemics originated from there. On the other hand, MASCOT isn't biased by sampling proportion. In this model, it tends to infer the location from the tree rather than the other way around. So the tree likelihood gives the shape of the origin tree.

hig ESS values: correspond to the MCMC mixing well, so the mathematical convergence is satisfying. But doesn't imply the results are correct.

Birth death model: somewhere in between these two models

**TreeAnnotator**

debugging with Tim

In the folder where there is the trees java -Xmx4G -cp "C:\Program Files\BEAST_with_jre.v2.5.2.Windows\BEAST\lib\beast.jar" beast.app.treeannotator.TreeAnnotator

## Advice for the presentation

Put the whole presentation on a USB stick just in case.
