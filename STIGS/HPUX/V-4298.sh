#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The remote console feature provides an additional means of access to the system which could allow unauthorized access if not disabled or properly secured.  With virtualization technologies, remote console access is essential as there is no physical console for virtual machines.  Remote console access must be protected in the same manner as any other remote privileged access method.

#STIG Identification
GrpID="V-4298"
GrpTitle="GEN001000"
RuleID="SV-27148r2_rule"
STIGID="GEN001000"
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