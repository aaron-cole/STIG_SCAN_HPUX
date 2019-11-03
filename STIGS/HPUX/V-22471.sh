#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If a public host key file is modified by an unauthorized user, the SSH service may be compromised.

#STIG Identification
GrpID="V-22471"
GrpTitle="GEN005522"
RuleID="SV-35060r1_rule"
STIGID="GEN005522"
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
files="/opt/ssh/etc/ssh_host_dsa_key.pub /opt/ssh/etc/ssh_host_rsa_key.pub"
scorecheck=0

for file in $files; do
 if [ -e $file ]; then
  filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
  checkmode="644"
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