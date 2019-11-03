#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The minimal set of auditing requirements necessary to collect useful forensics data and provide user help when violations are detected must be configured.

#STIG Identification
GrpID="V-4290"
GrpTitle="GEN000000-HPUX0040"
RuleID="SV-38429r2_rule"
STIGID="GEN000000-HPUX0040"
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
cat /etc/rc.config.d/auditing | tr "\011" " " | tr -s " " | sed -e 's/^[\t]*//' | grep -v "#" | grep AUDOMON_ARGS >> $Results

if cat /etc/rc.config.d/auditing | tr "\011" " " | tr -s " " | sed -e 's/^[\t]*//' | grep -v "#" | grep AUDOMON_ARGS | grep "p 20" | grep "t 1" | grep "w 90" >> /dev/null; then
 echo "HP AUDOMON_ARGS explicitly initialized"  >> $Results
 echo "Pass" >> $Results
else 
 echo "HP AUDOMON_ARGS NOT explicitly initialized" >> $Results
 echo "Fail" >> $Results
fi