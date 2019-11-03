#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-22291"
GrpTitle="GEN000242"
RuleID="SV-38297r1_rule"
STIGID="GEN000242"
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
 echo "Ensure 2 servers are being used" >> $Results
 echo "Fail" >> $Results
elif grep -i "XNTPD=1" /etc/rc.config.d/netdaemons | grep -v "^#" >> $Results; then
 if ps -ef | grep ntp | grep -v "grep" >> $Results; then
  if [ "$(egrep -v "127.127.1.1|127.127.1.0|^#" /etc/ntp.conf | grep -i server | wc -l)" -ge 2 ]; then
   egrep -v "127.127.1.1|127.127.1.0|^#" /etc/ntp.conf | grep -i server >> $Results
   echo "NTP is set to run, running, and has 2 or more servers" >> $Results
   echo "Pass" >> $Results
  else
   echo "2 or more servers are not definined in /etc/ntp.conf" >> $Results
   echo "Fail" >> $Results
  fi
 else
  echo "NTP is set to run, but not running" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "Fail" >> $Results
fi