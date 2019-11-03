#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Local initialization files are used to configure the user's shell environment upon login.  Malicious modification of these files could compromise accounts upon logon.

#STIG Identification
GrpID="V-22362"
GrpTitle="GEN001890"
RuleID="SV-38350r1_rule"
STIGID="GEN001890"
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

for HOMEDIR in $(logins -o -x | awk -F: '{print $6}'); do
 for initfile in $initfiles; do 
  if [ -f $HOMEDIR/$initfile ]; then
   if ls -lLd $HOMEDIR/$initfile | awk '{print $1}' | grep "+" >> $Results; then
    ((scorecheck+=1))
   fi
  fi
 done
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found with ACLs" >> $Results
 echo "Pass" >> $Results
fi