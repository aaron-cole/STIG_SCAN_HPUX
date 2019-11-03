#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Excessive permissions on the /etc/securetty file could result in unauthorized modification of the file.  Changes to the file could reduce the system's security by specifying additional terminals permitted to accept root logins, or deny service by preventing root logins on authorized terminals.

#STIG Identification
GrpID="V-967"
GrpTitle="GEN000000-HPUX0100"
RuleID="SV-967r2_rule"
STIGID="GEN000000-HPUX0100"
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
file="/etc/securetty"

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
 echo "Pass" >> $Results
fi