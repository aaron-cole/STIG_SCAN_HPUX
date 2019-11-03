#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#TFTP is a file transfer protocol often used by embedded systems to obtain configuration data or software.    The service is unencrypted and does not require authentication of requests.  Data available using this service may be subject to unauthorized access or interception.

#STIG Identification
GrpID="V-4695"
GrpTitle="GEN005140"
RuleID="SV-38440r1_rule"
STIGID="GEN005140"
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

grep -v "^#" /etc/inetd.conf | grep -i "^tftp" >> $Results

if [ "$(grep -v "^#" /etc/inetd.conf | grep -c -i tftp)" != 0 ]; then
 echo "tftp service is enabled. Is it documented with ISSM?" >> $Results 
 echo "Fail" >> $Results 
else
 echo "tftp service is not found" >> $Results 
 echo "Pass" >> $Results
fi