#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The /etc/pam.conf file is the system configuration file for the Pluggable Authentication Module (PAM) architecture. It supports per user authentication, account, session, and password management. If the configuration is modified maliciously, users may gain unauthorized system access. 

#STIG Identification
GrpID="V-40476"
GrpTitle="GEN000000-HPUX0370"
RuleID="SV-52464r1_rule"
STIGID="GEN000000-HPUX0370"
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
file="/etc/pam.conf"

#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 echo "Not Applicable for Trusted Mode Systems"  >> $Results
 echo "NA" >> $Results
else
#For SMSE
 GOwnerID="$(perl -le'print((stat shift)[5])' $file)"
 if [ -f $file ]; then
  ls -lL $file >> $Results
 elif [ -d $file ]; then
  ls -ld $file >> $Results
 else
  echo "Not a file or dir" >> $Results
 fi
 case "$GOwnerID" in
	3|sys) echo "Pass" >> $Results;;
	*) echo "Fail" >> $Results;;
 esac
fi