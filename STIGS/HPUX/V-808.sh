#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The umask controls the default access mode assigned to newly created files.  An umask of 077 limits new files to mode 700 or less permissive.  Although umask can be represented as a 4-digit number, the first digit representing special access modes is typically ignored or required to be 0.  This requirement applies to the globally configured system defaults and the user defaults for each account on the system.

#STIG Identification
GrpID="V-808"
GrpTitle="GEN002560"
RuleID="SV-38475r1_rule"
STIGID="GEN002560"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

###Check###
scorecheck=0

#Global Initialization File
ginitfiles="/etc/profiles /etc/bashrc /etc/bash.bashrc"
for ginitfile in $ginitfiles; do
 if [ -e "$ginitfile" ]; then
  if grep -i umask $ginitfile 2>>/dev/null | grep -v "^#" | grep -v "077" >> $Results; then
    ((scorecheck+=1))
    echo "$ginitfile - Fix" >> $Results
  fi
 fi
done 

#Local Initialization Files
linitfiles=".login .bash_profile .bashrc .cshrc .profile .tcshrc .kshrc .logout .env .dtprofile .dispatch .emacs .exrc"
USERSDIRS="$(logins -u -o -x | cut -f 6 -d ":")"
for USERDIR in $USERDIRS; do
 for linitfile in $linitfiles; do
  if [ -e "$USERDIR/$linitfile" ]; then
   if grep -i umask $USERDIR/$linitfile 2>>/dev/null | grep -v "^#" | grep -v "077" >> $Results; then
    ((scorecheck+=1))
    echo "$USERDIR/$linitfile - Fix" >> $Results
   fi
  fi
 done
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else
 echo "Nothing Found" >> $Results 
 echo "Pass" >> $Results
fi