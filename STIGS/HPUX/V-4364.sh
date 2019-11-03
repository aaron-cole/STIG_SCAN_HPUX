#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the at directory has a mode more permissive than 0755, unauthorized users could be allowed to view or to edit files containing sensitive information within the at directory. Unauthorized modifications could result in Denial of Service to authorized at jobs.

#STIG Identification
GrpID="V-4364"
GrpTitle="GEN003400"
RuleID="SV-38433r1_rule"
STIGID="GEN003400"
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
files="/var/spool/cron/atjobs /var/spool/atjobs /var/spool/at"
scorecheck=0

for file in $files; do
 if [ -e $file ]; then
  filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
  checkmode="755"
  if [ $filemode -le $checkmode ]; then
   echo "$file is $filemode and less than or equal to $checkmode" >> $Results
  else
   echo "$file is $filemode and not less than or equal to $checkmode" >> $Results
   ((scorecheck+=1))
  fi
 else
  echo "$file does not exist" >> $Results
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi