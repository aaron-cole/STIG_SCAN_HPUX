#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Implementing NIS or NIS+ under UDP may make the system more susceptible to a Denial of Service attack and does not provide the same quality of service as TCP.

#STIG Identification
GrpID="V-4399"
GrpTitle="GEN006380"
RuleID="SV-35147r1_rule"
STIGID="GEN006380"
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

if grep -v "^#" /etc/nsswitch.conf | egrep "nis|nisplus" >> $Results; then
 if rpcinfo -p | grep yp | grep udp >> $Results; then
  echo "System is using NIS/NIS+ and implemented using UDP" >> $Results
  echo "Fail" >> $Results
 else
  echo "System is using NIS/NIS+ and not implemented using UDP" >> $Results
  echo "Pass" >> $Results
 fi
else
 echo "System is not using NIS/NIS+"  >> $Results
 echo "NA" >> $Results
fi