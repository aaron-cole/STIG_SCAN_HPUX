#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-24331"
GrpTitle="GEN000402"
RuleID="SV-38411r1_rule"
STIGID="GEN000402"
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
 if grep "^RUN_X_FONT_SERVER=0" /etc/rc.config.d/xfs >> $Results; then
   echo "Desktop configured to NOT run" >> $Results
   echo "Pass" >> $Results
  else
   echo "Desktop configured to run and setting needs to be manuall reviewed" >> $Results
   echo "Fail" >> $Results
  fi
else
 echo "Desktop environment not installed" >> $Results
 echo "Pass" >> $Results
fi 