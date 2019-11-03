#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#File system extended ACLs provide access to files beyond what is allowed by the mode numbers of the files. Unauthorized modification of the /etc/securetty file could cause Denial of Service to authorized system consoles or add unauthorized system consoles.

#STIG Identification
GrpID="V-22591"
GrpTitle="GEN000000-HPUX0110"
RuleID="SV-26994r1_rule"
STIGID="GEN000000-HPUX0110"
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
#File or Directory to check
file="/etc/securetty"

if [ -e $file ]; then
 ls -lLd $file >> $Results
 if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
  echo "Fail" >> $Results
 else
  echo "Pass"  >> $Results
 fi
else
 echo "File does not exist" >> $Results
 echo "Fail" >> $Results
fi
