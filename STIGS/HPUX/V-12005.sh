#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Unnecessary services should be disabled to decrease the attack surface of the system.

#STIG Identification
GrpID="V-12005"
GrpTitle="GEN003700"
RuleID="SV-35064r1_rule"
STIGID="GEN003700"
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

if ps -ef | grep -v "grep" | egrep "inetd|xinetd" >> $Results; then
 if swlist -l bundle | grep -i "xinetd" >> /dev/null; then
  file="/etc/xinetd.conf"
 elif swlist -l product | grep "inet" | grep -v -i xinet >> /dev/null; then
  file="/etc/inetd.conf"
 else
  file="$(find /etc -type f -name xinetd -o -name inetd.conf)"
 fi
 if [ -e $file ]; then
  entries="$(cat $file | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | egrep -v "^#|^$")"
  if [ -z "$entries" ]; then
   echo "No active service found and inetd/xinetd is running" >> $Results
   echo "Fail" >> $Results
  else
   echo "Active service found and inetd/xinetd is running" >> $Results
   echo "Pass" >> $Results
  fi
 else
  echo "inetd/xinetd is running and no config file found" >> $Results
  echo "Fail" >> $Results
 fi
else 
 echo "inetd or xinetd are not running" >> $Results
 echo "Pass" >> $Results
fi