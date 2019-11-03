#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The use of longer passwords reduces the ability of attackers to successfully obtain valid passwords using guessing or exhaustive search techniques by increasing the password search space.

#STIG Identification
GrpID="V-11947"
GrpTitle="GEN000580"
RuleID="SV-27111r4_rule"
STIGID="GEN000580"
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
#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 if [ -f /etc/default/security ] && [ "$(grep "^MIN_PASSWORD_LENGTH=" /etc/default/security | wc -l)" -eq 1 ]; then
  awk -v opf="$Results" -F= '/^MIN_PASSWORD_LENGTH=/ {
	if($2 >= 15) {
	 print $0 >> opf
	 print "Pass" >> opf
	} else {
	 print $0 >> opf
	 print "Fail" >> opf
	}
}' /etc/default/security
 else
  echo "Setting not defined or more than 1 configuration" >> $Results
  echo "Fail" >> $Results
 fi
else
#For SMSE
 echo "Manual" >> $Results
fi