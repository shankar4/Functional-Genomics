Goal: Dynamic reports, reproducible results, and mixing of R code, text, and selective display of code execution results.\
Notebook (.Rmd to .html), knitr and Sweave (.Rnw to .tex to .pdf) are R tools for this purpose. knitr targets .rmd, while sweave targets LaTeX documentation standard.  But Sweave also works with KnitR. I have tried using Sweave on Win7, but not successfully as yet. Have successfully tried all three on my Linux system. Based on the exchanges on StackOverflow and others, I have installed knitr, xtable and devtools via the Rstudio cran installer. 

Sweave: See: https://support.rstudio.com/hc/en-us/articles/200552056-Using-Sweave-and-knitr . On RStudio: File | New -> R Sweave gives a basic template.  Here is a recent tutorial: https://stat.ethz.ch/R-manual/R-devel/library/utils/doc/Sweave.pdf

1. Installation: https://rpubs.com/YaRrr/SweaveIntro .

Their steps do not address installation of LaTex on Linux. Here is a link for that installation: http://milq.github.io/install-latex-ubuntu-debian/ .  Here are the steps:

```
$sudo apt-get install texlive-full #TeX document production system-large file; installation takes 10+ mins\
$sudo apt-get install texmaker #Tex editor\
$texmaker # enter in a command sheell - opens Texmaker\
```
#File -> New. Enter the following (example) in the texmaker window\

>\documentclass{article}  \
\begin{document}  \
    Hello, world!  \
\end{document}  \

#File -> Save; Tools -> PDFLatex to compile; \
#File ->SaveAs .Rnw; Tools -> R Sweave\
#Open in RStudio and compile as PDF. \
#With this second option, you should be able to include ('embed') R chunks. Rnw is the R version of noweb which supports literate programming

Back to installation directions at https://rpubs.com/YaRrr/SweaveIntro\

Install knitR and xtable (if not installed already) \
Go to RStudio – Tools - Global Options -  Sweave and make the following two (suggested) changes:

    Select “Sweave Rnw files using Knitr”
    Set “Preview PDF” with “System Viewer”


2. Try the example here: https://stat.ethz.ch/R-manual/R-devel/library/utils/doc/Sweave.pdf\
under the tab with the .Rnw file open, click on 'Complile PDF'. Files included here: input(.Rnw), intermediate (.tex), and output (.pdf). \
#copying and pasting the author's pdf formatted file causes extra spaces that lead to errors. Remove those spaces.
#In the global options, the first step requires sweave2knitr. So, I switched to Sweave instead of knitr and R Studio viewer and validated the process quickly. 

3. sweave2knitr is a function in knitr. See: https://cran.r-project.org/web/packages/knitr/knitr.pdf. 

```
setwd("/home/shankar/DocTools")
library("knitr")
Sweave2knitr("Example-1.Rnw") #This saves the new file in:Example-1-knitr.Rnw\
```
Now repeating with the global options under step 1 with this file open in R. Click on 'Compile PDF'. Relevant input (.Rnw), intermediate (.tex) and output (.pdf) files are included here.\
The plot is missing in this versopm. The Github documentation of this function indicates that the conversion may be partial. Probably better to stay with Sweave and not use this function; 

4. But as per a book on knitr, it is possible to use knitr for full documentation. Ref: https://github.com/yihui/knitr-book . I am trying a minimal example from the book, just to see the differences. Within RStudio, File|New -> R Sweave which opens a template based .Rnw file. The template is useful even for knitr. I copied one of the author's examples and saved it (048-cars-demo.Rnw). Use the 'Run' option to locally execute and validate. 'Compile to PDF' with a click on that option in the .Rnw window on Rstudio. Both (.Rnw and .pdf) files are included here. Key thing is that plot comes through and that the formatting is simpler and more straightforward. No fine tuning/ customization, as is possible with Sweave. As one author pointed out, this way, we can focus on content rather than the style. 

5. Trying other sweave examples from here: https://rpubs.com/YaRrr/SweaveIntro . The author's link to an APA style template does not work. However, there is a PDF with more here: http://www.tug.org/pracjourn/2008-1/zahn/zahn.pdf . He uses the Prestige data set from the car package. Apparently things have changed since its publication. I had to make adjustments to the code. My code (included along with PDF output) is not fully functional, but can be improved with some effort to understand LaTeX better. One thing I am yet to try: cross-referencing, in-text citation, and reference lists. To refer to something later, use \label{ex:label}. Then you can refer to it as \ref{ex:label}. For citations, use BibTeX (google scholar provides citations in this format) to create a .bib file with a listing. Note the cite-key, say Zahn2008 (his example). It can be cited as \cite[Zahn2008]. This will result in (Zahn 2008) in the text, and the ref will be automatically inserted into the ref list at the end of the document. For details see apacite package.   

6. Tried the notebook option under File of Rstudio. "This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code." Input file in .Rmd and Result in .html format for a car example are included here (Rstudio's demo example). 

7. papaja is another recent entry. Looks like it builds on knitr. Yet to try. Read the documentation [here]:(https://github.com/crsh/papaja/blob/master/example/example.Rmd). It uses a R Markdown template that can be used to produce documents that meet the APA manuscript guidelines, with the output in rmd, pdf, and (almost) doc (for Word). it integrates with rmarkdown, bookdown, and knitr to create a rmd file with text and chunks of R code (and others, such as Python) and results. Pretty tables can be achieved with apa_table(). bookdown package provides cross-referencing capabilities within the document. Figures produced by R code can be referenced and rendered elsewhere. For external figures, use knitr options. If not creating Word documents (that is, no colaborators who are Word-centric), you can also use \LaTeX commands. 

8. My conclusion: Sweave and LaTeX route seems less traveled. I will adapt knitr for my work. I have ordered Yihui Xie's [book]:(https://www.amazon.com/Dynamic-Documents-knitr-Second-Chapman/dp/1498716962/ref=sr_1_1?s=books&ie=UTF8&qid=1516038180&sr=1-1&keywords=knitr) on knitr with .rmd and pdf as outputs.  For manuscripts, papaja will be helpful. A bit more to learn and apply...
