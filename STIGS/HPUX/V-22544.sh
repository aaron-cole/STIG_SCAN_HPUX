#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Proxy Neighbor Discovery Protocol (NDP) allows a system to respond to NDP requests on one interface on behalf of hosts connected to another interface. If this function is enabled when not required, addressing information may be leaked between the attached network segments.

#STIG Identification
GrpID="V-22544"
GrpTitle="GEN007760"
RuleID="SV-29601r1_rule"
STIGID="GEN007760"
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

status="$(ndp -a 2>>$Results)"

if [ -n "$status" ]; then
 if echo "$status" | grep " P " >> $Results; then
  echo "Fail" >> $Results
 else
  echo "$status" >> $Results
  echo "No Entries with P flag found" >> $Results
  echo "Pass" >> $Results
 fi
else
 echo "Pass" >> $Results
fi
