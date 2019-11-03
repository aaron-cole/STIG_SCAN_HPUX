#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If an anonymous FTP account has been configured to use a functional shell, attackers could gain access to the shell if the account is compromised.

#STIG Identification
GrpID="V-4387"
GrpTitle="GEN005000"
RuleID="SV-35106r1_rule"
STIGID="GEN005000"
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

if grep "^ftp" /etc/passwd >> $Results; then
 if grep "^ftp" /etc/passwd | cut -f 7,7 -d ":" | egrep -c -i "\/bin\/false|\/dev\/null|\/usr\/bin\/false|\/bin\/true|\/sbin\/nologin" >> /dev/null ; then
  echo "ftp account's shell is set properly" >> $Results
  echo "Pass" >> $Results
 else
  echo "ftp account's shell is NOT set properly" >> $Results
  echo "Fail" >> $Results  
 fi
else
 echo "ftp account not found" >> $Results
 echo "Pass" >> $Results
fi
