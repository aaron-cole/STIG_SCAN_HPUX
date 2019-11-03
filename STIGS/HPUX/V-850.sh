#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#.Xauthority files ensure the user is authorized to access the specific X Windows host. If .Xauthority files are not used, it may be possible to obtain unauthorized access to the X Windows host.

#STIG Identification
GrpID="V-850"
GrpTitle="GEN005160"
RuleID="SV-35160r1_rule"
STIGID="GEN005160"
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