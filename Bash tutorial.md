I will try various Bash commands as documented here: http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html . 
Also install grep ('global regular expression print') with sudo apt-get install grep.
Also, here is a good md tutorial (md is the text editing language used at Github): https://www.markdowntutorial.com/ . 
**Some md hints are included at the end.** 

All the activities below are in a terminal window

#### Find Ubuntu version
$ lsb_release -a  
>No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 16.04.3 LTS
Release:	16.04
Codename:	xenial

#### Find various shells on your system
$ cat /etc/shells  
>/etc/shells: valid login shells - 
/bin/sh
/bin/dash
/bin/bash
/bin/rbash

A shell is an executable file and is listed in PATH
$ echo $PATH   
>/home/shankar/src/edirect:/home/shankar/miniconda3/bin:/home/shankar/bin:/home/shankar/.nvm/versions/node/v4.2.6/bin:/home/shankar/src/edirect:/home/shankar/miniconda3/bin:/home/shankar/bin:/home/shankar/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/lib/fis-gtm/V6.0-003_x86_64:/usr/lib/fis-gtm/V6.0-003_x86_64

$ pwd 
>/home/shankar

To switch from the default (sh in my case) to bash, execute or enter 'bash'. It stands for Bourne Again SHell

Check if in interactive mode:
$ echo $-
>himBH

$ echo $[4*12]
>48

Chapter 4 is on regex (md reinterprets certain characters in the outputs; so, outputs not shown, just commented on)

$ grep root /etc/passwd  - display lines with the string 'root' in the file: /etc/passwd

$ grep ^root /etc/passwd  - display lines that start with 'root'
 
$ grep -n root /etc/passwd - display line number also
 
$ grep export ~/.bashrc - display lines with 'export' in the home directory's bashrc file
 
$ grep export ~/.bashrc | grep '\PATH' -- display further only lines with word starting with 'PATH'. use \> for ending with.

$ grep export ~/.bashrc | grep -w bin -- display further only lines with a separate word of 'bin' - effect same as for PATH

$ grep [yf] /etc/group -- displays any line with either y or f

grep '\<c...h\>' /usr/share/dict/words  -- displays 5 letter words in dictionary that start with c and end in h 

grep '\<c.*h\>'  /usr/share/dict/words  -  *implies any number of letters in-between

<!--- Continue with Chapter 5 on sed and Chapter 6 on AWK --->

**Some .md 'how to's from the md tutorial site referenced above (in the edit mode at Github):**

<!---
The latest news from the [BBC]: # (www.bbc.com)  
--->
Use html comment tags -- with ! and three dashes, etc. -- if you wish to include comments visible only to you, and  not the reader. Other suggestions
with []:() did not work here.   
Blockquote - start with the symbol: > and continue with no space. Comments can be included with # with no space - does not result in headers.  
To create an unordered list: start with an * and a space. Each item gets its own line. An ordered list is prefaced with numbers, instead of *. If sublists, indent the asterik one space more than the preceding one.  
Add a line for a hardbreak between paragraphs. Also, achieve the same effect, more elegantly, with two spaces after each line.    
Adding hashtag later in the line negagtes the bolding of header lines with #. See the example of read.pl below.  

**Perl on Linux**  Ref: https://www.thoughtco.com/how-to-install-and-run-perl-2641103  (this ref seems outdated; see the Perl links below)     
It is a good data mining and scripting tool    
check if installed with:   
perl -v
>This is perl 5, version 22, subversion 1 (v5.22.1) built for x86_64-linux-gnu-thread-multi
(with 60 registered patches, see perl -V for more detail).....  
I used the following to locate where it is loaded:
 
$ locate perl|grep '/bin/perl$' -- found 3 sites  
>/home/shankar/miniconda3/envs/bioinfo/bin/perl  
/home/shankar/miniconda3/pkgs/perl-5.22.0.1-0/bin/perl  
/usr/bin/perl  

First script:    
use gedit to build hello.pl

