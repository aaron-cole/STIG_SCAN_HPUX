#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Access control programs (such as TCP_WRAPPERS) provide the ability to enhance system security posture.

#STIG Identification
GrpID="V-940"
GrpTitle="GEN006580"
RuleID="SV-35198r1_rule"
STIGID="GEN006580"
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

if [ -e /var/adm/inetd.sec ]; then
 if [ "$(egrep -v "^#|^$" /var/adm/inetd.sec | wc -l)" -gt 3 ]; then
  echo "/var/adm/inetd.sec is being used" >> $Results
  echo "Pass" >> $Results
 else
  echo "/var/adm/inetd.sec is being used" >> $Results
  echo "But may be lacking on entries" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "/var/adm/inetd.sec is NOT being used" >> $Results
 if cat /etc/inetd.conf | tr '\011''' | tr -s ''| sed -e 's/^[ \t]*//' | egrep -v "^#|^$" | grep -v "tcpd" >> $Results; then
  echo "Basic TCP Wrappers is NOT being used"
  echo "FAIL" >> $Results
 else
  echo "Basic TCP Wrappers is being used"
  echo "Pass" >> $Results
 fi
fi