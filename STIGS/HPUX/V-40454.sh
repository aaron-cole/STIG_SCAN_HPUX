#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Unless the userdb is required, the /var/adm/userdb/USERDB.DISABLED file must be created to disable the use of per-user security attributes in the user database. Attributes in the user database override the system-wide settings configured in /etc/default/security. If the system-wide configuration is overridden maliciously, users may gain unauthorized system access. 

#STIG Identification
GrpID="V-40454"
GrpTitle="GEN000000-HPUX0310"
RuleID="SV-52441r1_rule"
STIGID="GEN000000-HPUX0310"
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
#File or Directory to check
file="/var/adm/userdb/USERDB.DISABLED"

#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 echo "Not Applicable for Trusted Mode Systems"  >> $Results
 echo "NA" >> $Results
else
#For SMSE
 if [ -e $file ]; then
  if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
   echo "Fail" >> $Results
  else
   echo "Pass"  >> $Results
  fi
 else
  echo "File does not exist" >> $Results
  echo "Fail" >> $Results
 fi
fi