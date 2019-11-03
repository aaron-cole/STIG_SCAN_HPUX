#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Local initialization files are used to configure the user's shell environment upon login.  Malicious modification of these files could compromise accounts upon logon.

#STIG Identification
GrpID="V-904"
GrpTitle="GEN001860"
RuleID="SV-38492r1_rule"
STIGID="GEN001860"
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

linitfiles=".login .bash_profile .bashrc .cshrc .profile .tcshrc .kshrc .logout .env .dtprofile .dispatch .emacs .exrc"
USERHOMEDIRS="$(logins -u -o -x | cut -f 2,6 -d ":")"
for USERHOMEDIR in $USERHOMEDIRS; do
 USER="$(echo "$USERHOMEDIR" | cut -f 1 -d ":")"
 HOMEDIR="$(echo "$USERHOMEDIR" | cut -f 2 -d ":")"
 for linitfile in $linitfiles; do
  if [ -e "$HOMEDIR/$linitfile" ]; then
   OwnerID="$(perl -le'print((stat shift)[4])' $HOMEDIR/$linitfile)"
   case "$OwnerID" in
	0|$USER) continue;; 
			 #echo "Pass - $HOMEDIR/$linitfile"  >> $Results;;
	*) echo "Fail - $(ls -ld $HOMEDIR/$linitfile)" >> $Results
	   ((scorecheck+=1));;
   esac
  fi
 done
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else
 echo "Nothing Found" >> $Results 
 echo "Pass" >> $Results
fi