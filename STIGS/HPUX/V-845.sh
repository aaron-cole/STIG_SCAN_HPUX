#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The -l option allows basic logging of connections.  The verbose (on HP) and the debug (on Solaris) allow logging of what files the ftp session transferred.  This extra logging makes it possible to easily track which files are being transferred onto or from a system.  If they are not configured, the only option for tracking is the audit files.  The audit files are much harder to read.  If auditing is not properly configured, then there would be no record at all of the file transfer transactions.

#STIG Identification
GrpID="V-845"
GrpTitle="GEN004980"
RuleID="SV-38995r1_rule"
STIGID="GEN004980"
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
 if [ "$(grep -v "^#" /etc/inetd.conf | grep "ftpd" | grep -c " -v")" != 0 ]; then 
  echo "Verbose logging is enabled" >> $Results
  echo "Pass" >> $Results
 else
  echo "Verbose logging is NOT enabled" >> $Results
  echo "Fail" >> $Results 
 fi
else
 echo "FTP service is not found" >> $Results 
 echo "Pass" >> $Results
fi