#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the SMTP service log file is not owned by root, then unauthorized personnel may modify or delete the file to hide a system compromise.

#STIG Identification
GrpID="V-837"
GrpTitle="GEN004480"
RuleID="SV-35053r1_rule"
STIGID="GEN004480"
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

if egrep -v "^#" /etc/syslog.conf | egrep "mail.info|mail.debug|mail.\*|\*.info|\*.debug|\*.\*" >> $Results; then
 for file in $(egrep -v "^#|mail.none" /etc/syslog.conf | egrep "mail.info|mail.debug|mail.\*|\*.info|\*.debug|\*.\*|mail." | awk '{print $2}' | grep -v "^\@"); do
  if [ -e $file ]; then
   OwnerID="$(perl -le'print((stat shift)[4])' $file)"
   echo "UID for $file is $OwnerID" >> $Results
   case "$OwnerID" in
	0|root) echo "PASS - $(ls -l $file)" >> $Results;;
	*) echo "FAIL - $(ls -l $file)" >> $Results
	   ((scorecheck+=1));;
   esac
  else
   echo "file doesn't appear to exist.. ?" >> $Results
  fi
 done
else
 echo "No log file that gets mail found" >> $Results
 echo "Fail" >> $Results
fi
 
if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi