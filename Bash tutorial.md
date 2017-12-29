I will try various Bash commands as documented here: http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html . 
Also install grep ('global regular expression print') with sudo apt-get install grep.
Also, here is a good md tutorial (md is the text editing language used at Github): https://www.markdowntutorial.com/

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

Chapter 4 is on regex: (double quotes added below so md does not mis-interpret shell outputs)

$ grep root /etc/passwd
>"root:x:0:0:root:/root:/bin/bash"

$ grep ^root /etc/passwd
>"root:x:0:0:root:/root:/bin/bash"

$ grep -n root /etc/passwd
>"1:root:x:0:0:root:/root:/bin/bash"

$ grep export ~/.bashrc
>"export NVM_DIR="/home/shankar/.nvm"
export PATH=~/bin:$PATH
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '
export PERL_LWP_SSL_VERIFY_HOSTNAME=0
export LC_ALL=C
export PATH="/home/shankar/miniconda3/bin:$PATH"
export PATH=~/src/edirect:$PATH"

$ grep export ~/.bashrc | grep '\PATH'
>"export PATH=~/bin:$PATH
export PATH="/home/shankar/miniconda3/bin:$PATH"
export PATH=~/src/edirect:$PATH"








#####Some .md lessons from the md tutorial site referenced above (in the edit mode at Github):

The latest new from the [BBC] (www.bbc.com)
Blockquote - start with the symbol: > and continue with no space


