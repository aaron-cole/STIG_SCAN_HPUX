#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Due to the numerous vulnerabilities inherent in anonymous FTP, it is not recommended for use.  If anonymous FTP must be used on a system, the requirement must be authorized and approved in the system accreditation package.

#STIG Identification
GrpID="V-846"
GrpTitle="GEN004820"
RuleID="SV-35100r1_rule"
STIGID="GEN004820"
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

if [ "$(grep -v "^#" /etc/inetd.conf | grep -c -i ^"ftp")" != 0 ]; then
 if egrep "^ftp|^anonymous" /etc/passwd >> $Results; then
  echo "ftpd is enabled and users were found" >> $Results
  echo "Fail" >> $Results
 else
  echo "ftpd is enabled and default users were not found" >> $Results
  echo "Pass" >> $Results 
 fi
else
 echo "FTP service is not found or enabled" >> $Results 
 echo "Pass" >> $Results
fi