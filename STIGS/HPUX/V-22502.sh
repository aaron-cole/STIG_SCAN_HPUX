#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#File system extended ACLs provide access to files beyond what is allowed by the mode numbers of the files. Excessive permissions on the hosts.nntp file may allow unauthorized modification which could lead to Denial of Service to authorized users or provide access to unauthorized users.

#STIG Identification
GrpID="V-22502"
GrpTitle="GEN006270"
RuleID="SV-35115r1_rule"
STIGID="GEN006270"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

###Check###
#File or Directory to check
#file="$(find /etc /opt /usr /var -type f -name hosts.nntp 2>/dev/null)"

if [ -f /etc/news/hosts.nntp ]; then
 if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
  echo "Fail" >> $Results
 else
  echo "Pass"  >> $Results
 fi
else
 echo "File does not exist" >> $Results
 echo "Pass" >> $Results
fi