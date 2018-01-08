Link: https://www.ncbi.nlm.nih.gov/books/NBK25498/?report=reader
The output is in XML. A XSLT filter can be used to open such a document in Libreoffice Writer. Here is a link for that: https://forum.openoffice.org/en/forum/viewtopic.php?f=45&t=3490 . I do not plan to do that for now.

ESearch - ESummary/EFetch -- Input: E text query; output: formatted data records with XML preamble
> $ perl ESearch.pl > ESearch.doc
#It is XML for the first 51 pages; textual summaries of articles appear after that. 

EPost - ESummary/EFetch -- Input: E UIDs; output: formatted data records with XML preamble
> $ perl EPost.pl >EPost.doc
#Very similar sequences for 5 different species

ELink - ESummary/EFetch -- Input: E UIDs of one database; output: Linked XML Doc summaries in another database
> $ perl ELink.pl >ELink.doc
#About 540 pages of XML. 

There are four more example perl files at the E-utilities site of NCBI:
ESearch-ELink-ESummary/EFetch -- Input: E text query in db A; output: linked XML summaries in db B and formatted records
EPost-ELink-ESummary/EFetch -- Input: E UIDs in db A; output: linked XML document summaries in db B and formatted records
EPost-ESearch -- Input: E UIDs; output: history set that match
ELink-ESearch -- Input: E UIDs; output: history set in another db

Application 1: Converting GI numbers to accession numbers
>$ perl App1.pl > App1.odt
#input are 4 GI (GenInfo ID) and output has 4 Acc nums.
#I went to this site: https://www.ncbi.nlm.nih.gov/genbank/sequenceids/ and used the 'Nucleotide' option in the search
box (not 'gene')  for the first item, and it gave the correction NM # at https://www.ncbi.nlm.nih.gov/nuccore/24475906

Application 2: Converting accession numbers to data
>$ perl App2.pl >App2.fasta
The output is fasta formatted data for four Acc nums. Attached. 

Application 3: Retrieve large datasets. 50K+ sequencesof chimpanzee mRNA in .fna format (multiple FASTA data):
>perl App3.pl #This takes a substantial amount of time (>10 mins in my case, through university WiFi system)

Application 4: Finding unique sets of linked records for each member of a larger dataset. Not attempted.

