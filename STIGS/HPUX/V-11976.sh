#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Limiting the lifespan of authenticators limits the period of time an unauthorized user has access to the system while using compromised credentials and reduces the period of time available for password guessing attacks to run against a single password.

#STIG Identification
GrpID="V-11976"
GrpTitle="GEN000700"
RuleID="SV-38247r3_rule"
STIGID="GEN000700"
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

for user in $(logins -o -x -r local | awk -F: '{print $1":"$11}'); do
 if [ "$(echo $user| awk -F: '{print $2}')" = "-1" ] || [ "$(echo $user| awk -F: '{print $2}')" = "0" ] || [ "$(echo $user| awk -F: '{print $2}')" -gt "60" ]; then
  if [ "$(echo $user | awk -F: '{print $1}')" = "root" ]; then
   continue
  else
   echo "Is this a system/application account? - $(echo $user) - If it is disregard this account" >> $Results
   ((scorecheck+=1))
  fi
 else
  echo "Pass - $(echo $user)" >> $Results
 fi
done 
  
if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi