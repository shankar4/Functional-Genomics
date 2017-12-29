I will try various Bash commands as documented here: http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html . 
Also install grep ('global regular expression print') with sudo apt-get install grep.
Also, here is a good md tutorial (md is the text editing language used at Github): https://www.markdowntutorial.com/

All the activities below are in a terminal window

#### Find Ubuntu version
$ lsb_release -a   gives:
>No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 16.04.3 LTS
Release:	16.04
Codename:	xenial

#### Find various shells on your system
$ cat /etc/shells  gives:
>/etc/shells: valid login shells - 
/bin/sh
/bin/dash
/bin/bash
/bin/rbash

A shell is an executable file and is listed in PATH
$ echo $PATH  gives: 
>
/home/shankar/src/edirect:/home/shankar/miniconda3/bin:/home/shankar/bin:/home/shankar/.nvm/versions/node/v4.2.6/bin:/home/shankar/src/edirect:/home/shankar/miniconda3/bin:/home/shankar/bin:/home/shankar/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/lib/fis-gtm/V6.0-003_x86_64:/usr/lib/fis-gtm/V6.0-003_x86_64

$ pwd  gives: 
>
/home/shankar

To switch from the default (sh in my case) to bash, execute or enter 'bash'. It stands for Bourne Again SHell

Check if in interactive mode:
$ echo $-  gives: 
>
himBH

$ echo $[4*12]  gives: 
>
48





#####Some .md lessons from the md tutorial site referenced above (in the edit mode at Github):

The latest new from the [BBC] (www.bbc.com)

