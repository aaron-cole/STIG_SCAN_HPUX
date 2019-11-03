#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#FTP is typically unencrypted and, therefore, presents confidentiality and integrity risks.  FTP may be protected by encryption in certain cases, such as when used in a Kerberos environment.   SFTP and FTPS are encrypted alternatives to FTP.

#STIG Identification
GrpID="V-12010"
GrpTitle="GEN004800"
RuleID="SV-35098r1_rule"
STIGID="GEN004800"
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

grep -v "^#" /etc/inetd.conf | grep -i ^"ftp" >> $Results

if [ "$(grep -v "^#" /etc/inetd.conf | grep -c -i ^"ftp")" != 0 ]; then
 echo "FTP service is enabled" >> $Results 
 echo "Fail" >> $Results 
else
 echo "FTP service is not found" >> $Results 
 echo "Pass" >> $Results
fi