#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The /etc/pam.conf file is the system configuration file for the Pluggable Authentication Module (PAM) architecture. It supports per user authentication, account, session, and password management. If the configuration is modified maliciously, users may gain unauthorized system access. 

#STIG Identification
GrpID="V-40478"
GrpTitle="GEN000000-HPUX0380"
RuleID="SV-52466r1_rule"
STIGID="GEN000000-HPUX0380"
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
 filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
 checkmode="444"
 if [ $filemode -le $checkmode ]; then
  echo "Perl stat for $file is $filemode and less than or equal to $checkmode" >> $Results
  echo "Pass" >> $Results
 else
  echo "Perl stat for $file is $filemode and not less than or equal to $checkmode" >> $Results
  echo "Fail" >> $Results
 fi
fi