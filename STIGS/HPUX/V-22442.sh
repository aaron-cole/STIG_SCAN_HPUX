#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the SMTP service log file has an extended ACL, unauthorized users may be allowed to access or to modify the log file.

#STIG Identification
GrpID="V-22442"
GrpTitle="GEN004510"
RuleID="SV-38368r1_rule"
STIGID="GEN004510"
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
logfilelist="$(egrep -i "mail.crit|mail.\*|\*.crit|mail.debug|\*.debug" /etc/syslog.conf | grep -v "^#" | awk '{print $2}' | grep "^/")"

for logfile in $logfilelist; do
 if [ -e "$logfile" ]; then
  if ls -lL $logfile | grep '^[a-zA-Z\-]\{10\}+' >> $Results; then
   echo "FAIL - $logfile has an ACL" >> $Results
   ((scorecheck+=1))
  else
    echo "Pass - $logfile DOES NOT have an ACL" >> $Results
	ls -lL $logfile >> $Results
  fi
 fi
done
 
if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi