#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-22573"
GrpTitle="GEN008340"
RuleID="SV-38396r1_rule"
STIGID="GEN008340"
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
file="/etc/opt/ldapux/key3.db"

if grep -v "^#" /etc/nsswitch.conf | grep ldap >> $Results; then
 if [ -e $file ]; then
  filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
  checkmode="600"
  if [ $filemode -le $checkmode ]; then
   echo "$file is $filemode and less than or equal to $checkmode" >> $Results
   echo "Pass" >> $Results
  else
   echo "$file is $filemode and not less than or equal to $checkmode" >> $Results
   echo "Fail" >> $Results
  fi
 else
  echo "$file does not exist" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "System is not using LDAP"  >> $Results
 echo "NA" >> $Results
fi