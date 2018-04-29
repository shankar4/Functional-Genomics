This folder documents exercises sugggested in "Introduction to computatoinal Genomics: A Case Studies Approach" by N. Cristianini and
M.W. Hahn. 
Following the Biostrings tutorial here: https://web.stanford.edu/class/bios221/labs/biostrings/lab_1_biostrings.html . It discusses XStrings and uses E Coli genome sequence as an exercise. Biostrings installed via RStudio using the source and biocLite commands (see below) - no problem. However, I could not use the same process for BSgenome. 

The E. Coli genome is in BSgenome package from bioconductor. I included the lines (souce the bioconductor site for biocLite.R and biocLite(BSgenome) commands) in the R file itself and executed them as part of the R code. This did not work! The error message: Add the directory containing libcurl.pc to the PKG_CONFIG_PATH environment variable 


This eventually involved setting up the PATH.

Here is the Background:
From the man page (open a terminal, type man pkg-config):

        pkg-config retrieves information about packages from special metadata files. These files are named after the package, and has a .pc extension. On most systems, pkg-config looks in /usr/lib/pkgconfig, /usr/share/pkgconfig, /usr/local/lib/pkgconfig and /usr/local/share/pkgconfig for these files. It will additionally look in the colon-separated (on Windows, semicolon-separated) list of directories specified by the PKG_CONFIG_PATH environment variable.

So the pkg-config program is not in the PKG_CONFIG_PATH directory; however, if you install a library, for the information to use it in an automake script to be accessible it needs to be in a directory pkg-config is aware of.
I checked the pkg-congig and found 1 and 2 directories to be non-empty. The 3rd and 4th ones had no pkgconfig entries. libcurl.pc was not in the first two. 

I did a search on the file explorer and found it to be loaded here: ///home/shankar/miniconda3/envs/bioinfo/lib/pkgconfig/libcurl.pc and also here: ///home/shankar/miniconda3/pkgs/curl-7.54.1-0/lib/pkgconfig/libcurl.pc.

Now, I have to associate one of these paths with PKg_CONFIG_PATh and then try to install again. 
From https://askubuntu.com/questions/210210/pkg-config-path-environment-variable
export PKG_CONFIG_PATH= one of the above paths -- tried /home/shankar/miniconda3/pkgs/curl-7.54.1-0/lib/pkgconfig
This did not work either.
I went back online and found this reference: https://askubuntu.com/questions/359267/cannot-find-curl-config-in-ubuntu-13-04
to install RCurl: 
sudo apt-get install libcurl4-gnutls-dev

then go into R and do

install.packages("RCurl")
** This worked. Now back to RStudio **

 This time the source and biocLite("BSgenome") worked. 
 Ready to continue with the Exercise. However, there are still error messages related to codetools, lattice, Matrix, spatial. 'Installation path not writeable'. Will try that again. 
 
 There was another message about: non-zero exit status. Explanation: The non-zero exit status simply indicates that there was an error during the installation of the "package". 
 
 May not be of concern. However, I want to know how to take care of this.
 Here is a link: https://stackoverflow.com/questions/41839214/installation-path-not-writable-r-unable-to-update-packages
 
 This is the suggested solution:
 It was a permission issue for me. First, I identified where the packages were installed using installed.packages() %>% .[, c("Package", "LibPath")]. You need to have the package magrittr installed to use the "%>%" pipe operator. This outputs a long 2 column matrix with the names and locations of the packages. Then you will see where the offending packages are. In my case, they were at /usr/lib/R/site-library and /usr/lib/R/library. Then I changed the permission of these folders by chmod (I used chmod -R 777 on the main R folder ...)
 
To install margrittr, a CRAN package, start R and use the install.packages command. it installed. No problems. My usage gave the message as 'out of bounds' - then, I just used the File Explorer - could not find a couple of these R files. Perhaps these packages were not installed earlier. There was an implication of this at another response elsewhere.

I will try to install them first. Installed: lattice, Matrix, spatial, and codetools. two more to install: XML and rtracklayer

**The final solution was simple: use in admin mode. That is, do sudo R or sudo rstudio. That would allow proper updating of the files. here is the link: https://stackoverflow.com/questions/28546382/installed-directory-not-writable-cannot-update-packages-boot-class-kerns**.

However, XML still did not install under rstudio, even with sudo. Here is another link for that:
https://stackoverflow.com/questions/7765429/unable-to-install-r-package-in-ubuntu-11-04 
Solution:
You need to install the ubuntu package libxml2-dev So in a shell prompt type:

sudo apt-get update
sudo apt-get install libxml2-dev

Now XML installed from rstudio (invoked with sudo). 

Final note: Look at the BiostringsLab.R code. I included lines for source and biocLite there itself. 


 
 
 
