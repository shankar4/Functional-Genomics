Notes from "Linux In Action" By D. Clinton, Manning, 2018

Bash is the most popular UNIX shell. A shell interprets user commands, either through a CLI (command line interface) or GUI (graphcial user interface). It is a software layer meant to execute formatted commands using the underlying kernel and HW system resources. *It is the way you talk to your computer*. 

In addition to the older 'more' command, there is a 'less' command now:

>less /etc/services #scroll up and down through the file with the arrow (I think Home and End keys on my keyboard), PgUp/PgDn, and spacebar keys. Press q to quit

Quickly create an empty file with 
>touch myfile #use nano or vi to open the file and enter text. Press Esc, type:w to save, and :q to exit. 
I use gedit for that purpose - gives a GUI to enter text. 

Every object within a Linux file system is represented by *inode* metadata. use
>stat myfile # view inode info (pp. 32 of the book). An *inode* is used by UNIX to id the disk location and attributes of files within a file system. There will be exactly one inode for each file or directory (typically). 

globbing (from 'global') is used to apply wild characters to the filenames addressed by the commands. 
>mkdir mytemp

>mv myf* mytemp # * is 0 to many characters; ? is for only one character.

>rm -r mytemp
