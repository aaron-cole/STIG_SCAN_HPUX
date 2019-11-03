#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The ftpusers file contains a list of accounts not allowed to use FTP to transfer files. If the file does not contain the names of all accounts not authorized to use FTP, then unauthorized use of FTP may take place.

#STIG Identification
GrpID="V-841"
GrpTitle="GEN004900"
RuleID="SV-35103r1_rule"
STIGID="GEN004900"
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
scorecheck=0

if [ "$(grep -v "^#" /etc/inetd.conf | grep -c -i ^"ftp")" != 0 ]; then
 if [ -e /etc/ftpd/ftpusers ]; then
  OTHERSYSACCTS="cimsrvr sfmdb iwww owww hpsmh sshd ids smtp"
  SYSACCTS="$(logins -s | awk '{print $1)')" 
  for SYSACCT in $SYSACCTS $OTHERSYSACCTS; do
   if grep "^$SYSACCT:" /etc/passwd >> /dev/null; then
    if grep "^$SYSACCT" /etc/ftpd/ftpusers >> /dev/null; then
     echo "PASS - $SYSACCT - Default System account is listed in /etc/ftpd/ftpusers" >> $Results
    else
     echo "FAIL - $SYSACCT - Default System account is NOT listed in /etc/ftpd/ftpusers" >> $Results
	 ((scorecheck+=1))
    fi
   fi
  done
 else
  echo "FTPD is enabled and /etc/ftpd/ftpusers does not exist" >> $Results
  ((scorecheck+=1))
 fi
else
 echo "FTP service is not found or enabled - nothing to exluded from use of ftpd" >> $Results 
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi