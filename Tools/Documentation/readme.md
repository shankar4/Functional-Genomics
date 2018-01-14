Goal: Dynamic reports, reproducible results, and mixing of R code, text, and selective display of code execution results.\
KnitR and Sweave are R tools for this purpose (based, respectively, on Rmd and LaTeX), but Sweave also works with KnitR. I have tried using Sweave on Win7, but not successfully as yet. Have successfully tried both KnitR and Sweave on my Linux system. Based on the exchanges on StackOverflow and others, I have installed knitr, xtable and devtools via the Rstudio cran installer. 

Sweave: See: https://support.rstudio.com/hc/en-us/articles/200552056-Using-Sweave-and-knitr . On RStudio: File | New -> R Sweave gives a basic template.  Here is a recent tutorial: https://stat.ethz.ch/R-manual/R-devel/library/utils/doc/Sweave.pdf

1. Installation: https://rpubs.com/YaRrr/SweaveIntro .

Their steps do not address installation of LaTex on Linux. Here is a link for that installation: http://milq.github.io/install-latex-ubuntu-debian/ .  Here are the steps:
>$sudo apt-get install texlive-full #TeX document production system-large file; installation takes 10+ mins\
$sudo apt-get install texmaker #Tex editor\
$texmaker # enter in a command sheell - opens Texmaker\
#File -> New. Enter the following in the texmaker window\
\documentclass{article}  \
\begin{document}  \
    Hello, world!  \
\end{document}  \
#File -> Save; Tools -> PDFLatex to compile; \
#File ->SaveAs .Rnw; Tools -> R Sweave\
#Open in RStudio and compile as PDF. \
#With this second option, you should be able to include ('embed') R chunks. Rnw is the R version of noweb which supports literate programming

Back to installation directions at https://rpubs.com/YaRrr/SweaveIntro\

Install knitR and xtable (if not installed already) \
Go to RStudio – Tools - Global Options -  Sweave and make the following two changes:

    Select “Sweave Rnw files using Knitr”
    Set “Preview PDF” with “System Viewer”


2. Try the example here: https://stat.ethz.ch/R-manual/R-devel/library/utils/doc/Sweave.pdf\
under the tab with the .Rnw file open, click on 'Complile PDF'. Results included. \
#copying and pasting the author's pdf formatted file causes extra spaces that lead to errors. Remove those spaces.
#In the global options, the first step requires sweave2knitr. So, I switched to Sweave instead of knitr and R Studio viewer and validated the process quickly. 

3. sweave2knitr is a function in knitr. See: https://cran.r-project.org/web/packages/knitr/knitr.pdf. 
> setwd("/home/shankar/DocTools")
library("knitr")
Sweave2knitr("Example-1.Rnw") #This saves the new file in:Example-1-knitr.Rnw\

Now repeating with the global options under step 1 with this file open in R. Click on 'Compile PDF'. Results included.\
The plot is missing in this. The Github documentation of this function indicates that the conversion may be partial. Probably better to stay with Sweave; 

4. But as per a book on knitr, it is possible to use knitr for full documentation. Ref: https://github.com/yihui/knitr-book . I am trying a minimal example from the book, just to see the differences.

5. Trying another sweave example from here: https://rpubs.com/YaRrr/SweaveIntro

6. Tried the notebook option under File of Rstudio. "This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code." File in Rmd and Result in html format for a car example included. 
