Link: https://www.ncbi.nlm.nih.gov/books/NBK25498/?report=reader

The output is in XML. A XSLT filter can be used to open such a document in Libreoffice Writer. Here is a link for that: https://forum.openoffice.org/en/forum/viewtopic.php?f=45&t=3490 . I do not plan to do that for now. 

ESearch - ESummary/EFetch -- input: E text query; output: formatted data records with XML preamble
> $ perl ESearch.pl > ESearch.doc
#It is XML for the first 51 pages; textual summaries of articles appear after that. 

EPost - ESummary/EFetch -- Input: E UIDs; output: formatted data records with XML preamble
> $ perl EPost.pl >EPost.doc
#Very similar sequences for 5 different species

