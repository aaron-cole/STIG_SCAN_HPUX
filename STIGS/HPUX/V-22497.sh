#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Excessive permissions could endanger the security of the Samba configuration file and, ultimately, the system and network.

#STIG Identification
GrpID="V-22497"
GrpTitle="GEN006150"
RuleID="SV-35223r1_rule"
STIGID="GEN006150"
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
file="$(find /etc /opt /usr /var -type f -name smb.conf 2>/dev/null)"

if [ -n "$file" ]; then
 if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
  echo "Fail" >> $Results
 else
  echo "Pass"  >> $Results
 fi
else
 echo "File does not exist" >> $Results
 echo "Pass" >> $Results
fi