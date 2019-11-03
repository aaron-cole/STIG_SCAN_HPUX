#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The ftpusers file contains a list of accounts not allowed to use FTP to transfer files. If this file does not exist, then unauthorized accounts can utilize FTP.

#STIG Identification
GrpID="V-840"
GrpTitle="GEN004880"
RuleID="SV-35102r1_rule"
STIGID="GEN004880"
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

if [ ! -e /etc/ftpd/ftpusers ]; then
 echo "/etc/ftpd/ftpusers does not exist" >> $Results
 altfile="$(find / -type f -name ftpusers)"
 if [ -z "$altfile" ]; then
  echo "No other ftpusers file found" >> $Results
  echo "Fail" >> $Results
 else
  for file in $altfile; do
   ls -l $file >> $Results
  done
  echo "Pass" >> $Results
 fi
else 
 ls -l /etc/ftpd/ftpusers >> $Results
 echo "Pass" >> $Results
fi