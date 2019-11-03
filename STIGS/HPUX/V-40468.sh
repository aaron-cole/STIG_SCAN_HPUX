#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The /etc/security.dsc file is the system description file that contains all attributes and default values that are configurable on a per user basis in /var/adm/userdb. If the description file is modified maliciously, users may gain unauthorized system access. 

#STIG Identification
GrpID="V-40468"
GrpTitle="GEN000000-HPUX0340"
RuleID="SV-52456r1_rule"
STIGID="GEN000000-HPUX0340"
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
file="/etc/security.dsc"

#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 echo "Not Applicable for Trusted Mode Systems"  >> $Results
 echo "NA" >> $Results
else
 filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
 checkmode="444"
 echo "$file mode is $checkmode" >> $Results
 if [ $filemode -le $checkmode ]; then
  echo "Pass" >> $Results
 else
  echo "Fail" >> $Results
 fi
fi