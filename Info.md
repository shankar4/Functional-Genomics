1. Training is available at these sites: [biostar Handbook and Penn State](https://www.biostarhandbook.com/); 
[UC Davis](http://bioinformatics.ucdavis.edu/training/). I am enrolled in the Penn State course. See the folder entitled [biostar handbook](https://github.com/shankar4/Functional-Genomics/tree/master/bioistar%20handbook) for my progress (and R code).  

2. Genomics Forum is [here](https://www.biostars.org/)

3. Databases: [Genbank at NCBI](https://www.ncbi.nlm.nih.gov/genbank/). **For more info, please see the folder entitled [Functl Gen Pevsnar](https://github.com/shankar4/Functional-Genomics/tree/master/FunctlGen%20Pevsner)**; 

4. Glossary (consolidated): A 1996 version of the Human Genome map is found [here](http://geneticssuite.net/node/33). Their definition of 'extragenic' not seen in literature. They do not use 'intergenic' either; but still a good map. **Note**: Some of these are reproduced verbatim from other public sites; no authorship is claimed. They are summarized and thus may not contain nuances. Some book references are also given at the end of this section. 
   * [Aldehyde](https://www.britannica.com/science/aldehyde) - An organic compound with a C atom double bonded to an O atom ('carbonyl group') and single bonded to an H atom and separately, to another atom or a group of atoms (the generic 'R'). Many aldehydes have a pleasant odor, derived from alcohols. They polymerize with other molecules (eg. commercial - plastics such as Bakelite and Formica, and solvents). Physiological - retinal - vitamin A aldehyde, pyridoxal phosphate, a form of Vitamin B<sub>6</sub>. *Glucose* and other reducing sugars are aldehydes, as are many natural and synthetic hormones. 
    * Alu - They are SINES (short interspersed elements) present in multiple copies in human and other primate genomes; about 300 bp in length, found in introns, 3' UTR, and intergenic genomic regions; mobile elements and has most abundant copy number (0.5 M). It is used as a universal PCR primer as it binds in both directions.
    * bacteriophase or phage - any virus that infects bacteria
    * BMI and classes - Normal 18.5 to 25-, overweight  25 -30-, obese 30+, obese class I  30 to 35-, class II 35 to 40-, class III 40+
    * domain - a discrete portion of a protein assumed to fold independently and has its own function
    * enhancer - enhance the rate of transcription; typically they are far away (1000s of bp away) from the sequence.
    * Enzymes Vs Proteins - Enzymes (proteases) break the peptide bonds between the amino acids that make up a protein. eg trypsin and chymotrypsin in the stomach break large proteins into smaller peptides. Carboxypeptidase break peptides into amino acids. Enzymes can speed up the reaction thousand to million fold. 
    * GeneID - unique ID in Entrez Gene; an integer which is species specific. Reported in RefSeq as a 'db_xref'.
    * Glycoproteins - most secreted and membrane proteins. has 1 to 80 sugars in oligosaccharide chain    
    * GAG - Glycosaminoglycans, chains of repeating dissacharides; comprises of an amino sugar (eg GalNac or GlcNac) and a sugar acid (eg glucouronic acid). 10 to 1000 dissacharide units in a chain. OH and amino groups of sugars are frequently sulfated. eg. HA (Hyaluronan). 
    * HapMap and Haploview -  A **haplotype** is a set of DNA polymorphisms that are likely to be inherited together (on the same chromosome - **alleles** (alternate forms of a gene) or a set of SNPs). Haplotype map (HapMap) identifies genetic variants affecting health, disease, drug sensitivity, and environmental impact. Two unrelated people share 99.5% of their DNA sequence. HapMap focuses on common SNPs where each allele occurs in >1% of the population (rare **Mendeilian** diseases: <0.1 % ( in in a thousand) to a few in a million). 
    * Hazard Ratio and Odds Ratio [Ref](https://stats.stackexchange.com/questions/91107/is-there-any-functional-difference-between-an-odds-ratio-and-hazard-ratio) - **Odds ratio** of 2 in logistic regression means that the event is 2 times more probable given a unit increase in the predictor. In Cox regression, a **hazard ratio** of 2 means that the event will occur twice as often at each time point given a one-unit increase in the predictor. The former is a static model, while the latter considers the time element. Probability (from odds ratio) is fixed, while hazard (from hazards ratio) can increase with time (here: doubles every unit of time).  
    * homologous - similarity attributable to descent from a common ancestor
    * Hyaluronan - HA. a lubrican found in soft tissues (skin, cartilage) and synovial fluid (of joints). Highly viscous (1000 fold vs water). Good biological shock absorber. 
    * Intron vs intergenic - introns are short non-goding regions found within genes (in eukaryotics). Intergenic is a stretch of DNA between genes, potentially noncoding. ENCODE - as new genes and their isoforrms are discovered, the # of intergenic regions has increased, while their lengths have decreased. They contain promoters and enhancers. They  also contain **noncoding RNAs** - not translated into a protien, but include functionally important transfer RNAs (tRNAs), ribosomal RNAs(rRNA), and others (microRNA, siRNA, long ncRNA, etc). Affect diseases such as cancer, autism, and Alzheimer's. 
    * Ketones - See Aldehyde above; these are two of the most important organic molecules. Both have a carbonyl group. In a ketone, both atoms bonded to the carbony group are other carbon atoms (in an aldehyde, at least one atom on the carbony carbon is a hydrogen). 
    * Linkage Disequilibrium - is the non-random association of alleles at different loci in a given population. Say allele A occurs with frequency P(A); similarly B with P(B). There is LD if P(AB) differs from P(A)P(B)
    * Map Viewer - available in Entrez Genomes. Can view the complete genome, display chromosome maps,and zoom in.
    * microsatellite - repititive stretches of short DNA sequences used as genetic markers to track inheritance in families. Also known as STRs (short tandem repets).
    * Monogenic and Polygenic -  there are over 4000 human diseases caused by single-gene defects. **Autosomal dominant** - only one mutated copy of the gene to be affected by the disorder (eg. Huntigton's disease, Marfan syndrome); Autosomal recessive -- two mutated copies of the gene must exist for this disorder to mainifest (eg. sickle-cell disease, CF). Polygenic disorders - complex, multifactorial (genetic/life style/ environmental), and run in families. Inheritance does not fit simple patterns as with **Mendelian diseases**, but can still be located and studied. eg., asthma, cancers, diabetes, heart disease, mood disorder. 
    * Odds Ratio: From [ref](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2938757/): The OR represents the odds that an outcome will occur given a particular exposure, compared to the odds of the outcome occurring in the absence of that exposure. Used in case-control, cross-sectional, and cohort studies. Example from the ref: Exposure (+/- or case/control) vs Outcome Status (+/-, have/dont have). Then OR = [case(n)/control(n)]/ [Have(n)/Donothave(n)], or in their table {a/c]/[b/d].  In their example, total = 263 had suicidal behavior at study start. 86 had depression. At 6 month follow-up, 77 still had suicidal behavior, of which 45 had depression at baseline. This gives a (++)= 45; b(+-)= 86, c(-+) = 32 (from 77-45), d(--)= 100 (from 186-86). So, OR = [a/c]/[b/d]= 45 x 100/32 x 86 = 1.63. "The odds of persistent suicidal behavior is 1.63 higher given baseline depression diagnosis vs no baseline depression." From this CI (confidence interval) is calculated. 95% CI is 0.96 to 2.86. This includes 1.0; so not significant. The ref article indicates this with P of 0.07. 
    * Oligosaccharide - sugars with small number of monosaccharides
    * orthology - describes different species that derive from a common ancestor
    * paralog - a set of homologous genes that have diverged.
    * PDB - Protein Data Bank
    * Plasmid - circular molecule of double helical DNA; replicates independently of the bacterial cell's chromosome.
    * promoter - A transcription factor attaches to this sequence to initiate transcription. Consists of 3 regions: Initiator box where transcription starts; TATA box 25 bases upstream from there; and 10 bp long upstream element - specific to a protein.
    * Proteoglycan - GAG + core protein (attached at OH of specific serine residues). 100 or more chains attached to a single core protein; bottlebrush architecture. eg. cartilage - collagen fibers combined with large proteoglycans. 
    * Pseudogene - defective duplicate copy of a genuine gene; cannot be expressed. 
    * Putative vs annotated (functional) - Putative == generally considered to be; Putative proteins are similar to annotated proteins in their sequences, esp in the conserved amino acid portions. Thus the putative is a predicted sequence similar to an annotated protein,  not yet verified functionally. 
    * **Repeats** - 3 major categories - terminal, tandem and interspersed repeats. LTR - Long terminal repeats - identical DNA sequences repeated 100 to 1000 times, found at the ends of retrotranspososns. Used by viruses to insert their genetic material into host genomes; tandem - adjacent copies (direct or inverted) - satellite (cound in centromeres), minisatellite (10 to 60 bp repeats), and microsatellites (<10 bp repeats, as at telomeres); interspersed - transposable (DNA and retrotransposons) - within retrotransposons - **SINEs, LINEs, and SVAs**. Majority of LINEs are LINE-1 and majority of SINEs are **Alus**. In prokaryotes, **CRISPR** are arrays of alternating repeats and spacers. 
    * RNA Polymerase - binds to DNA during transcription and separates or unwinds the DNA strands. Three types and genes that they transcribe: I - genes for large ribosomal RNAs, II - genes that code for proteins, and III - genes for tRNA and other tiny RNAs.
    * QTL - Quantitative Trait Locus - a hypothesis that a certain small chromosomal region contributes significantly to a complex trait expression (based on density of linkage map)
    * recombination - merging of genes from two separate molecules of DNA
    * RefSeq - non-redundant reference sequences.
    * RepeatMaker - program that screens DNA sequence for interspersed repeats and low-complexity DNA sequences.
    * restriction - destruction of incoming foreign DNA by a bacterial cell
    * restriction enzyme - acts as molecular scissors to cut DNA into smaller manageable pieces.
    * splicing - cutting out the intronic regions. Telomere cap and poly-A tail are added prior to this.
    * Tertile - three parts
    * transcription factors - Proteins that regulate RNA Polymerase II, by binding to certain specific DNA sequences,viz., promoter and enhancer
    * transduction - transport of genes from one cell to another with a virus particle as the transporter
    * Transformation - changing the properties of a bacterial cell as a result of uptake of pure DNA
    * UniGene cluster - sequences for known or putative genes. Complete dataset is here
    * WGS sequence - Whole Genome Shotgun sequence - uses large arrays of sequences to sequence rapidly the sequence.
    
    

*Book references used*:
* Biochemistry, Lippincott's Illustrated Reviews, by P.C. Champe and R.A. Harvey, 1987
* Biology: Concepts and Connections, by N.A. Campbell et al., Fifth edition, 2006
    
   
    
   
    

