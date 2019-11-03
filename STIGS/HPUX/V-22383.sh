#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Actions concerning dynamic kernel modules must be recorded as they are substantial events.  Dynamic kernel modules can increase the attack surface of a system.  A malicious kernel module can be used to substantially alter the functioning of a system, often with the purpose of hiding a compromise from the SA.

#STIG Identification
GrpID="V-22383"
GrpTitle="GEN002825"
RuleID="SV-26525r2_rule"
STIGID="GEN002825"
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

if [ ! -f /etc/audit/audit_site.conf ]; then
 echo "/etc/audit/audit_site.conf does not exist" >> $Results
 if grep "admin" /etc/audit/audit.conf | grep -v "^#" | grep "EVENT admin" >> $Results; then
  echo "admin syscalls are defined" >> $Results
  if grep "modload" /etc/audit/audit.conf | grep -v "^#" >> $Results; then
   echo "modload syscalls are defined" >> $Results
   if grep "moduload" /etc/audit/audit.conf | grep -v "^#" >> $Results; then
    echo "moduload syscalls are defined" >> $Results
    if grep "modpath" /etc/audit/audit.conf | grep -v "^#" >> $Results; then
	 echo "modpath syscalls are defined" >> $Results
	 echo "Pass" >> $Results
	else
	 echo "modpath syscalls are NOT defined" >> $Results
	 echo "Fail" >> $Results
	fi
   else
	echo "moduload syscalls are NOT defined" >> $Results
	echo "Fail" >> $Results
   fi
  else
   echo "modload syscalls are NOT defined" >> $Results
   echo "Fail" >> $Results
  fi
 else
  echo "admin syscalls are NOT defined" >> $Results
  echo "Fail" >> $Results
 fi
else
 if grep "admin" /etc/audit/audit_site.conf | grep -v "^#" | grep "EVENT admin" >> $Results; then
  echo "admin syscalls are defined" >> $Results
  if grep "modload" /etc/audit/audit_site.conf | grep -v "^#" | grep "EVENT admin" >> $Results; then
   echo "modload syscalls are defined" >> $Results
   if grep "moduload" /etc/audit/audit_site.conf | grep -v "^#" | grep "EVENT admin" >> $Results; then
    echo "moduload syscalls are defined" >> $Results
    if grep "modpath" /etc/audit/audit_site.conf | grep -v "^#" | grep "EVENT admin" >> $Results; then
	 echo "modpath syscalls are defined" >> $Results
	 echo "Pass" >> $Results
	else
	 echo "modpath syscalls are NOT defined" >> $Results
	 echo "Fail" >> $Results
	fi
   else
	echo "moduload syscalls are NOT defined" >> $Results
	echo "Fail" >> $Results
   fi
  else
   echo "modload syscalls are NOT defined" >> $Results
   echo "Fail" >> $Results
  fi
 else
  echo "admin syscalls are NOT defined" >> $Results
  echo "Fail" >> $Results
 fi
fi