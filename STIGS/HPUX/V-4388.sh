#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If an anonymous FTP account does not use a chroot or similarly isolated environment,  the system may be more vulnerable to exploits against the FTP service.  Such exploits could allow an attacker to gain shell access to the system and view, edit, or remove sensitive files.

#STIG Identification
GrpID="V-4388"
GrpTitle="GEN005020"
RuleID="SV-35108r1_rule"
STIGID="GEN005020"
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

if [ -e /usr/lbin/ftpd ]; then
#ftp user acct
 if grep "^ftp" /etc/passwd >> $Results; then
  if grep "^ftp" /etc/passwd | cut -f 6 -d ":" | grep "\." >> /dev/null; then
   echo "Chroot seems to be setup correctly for ftp acct" >> $Results
  else
   echo "Chroot not setup for ftp acct" >> $Results
   ((scorecheck+=1))
  fi
 else
  echo "ftp user acct not found" >> $Results
 fi
#anonymous user acct
 if grep "^anonymous" /etc/passwd >> $Results; then
  if grep "^anonymous" /etc/passwd | cut -f 6 -d ":" | grep "\." >> /dev/null; then
   echo "Chroot seems to be setup correctly for anonymous acct" >> $Results
  else
   echo "Chroot not setup for anonymous acct" >> $Results
   ((scorecheck+=1))
  fi
 else
  echo "anonymous user acct not found" >> $Results
 fi   
else
 echo "FTP does not appeared to be installed" >> $Results
fi


if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Pass" >> $Results
fi