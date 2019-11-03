#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Excessive permissions on the NFS share configuration file could allow unauthorized modification of the file, which could result in Denial-of-Service to authorized NFS shares and the creation of additional unauthorized shares.

#STIG Identification
GrpID="V-929"
GrpTitle="GEN005760"
RuleID="SV-35184r1_rule"
STIGID="GEN005760"
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
file="/etc/dfs/dfstab"

if [ -e $file ]; then
 filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
 checkmode="644"
 if [ $filemode -le $checkmode ]; then
  echo "$file is $filemode and less than or equal to $checkmode" >> $Results
  echo "Pass" >> $Results
 else
  echo "$file is $filemode and not less than or equal to $checkmode" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "$file does not exist" >> $Results
 echo "Pass" >> $Results
fi