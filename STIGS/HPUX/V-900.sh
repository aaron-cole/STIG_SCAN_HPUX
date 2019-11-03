#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If a user has a home directory defined that does not exist, the user may be given the / directory, by default, as the current working directory upon logon. This could create a Denial of Service because the user would not be able to perform useful tasks in this location.

#STIG Identification
GrpID="V-900"
GrpTitle="GEN001460"
RuleID="SV-38489r2_rule"
STIGID="GEN001460"
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

if pwck >> $Results; then
 if pwck | grep -i "Login directory not found" >> /dev/null; then
  echo "A User's home directory does not exist" >> $Results
  if [ "$(grep -v "^#" /etc/pam.conf | grep "libpam_mkdir.so.1" | egrep "^login|^sshd|^OTHER" | grep "required" | grep "session" | wc -l)" -ge 3 ]; then
   echo "System is configured to automatically create home directories on first login per pam.conf" >> $Results
   grep ".*session.*required.*libpam_mkdir" /etc/pam.conf >> $Results
   echo "Pass" >> $Results
  else 
   echo "System is NOT configured to automatically create home directories on first login per pam.conf" >> $Results
   echo "Fail" >> $Results
  fi
 else
  echo "All Users home directories exist" >> $Results
  echo "Pass" >> $Results
 fi
else
 echo "All Users home directories exist" >> $Results
 echo "Pass" >> $Results
fi