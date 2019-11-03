#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#When operating in standard  mode, account passwords are stored in the /etc/passwd file, which is world readable. By operating in either Trusted Mode or Standard Mode with Security Extensions, the system security posture is enhanced thru the addition of a secure, non-world readable password container other than /etc/passwd.

#STIG Identification
GrpID="V-960"
GrpTitle="GEN000000-HPUX0020"
RuleID="SV-38681r2_rule"
STIGID="GEN000000-HPUX0020"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

###Check###
#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 echo "System is in Trusted Mode System"  >> $Results
 echo "/tcb directory tree exists" >> $Results
 echo "Pass" >> $Results
else 
#For SMSE mode
 if [ -d /var/adm/userdb ]; then
  if [ -f /etc/shadow ]; then
   echo "System is in SMSE Mode" >> $Results
   echo "/etc/shadow exists" >> $Results
   echo "Pass" >> $Results
  else
   echo "System is in SMSE Mode" >> $Results
   echo "/etc/shadow doesn't exist" >> $Results
   echo "Fail" >> $Results
  fi
 else
  echo "/var/adm/userdb tree doesn't exist" >> $Results
  echo "Fail" >> $Results
 fi
fi