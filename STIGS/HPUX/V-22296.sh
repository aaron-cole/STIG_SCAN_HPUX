#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#A synchronized system clock is critical for the enforcement of time-based policies and the correlation of logs and audit records with other systems.  If an illicit time source is used for synchronization, the integrity of system logs and the security of the system could be compromised.  If the configuration files controlling time synchronization are not protected, unauthorized modifications could result in the failure of time synchronization.

#STIG Identification
GrpID="V-22296"
GrpTitle="GEN000252"
RuleID="SV-38274r1_rule"
STIGID="GEN000252"
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
file="/etc/ntp.conf"

if [ -e $file ]; then
 filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
 checkmode="640"
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