#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#/etc/pam.conf file is the system configuration file for the Pluggable Authentication Module (PAM) architecture. It supports per user authentication, account, session, and password management. If the configuration is modified maliciously, users may gain unauthorized system access. 

#STIG Identification
GrpID="V-40473"
GrpTitle="GEN000000-HPUX0360"
RuleID="SV-52461r1_rule"
STIGID="GEN000000-HPUX0360"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

#File or Directory to check
file="/etc/pam.conf"

#Check
#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 echo "Not Applicable for Trusted Mode Systems"  >> $Results
 echo "NA" >> $Results
else
#For SMSE
 OwnerID="$(perl -le'print((stat shift)[4])' $file)"
 if [ -f $file ]; then
  ls -lL $file >> $Results
 elif [ -d $file ]; then
  ls -ld $file >> $Results
 else
  echo "Not a file or dir" >> $Results
 fi
 case "$OwnerID" in
	0|root) echo "Pass" >> $Results;;
	*) echo "Fail" >> $Results;;
 esac
fi