Please see https://www.biostarhandbook.com/. The online version is more up-to-date vs the download (as expected).
They also have a course that you can sign up for a low price and get a a certificate in. There are quizzes to be
completed. All the work is supposed to be done in a command shell window, not using RStudio. A Good Bash tutorial is here: http://www.tldp.org/LDP/Bash-Beginners-Guide/html/ . I will use both. 

Three quizzes completed. Read through the section on "reproducibility" and downloaded the papers and files associated with recent papers on Ebola and Zika viruses. Also downloaded data from GenBank for the first one. The data will be analyzed later with BLAST etc.

Starting work on lecture 4:  "What do words mean." Downloaded HGC data for Chromosome 7 in Json format from here: https://www.genenames.org/cgi-bin/statistics?c=7. Onto.R will document my work here. 

12/8/17 First, I wanted to understand how to explore nested list structure of JSON files. Installed jsonlite (seems better compared to other packages). Redid a tutorial on the use of R to download and parse JSON data from NY city. Included here as JSONTutorial.R

Getting back to lec 04. Two ontologies are introduced: Sequence Ontology (SO) - defines biological terms; Gene Ontology 
(GO) - defines functional characteristics of Gene products. GO has 3 subontologies: cellular components; molecular
function; and biological process. Quick Go, maintained in Europe, is more user friendly (vs GO site). GO defines
functions and connects them to observed gene products (through association files). Each organism has a separate
association file. Key concepts from lecture notes: SO - helps conceptualize features  under study and  their 
relationship. GO - helps understand what a feature does, how, and where. 

Homework (HW04) is to be documented here as a R file (DataMeaning.R). It will use SO and GO ontologies. First, I will focus on getting to those two through R with the HW problem as the end goal.

