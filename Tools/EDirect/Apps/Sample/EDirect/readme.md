
Intro, installation, and examples are provided here: https://www.ncbi.nlm.nih.gov/books/NBK179288/

Perl is required. Installed Perl module infrastructure from metacpan.org. Used this: cpan App::cpanminus. It has created a local directory for perl5 here: /home/shankar/perl5. It was appended here: /home/shankar/.bashrc. Now, adding the module Path::Tiny with cpanm Path:Tiny. It was not that easy. Had to:  sudo apt install cpanminus. Then tried again. It installed the module to my home directory's perl5 folder. 1/8/18 - I then copied and pasted install directions at the Entrez Direct site. See Github. It installed a edirect folder in my home directory with several scripts. Added another perl module with sudo cpanm LWP::UserAgent (needed by E-utilities)

EDirect functions: Note: the **lower case** designation here Vs Eutitilities. 
1. Navigation: esearch, elink, and efilter. 
2. Retrieval: efetch and xtract
3. Other: einfo, epost, and nquire

Some of the options (such as -target and -related) do not seem to be documented. Are there other options that are not shown in examples? As per documentation of rentrez (see below), go to NCBI's website and use the 'advanced search' tool for a given database. Click on "Show index list" to see all possible filtering terms. 

rentrez seems to be good. Link: https://cran.r-project.org/web/packages/rentrez/vignettes/rentrez_tutorial.html. The installation in rstudio gave error messages indicating that openssl and httr could not be installed ('had non-zero exit status'). I went to this link: https://help.ubuntu.com/community/OpenSSL and followed their instructions for installation. It is the reason behind https vs http; and Entrez urls start with https. First install openssl with: 
```
$sudo apt-get install openssl
....
$ openssl version
```
>OpenSSL 1.0.2l  25 May 2017

```
$ apt-cache search libssl | grep SSL
```
>cl-plus-ssl - Common Lisp interface to OpenSSL\
libssl-ocaml - OCaml bindings for OpenSSL (runtime)\
libssl-ocaml-dev - OCaml bindings for OpenSSL\
libsslcommon2 - enterprise messaging system - common SSL libraries\
libsslcommon2-dev - enterprise messaging system - common SSL development files

#This does not match the link's info, in terms of version #s\
#installed the -ocaml versions (not enterprise versions). 

Reintstalling rentrez had no errors this time.


