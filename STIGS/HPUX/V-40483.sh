#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The per user PAM configuration file (/etc/pam_user.conf) allows individual users to be assigned options that differ from those of the general computing community. This file is optional and should only be used if PAM applications are required to operate differently for specific users, i.e., to isolate the administrative user accounts.

#STIG Identification
GrpID="V-40483"
GrpTitle="GEN000000-HPUX0400"
RuleID="SV-52472r1_rule"
STIGID="GEN000000-HPUX0400"
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
###########################

#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 echo "Not Applicable for Trusted Mode Systems"  >> $Results
 echo "NA" >> $Results
else
#For SMSE
 if [ -f /etc/pam_user.conf ]; then
  cat /etc/pam_user.conf >> $Results
  if [ -s /etc/pam_user.conf ]; then
   echo "Fail" >> $Results
  else
   echo "Pass" >> $Results
  fi
 else
  echo "File does not exist" >> $Results
  echo "Fail" >> $Results
 fi
fi