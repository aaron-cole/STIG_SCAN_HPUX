#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Restricting permissions will protect the files from unauthorized modification.

#STIG Identification
GrpID="V-796"
GrpTitle="GEN001240"
RuleID="SV-38467r1_rule"
STIGID="GEN001240"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

#Check
#files="$(find /etc /bin /usr/bin /usr/lbin /sbin /usr/sbin /usr/usb \( ! -group root -o ! -group bin -o ! -group sys -o ! -group lp -o ! -group nuucp \
#-o ! -group mail -o ! -group ids -o ! -group daemon -o ! -group cimsrvr -o ! -group tty -o ! -group other -o ! -group users \) 2>>/dev/null)"
files="$(find /etc /bin /usr/bin /usr/lbin /sbin /usr/sbin /usr/usb ! \( -group root -o -group bin -o -group sys -o -group lp -o -group nuucp \
-o -group mail -o -group ids -o -group daemon -o -group cimsrvr -o -group tty -o -group other -o -group users \) 2>>/dev/null)"

if [ -z "$files" ]; then
 echo "Files are group owned by a system account" >> $Results
 echo "Pass" >> $Results
else
 for file in $files; do
  ls -l "$file" >> $Results
 done
 echo "Fail" >> $Results
fi
