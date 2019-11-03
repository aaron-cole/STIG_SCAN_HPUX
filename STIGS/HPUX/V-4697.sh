#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Open X displays allow an attacker to capture keystrokes and to execute commands remotely. Many users have their X Server set to xhost +, permitting access to the X Server by anyone, from anywhere.

#STIG Identification
GrpID="V-4697"
GrpTitle="GEN005200"
RuleID="SV-35168r1_rule"
STIGID="GEN005200"
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

if ps -ef | grep dtlogin | grep -v grep >> $Results; then
 echo "Check must be performed in X Windows" >> $Results
 echo "Fail" >> $Results
else
 echo "X Windows Server is not running" >> $Results
 if [ ! -e /usr/dt/config/Xconfig ] && [ ! -e /etc/dt/config/Xconfig ]; then
  echo "X Windows Server has no configuration files to even start" >> $Results
  echo "X Windows Server cannot be used" >> $Results
  echo "NA" >> $Results
 else
  echo "X Windows cannot be used - check is not applicable" >> $Results
  echo "NA" >> $Results
 fi
fi