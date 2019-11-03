#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If a user accesses the root account (or any account) using an unencrypted connection, the password is passed over the network in clear text form and is subject to interception and misuse.  This is true even if recommended procedures are followed by logging on to a named account and using the su command to access root.

#STIG Identification
GrpID="V-1046"
GrpTitle="GEN001100"
RuleID="SV-38240r1_rule"
STIGID="GEN001100"
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

if last -R | grep "^root " | egrep -v "reboot|console" >> $Results; then
 echo "Root appears to be logging in over the network" >> $Results
 echo "Fail" >> $Results
else
 echo "Root Does not appear to be logging in over the network" >> $Results
 echo "Pass" >> $Results
fi
