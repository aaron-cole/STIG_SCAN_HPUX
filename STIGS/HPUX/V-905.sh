#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Local initialization files are used to configure the user's shell environment upon login.  Malicious modification of these files could compromise accounts upon logon.

#STIG Identification
GrpID="V-905"
GrpTitle="GEN001880"
RuleID="SV-38493r1_rule"
STIGID="GEN001880"
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
checkmode="740"

linitfiles=".login .bash_profile .bashrc .cshrc .profile .tcshrc .kshrc .logout .env .dtprofile .dispatch .emacs .exrc"
USERHOMEDIRS="$(logins -u -o -x | cut -f 6 -d ":")"
for USERHOMEDIR in $USERHOMEDIRS; do
 for linitfile in $linitfiles; do
  if [ -e "$USERHOMEDIR/$linitfile" ]; then
   filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
   if [ $filemode -gt $checkmode ]; then
    echo "$file is $filemode and not less than or equal to $checkmode" >> $Results
    ((scorecheck+=1))
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