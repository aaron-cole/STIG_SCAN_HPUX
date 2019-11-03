#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If an application is providing a continuous display and is running with root privileges, unauthorized users could interrupt the process and gain root access to the system.

#STIG Identification
GrpID="V-769"
GrpTitle="GEN000520"
RuleID="SV-38447r1_rule"
STIGID="GEN000520"
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

if [ $(ps -ef | grep X11 | grep -v grep) ] && [ $(ps -ef | grep dtlogin | grep -v grep) ]; then
 echo "Manual Check" >> $Results
 echo "Fail" >> $Results
else
 echo "X Windows Server is not running" >> $Results
 if [ ! -e /usr/dt/config/Xconfig ] && [ ! -e /etc/dt/config/Xconfig ]; then
  echo "X Windows Server has no configuration files to even start" >> $Results
  echo "X Windows Server cannot be used" >> $Results
 fi
 echo "Pass" >> $Results
fi
