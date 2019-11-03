#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#To protect the integrity of scheduled system jobs and prevent malicious modification to these jobs, crontab files must be secured.

#STIG Identification
GrpID="V-22385"
GrpTitle="GEN003050"
RuleID="SV-38358r1_rule"
STIGID="GEN003050"
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

for CRONFILE in /var/spool/cron/crontabs/*; do
 USER="$(echo "$CRONFILE" | cut -f 6 -d "/")" 
 usergrpid="$(grep "^$USER:" /etc/passwd | cut -f 4 -d ":")"
 cronuid="$(grep "^cron:" /etc/passwd | cut -f 4 -d ":")"
 GOwnerID="$(perl -le'print((stat shift)[5])' $CRONFILE)"
 echo "GID for $CRONFILE is $GOwnerID" >> $Results
 case "$GOwnerID" in
	 0|2|$usergrpid|$cronuid) echo "PASS - $(ls -l $CRONFILE)" >> $Results;;
	 *) echo "FAIL - $(ls -l $CRONFILE)" >> $Results
	   ((scorecheck+=1)) ;;
 esac
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi
