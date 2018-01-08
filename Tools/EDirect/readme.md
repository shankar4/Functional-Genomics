EDirect (aka Entrez Direct) and E-utilities (Entrez utilities) are NCBI tools to access 38 genetics related databases. My
documentation here is based on perl scripts that they use. I will document later info on R packages, once I have learned more.

Links: https://www.ncbi.nlm.nih.gov/books/NBK25497/ and https://www.ncbi.nlm.nih.gov/books/NBK179288/

EDirect, per Dr. Pevsner (author of Bioinformatics and Functional Genomics), is far easier to use than Entrez Utilities (EUtil), but is command shell based. 

EDirect runs on Unix and needs Perl installed. I installed Perl module infrastructure from metacpan.org. It is an open source engine for the
Comprehensive Perl Archive Network (CPAN). 
Do this: 
>sudo apt install cpanminus 
  #it is "is a script to get, unpack, build and install modules from CPAN and does nothing else."
  #It was installed in perl5 folder in my home directory
Cpanm Path::Tiny # this installs Tiny to subfolder Path in perl5

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
    
    Install UserAgent, a perl module:
    
