#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The UUCP utility is designed to assist in transferring files, executing remote commands, and sending e-mail between UNIX systems over phone lines and direct connections between systems. The UUCP utility is a primitive and arcane system with many security issues. There are alternate data transfer utilities/products that can be configured to more securely transfer data by providing for authentication as well as encryption.

#STIG Identification
GrpID="V-4696"
GrpTitle="GEN005280"
RuleID="SV-35171r1_rule"
STIGID="GEN005280"
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

grep -v "^#" /etc/inetd.conf | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -i "uucp" >> $Results

if [ "$(grep -v "^#" /etc/inetd.conf | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -c -i "uucp")" != 0 ]; then
 echo "uucp service is enabled" >> $Results 
 echo "Fail" >> $Results 
else
 echo "uucp service is not found" >> $Results 
 echo "Pass" >> $Results
fi