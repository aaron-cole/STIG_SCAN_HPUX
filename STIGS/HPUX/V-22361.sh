#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Local initialization files are used to configure the user's shell environment upon login.  Malicious modification of these files could compromise accounts upon logon.

#STIG Identification
GrpID="V-22361"
GrpTitle="GEN001870"
RuleID="SV-34926r1_rule"
STIGID="GEN001870"
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
initfiles=".login .bash_profile .bashrc .bash_logout .cshrc .profile .tcshrc .kshrc .logout .env .dtprofile .dispatch .emacs .exrc"

for userline in $(logins -o -x | awk -F: '{print $4":"$6}'); do
 HOMEDIR="$(echo "$userline" | cut -f 2 -d ":")"
 GrpID="$(echo "$userline" | cut -f 1 -d ":")"
 for initfile in $initfiles; do 
  if [ -f $HOMEDIR/$initfile ]; then
   if [ "$(perl -le'print((stat shift)[5])' $HOMEDIR/$initfile)" -eq "$GrpID" ] || [ "$(perl -le'print((stat shift)[5])' $HOMEDIR/$initfile)" -eq 0 ]; then
	echo "" >> /dev/null
   else 
    ((scorecheck+=1))
    echo "Fail - $(ls -l $HOMEDIR/$initfile)" >> $Results
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