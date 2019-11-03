#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-1026"
GrpTitle="GEN006080"
RuleID="SV-35211r1_rule"
STIGID="GEN006080"
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

if swlist -l bundle | egrep -i "cifs-server|cifs-client" >> $Results; then 
 echo "Has SWAT been DISABLED or Configured to use SSL" >> $Results
 echo "Fail" >> $Results
else
 echo "Samaba is not installed" >> $Results
 echo "NA" >> $Results
fi