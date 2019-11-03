#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If graphical desktop sessions do not lock the session after 15 minutes of inactivity, requiring re-authentication to resume operations, the system or individual data could be compromised by an alert intruder who could exploit the oversight. This requirement applies to graphical desktop environments provided by the system to locally attached displays and input devices as well as to graphical desktop environments provided to remote systems, including thin clients.

#STIG Identification
GrpID="V-4083"
GrpTitle="GEN000500"
RuleID="SV-38416r2_rule"
STIGID="GEN000500"
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

if swlist -l product | grep "CDE User Interface" >> $Results; then
 if [ -e /etc/dt/config/C/sys.resources ]; then
  if grep "dtsession*lockTimeout: 15" | grep -v "^#" >> $Results; then
   echo "Pass" >> $Results
  else
   echo "Setting not set correctly" >> $Results
   grep "dtsession*lockTimeout" | grep -v "^#" >> $Results
   echo "Fail" >> $Results
  fi
 else
  if grep "^RUN_X_FONT_SERVER=0" /etc/rc.config.d/xfs >> $Results; then
   echo "Desktop configured to NOT run" >> $Results
   echo "Pass" >> $Results
  else
   echo "Desktop configured to run and setting not set as required" >> $Results
   echo "Fail" >> $Results
  fi
 fi
else
 echo "Desktop environment not installed" >> $Results
 echo "NA" >> $Results
fi
