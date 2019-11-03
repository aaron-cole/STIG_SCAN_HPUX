#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#To protect the integrity of scheduled system jobs and prevent malicious modification to these jobs, crontab files must be secured.

#STIG Identification
GrpID="V-11994"
GrpTitle="GEN003040"
RuleID="SV-38250r1_rule"
STIGID="GEN003040"
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
#File or Directory to check
files="/var/spool/cron/crontabs/*"
scorecheck=0

for file in $files; do
 if [ -e $file ]; then
  OwnerID="$(perl -le'print((stat shift)[4])' $file)"
  echo "UID for $file is $OwnerID" >> $Results
  case "$OwnerID" in
	0|root) echo "" >> /dev/null;;
	*) ((scorecheck+=1));;
  esac
 else
  echo "$file does not exist" >> $Results
  ((scorecheck+=1))
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi

#MUST ADD IN TO CHECK FOR OWNER Creation