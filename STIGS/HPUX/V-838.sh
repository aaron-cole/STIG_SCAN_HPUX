#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the SMTP service log file is more permissive than 0644, unauthorized users may be allowed to change the log file.

#STIG Identification
GrpID="V-838"
GrpTitle="GEN004500"
RuleID="SV-35058r1_rule"
STIGID="GEN004500"
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
filecheckmode="644"

if egrep -v "^#" /etc/syslog.conf | egrep "mail.info|mail.debug|mail.\*|\*.info|\*.debug|\*.\*" >> $Results; then
 for file in $(egrep -v "^#|mail.none" /etc/syslog.conf | egrep "mail.info|mail.debug|mail.\*|\*.info|\*.debug|\*.\*|mail." | awk '{print $2}' | grep -v "^\@"); do
  if [ -e $file ]; then
   filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
   if [ $filemode -le $filecheckmode ]; then
    echo "PASS - $(ls -l $file)" >> $Results
   else
    echo "FAIL - $(ls -l $file)" >> $Results
   ((scorecheck+=1))
   fi
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