```perl
>#!/usr/bin/perl  
print "Enter your name:";  
$name = <STDIN>;  
print "Hello, ${name} ... you will soon be Perl Perfect!";  
```
Run it:    
$ perl hello.pl  
>Enter your name:Ravi  
Hello, Ravi  
 ... you will soon be Perl Perfect!  
 
How to read and write in Perl-- Ref: http://learn.perl.org/examples/read_write_file.html   
Another good ref: https://perlmaven.com/use-path-tiny-to-read-and-write-file   
There are 108K Perl modules that can be downloaded and installed from CPAN (Comprehensive Perl Archival network).
Need to do these two things to install Path::Tiny  
cpan App::cpanminus  --nI chose the option to load into my homedirectory. I had to redo with sudo this command
to install the Path module with cpanm Module::Name ..specifically cpanm Path::Tiny. 

First create a file, say with gedit with 3 names - say Larry, Mary, and Harry one per line (data.txt)  

create and save a read.pl file: 

This is the code in read.pl:  
``` perl
>#!/usr/bin/perl  
use strict;  
use warnings;  
use Path::Tiny;  
use autodie; #die if problem reading or writing a file 
#read in the entire contents of a file 
#return an IO file object to read from 
#read one line at a time 
my $dir = path("~/PerlHelp/tmp");
my $file = $dir->child("data.txt"); 
my $content = $file -> slurp_utf8(); 
my $file_handle = $file -> openr_utf8(); 
while (my $line = $file_handle -> getline()) {print $line;} 
```

Run it with perl read.pl to see the list of names  
$ perl read.pl
>Larry  
Mary  
Harry  

I also installed Entrez Direct (EDirect) perl scripts from NCBI's EDirect site (see biostar handbook/Tools/Entrez Direct)
$ echo $PATH
>/home/shankar/perl5/bin:/home/shankar/src/edirect:/home/shankar/miniconda3/bin:/home/shankar/bin:/home/shankar/.nvm/versions/node/v4.2.6/bin:/home/shankar/perl5/bin:/home/shankar/src/edirect:/home/shankar/miniconda3/bin:/home/shankar/bin:/home/shankar/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/lib/fis-gtm/V6.0-003_x86_64:/usr/lib/fis-gtm/V6.0-003_x86_64

.bashrc in the home directory is hidden. Use this in your home directory to find and list (some files not shown in the list below):

$ ls -la  | more

>total 2180
drwxr-xr-x  53 shankar shankar    4096 Jan  8 10:33 .
drwxr-xr-x   3 root    root       4096 Mar 23  2016 ..
...
-rw-------   1 shankar shankar   32669 Jan  5 17:41 .bash_history
-rw-r--r--   1 shankar shankar     220 Mar 23  2016 .bash_logout
-rw-rw-r--   1 shankar shankar      89 Oct 27 14:47 .bash_profile
-rw-r--r--   1 shankar shankar    5046 Dec 29 15:47 .bashrc
-rw-r--r--   1 shankar shankar    4525 Oct 27 15:07 .bashrc-miniconda3.bak
-rw-r--r--   1 shankar shankar    3766 Mar 23  2016 .bashrc~
drwx------  32 shankar shankar    4096 Nov 10 13:05 .cache
...

To see what is in the .bashrc file:
$ more /home/shankar/.bashrc


**Some markdown hints**
md ref: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
Highlighting examples, for later use (need language spec):
```javascript
var s = "JavaScript syntax highlighting";
alert(s);
```
 
```python
s = "Python syntax highlighting"
print s
```
Inline `code` has `back-ticks around` it.

Math symbols: https://chrome.google.com/webstore/detail/github-with-mathjax/ioemnmodlmafdkllaclgeombjnmnbima, available on Chrome.
LATEX tutorial for a writing project: http://latextrack.sourceforge.net/github-tutorial/github-tutorial.pdf  <br><br> 
To add a blank line after a given line, add two html breaks as with the previous line: ```<br><br> ```


