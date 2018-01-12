
Intro, installation, and examples are provided here: https://www.ncbi.nlm.nih.gov/books/NBK179288/

Perl is required. Installed Perl module infrastructure from metacpan.org. Used this: cpan App::cpanminus. It has created a local directory for perl5 here: /home/shankar/perl5. It was appended here: /home/shankar/.bashrc. Now, adding the module Path::Tiny with cpanm Path:Tiny. It was not that easy. Had to:  sudo apt install cpanminus. Then tried again. It installed the module to my home directory's perl5 folder. 1/8/18 - I then copied and pasted install directions at the Entrez Direct site. See Github. It installed a edirect folder in my home directory with several scripts. Added another perl module with sudo cpanm LWP::UserAgent (needed by E-utilities)
