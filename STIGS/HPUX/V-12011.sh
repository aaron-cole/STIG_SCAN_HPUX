#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The umask controls the default access mode assigned to newly created files. An umask of 077 limits new files to mode 700 or less permissive. Although umask is stored as a 4-digit number, the first digit representing special access modes is typically ignored or required to be zero.

#STIG Identification
GrpID="V-12011"
GrpTitle="GEN005040"
RuleID="SV-38263r1_rule"
STIGID="GEN005040"
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

if grep "^ftp:" /etc/passwd >> $Results; then
 if [ "$(sudo su ftp -c 'umask')" = "077 " ]; then
  echo "PASS - Umask value for ftp is $(sudo su ftp -c 'umask')" >> $Results
  echo "Pass" >> $Results
 else
  echo "FAIL - Umask value for ftp is $(sudo su ftp -c 'umask')" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "ftp account does not exist on server" >> $Results
 echo "Pass" >> $Results
fi