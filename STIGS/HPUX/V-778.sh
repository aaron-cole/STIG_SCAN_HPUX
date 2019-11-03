#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Limiting the root account direct logins to only system consoles protects the root account from direct unauthorized access from a non-console device.

#STIG Identification
GrpID="V-778"
GrpTitle="GEN000980"
RuleID="SV-38453r2_rule"
STIGID="GEN000980"
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
scorecheck=0
checkfile="/etc/securetty"

if [ -f $checkfile ]; then
 for f in $(cat $checkfile); do
  case "$f" in
    "console") echo "$(grep -n $f $checkfile) - Pass" >> $Results;;
	"/dev/null") echo "$(grep -n $f $checkfile) - Pass" >> $Results;;
	*) ((scorecheck+=1))
	   echo "$(grep -n $f $checkfile) - Fail" >> $Results;;
  esac
 done
else
 echo "$checkfile does not exist - Fail" >> $Results 
fi

if [ "$scorecheck" != 0 ]
then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results 
 echo "Pass" >> $Results
fi