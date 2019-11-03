#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The services file is critical to the proper operation of network services and must be protected from unauthorized modification.  If the services file has an extended ACL, it may be possible for unauthorized users to modify the file.  Unauthorized modification could result in the failure of network services.

#STIG Identification
GrpID="V-22428"
GrpTitle="GEN003790"
RuleID="SV-38366r1_rule"
STIGID="GEN003790"
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
file="/etc/services"
ls -lLd $file >> $Results

if [ -e $file ]; then
 if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
  echo "Fail" >> $Results
 else
  echo "Pass"  >> $Results
 fi
else
 echo "File does not exist" >> $Results
 echo "Pass" >> $Results
fi