Link: https://www.ncbi.nlm.nih.gov/books/NBK25498/?report=reader

ESearch - ESummary/EFetch -- input: E text query; output: formatted data records with XML preamble
> $ perl ESearch.pl > ESearch.doc
#It is XML for the first 51 pages; textual summaries of articles appear after that. 

EPost - ESummary/EFetch -- Input: E UIDs; output: formatted data records with XML preamble
> $ perl EPost.pl >EPost.doc
#Very similar sequences for 5 different species

