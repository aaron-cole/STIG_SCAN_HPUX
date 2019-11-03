#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Extended ACLs may provide excessive permissions on the  /etc/news/passwd.nntp file, which may permit unauthorized  access or modification to the NNTP configuration.

#STIG Identification
GrpID="V-22505"
GrpTitle="GEN006330"
RuleID="SV-35121r1_rule"
STIGID="GEN006330"
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
#file="$(find /etc /opt /usr /var -type f -name passwd.nntp 2>/dev/null)"

if [ -f /etc/news/passwd.nntp ]; then
 if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
  echo "Fail" >> $Results
 else
  echo "Pass"  >> $Results
 fi
else
 echo "File does not exist" >> $Results
 echo "Pass" >> $Results
fi