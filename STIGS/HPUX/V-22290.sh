#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-22290"
GrpTitle="GEN000241"
RuleID="SV-38289r1_rule"
STIGID="GEN000241"
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

if crontab -l | grep ntpdate | grep -v "^#" >> $Results; then
 echo "crontab ntpdate entry found" >> $Results
 echo "Pass" >> $Results
elif grep -i "XNTPD=1" /etc/rc.config.d/netdaemons | grep -v "^#" >> $Results; then
 if ps -ef | grep ntp | grep -v "grep" >> $Results; then
  echo "NTP is being used" >> $Results
  echo "Pass" >> $Results
 else
  echo "NTP is set to run, but not running" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "Fail" >> $Results
fi
