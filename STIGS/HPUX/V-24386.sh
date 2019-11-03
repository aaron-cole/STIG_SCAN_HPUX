#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The telnet daemon provides a typically unencrypted remote access service which does not provide for the confidentiality and integrity of user passwords or the remote session. If a privileged user were to log on using this service, the privileged user password could be compromised.

#STIG Identification
GrpID="V-24386"
GrpTitle="GEN003850"
RuleID="SV-35134r1_rule"
STIGID="GEN003850"
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

cat /etc/inetd.conf | tr '\011' ' '| tr -s ' ' | sed -e 's/^[ \t]*//' | grep -v "^#" | cut -f 6,7 -d " " | grep -c -i telnetd >> $Results

if [ "$(cat /etc/inetd.conf | tr '\011' ' '| tr -s ' ' | sed -e 's/^[ \t]*//' | grep -v "^#" | cut -f 6,7 -d " " | grep -c -i telnetd)" != 0 ]; then
 echo "telnetd service is enabled" >> $Results 
 echo "Fail" >> $Results 
else
 echo "telnetd service is not found" >> $Results 
 echo "Pass" >> $Results
fi