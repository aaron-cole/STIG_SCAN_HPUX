#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Process core dumps contain the memory in use by the process when it crashed.  Process core dump files can be of significant size and their use can result in file systems filling to capacity, which may result in Denial of Service.  Process core dumps can be useful for software debugging.  

#STIG Identification
GrpID="V-11996"
GrpTitle="GEN003500"
RuleID="SV-35008r1_rule"
STIGID="GEN003500"
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

if [ "$(grep -c "ulimit" /etc/profile| grep -v "^#")" -gt 0 ]; then
 if grep "ulimit -c 0" /etc/profile >> $Results; then
  echo "Required ulimit Setting Set" >> $Results
  echo "Pass" >> $Results
 else
  echo "Required ulimit Setting NOT Set" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "ulimit Setting not found in /etc/profile" >> $Results
fi