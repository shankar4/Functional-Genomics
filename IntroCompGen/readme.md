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
From 
export PKG_CONFIG_PATH= <<one of the above paths>>. 
