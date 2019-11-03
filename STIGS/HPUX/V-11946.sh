#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-11946"
GrpTitle="GEN000340"
RuleID="SV-38209r1_rule"
STIGID="GEN000340"
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

logins -s >> $Results

if logins -s -o | egrep -v "^nobody:|^root:|^daemon:|^bin:|^sys:|^adm:|^uucp:|^lp:|^nuucp:|^hpdb:|^www:|^smmsp:" >> /dev/null; then
 echo "Review the above list to ensure they are all system accounts" >> $Results
 echo "Fail" >> $Results
else
 echo "All accounts listed above are default system accounts" >> $Results
 echo "Pass" >> $Results
fi