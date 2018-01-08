EDirect (aka Entrez Direct) and E-utilities (Entrez utilities) are NCBI tools to access 38 genetics related databases. EDirectr is command shell based. After woriking with E-utilities scripts in Perl, over the past few days, it is clear that command shell interface will be easier to use and understand (both need Perl). This matches with the recommendation of Dr. Pevsner in his book: Bioinformatics and Functional Genomics. 

My documentation of E-utilities here is based on perl scripts that they use. 

Links: https://www.ncbi.nlm.nih.gov/books/NBK25497/ and https://www.ncbi.nlm.nih.gov/books/NBK179288/

For **EDirect**: 

EDirect runs on Unix and needs Perl installed. I installed Perl module infrastructure from metacpan.org. It is an open source engine for the
Comprehensive Perl Archive Network (CPAN). 
Do this: 
>sudo apt install cpanminus 
  #it is "is a script to get, unpack, build and install modules from CPAN and does nothing else."
  #It was installed in perl5 folder in my home directory
  
>sudo cpanm Path::Tiny # this installs Tiny to subfolder Path in perl5

Now, the next step from EDirect link given above. This downloaded several scripts into an "edirect" folder into my home directory:
>cd ~
  /bin/bash
  perl -MNet::FTP -e \
    '$ftp = new Net::FTP("ftp.ncbi.nlm.nih.gov", Passive => 1);
     $ftp->login; $ftp->binary;
     $ftp->get("/entrez/entrezdirect/edirect.tar.gz");'
  gunzip -c edirect.tar.gz | tar xf -
  rm edirect.tar.gz
  builtin exit
  export PATH=$PATH:$HOME/edirect >& /dev/null || setenv PATH "${PATH}:$HOME/edirect"
  ./edirect/setup.sh
  
  EDirect functions (quoted from the EDirect link):
  > esearch performs a new Entrez search using terms in indexed fields.
    elink looks up neighbors (within a database) or links (between databases).
    efilter filters or restricts the results of a previous query.
    efetch downloads records or reports in a designated format.
    xtract converts XML into a table of data values.

    More:
    einfo obtains information on indexed fields in an Entrez database.
    epost uploads unique identifiers (UIDs) or sequence accession numbers.
    nquire sends a URL request to a web page or CGI service.



**For E-utilties**:

Install also UserAgent, a perl module:
>sudo cpanm LWP::UserAgent   

I tried out most of the sample examples and applications that NCBI provides online for E-utilities. The code and some of the results are attached under the Samples directory. 
