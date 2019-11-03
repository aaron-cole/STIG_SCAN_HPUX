#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Secure mode limits TFTP requests to a specific directory.  If TFTP is not running in secure mode, it may be able to write to any file or directory and may seriously impair system integrity, confidentiality, and availability.

#STIG Identification
GrpID="V-847"
GrpTitle="GEN005080"
RuleID="SV-35110r1_rule"
STIGID="GEN005080"
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

grep -v "^#" /etc/inetd.conf | grep -i "^tftp" >> $Results

if [ "$(grep -v "^#" /etc/inetd.conf | grep -c -i tftp)" != 0 ]; then
 check="$(grep -v "^#" /etc/inetd.conf | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -v "^#" | cut -f 6,7 -d " " | grep "tftp")"
 if [ -z "$(echo $check | cut -f 1 -d " ")" ] && [ -z "$(echo $check | cut -f 2 -d " ")" ] ; then 
  echo "No Path Argument Found" >> $Results
  echo "Fail" >> $Results
 else
  echo "Path Argument Found" >> $Results
  echo "Pass" >> $Results 
 fi
else
 echo "tftp service is not found" >> $Results 
 echo "Pass" >> $Results
fi