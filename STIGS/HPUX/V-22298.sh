#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-22298"
GrpTitle="GEN000450"
RuleID="SV-26319r2_rule"
STIGID="GEN000450"
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
 if [ -f /etc/default/security ] && [ "$(grep "^NUMBER_OF_LOGINS_ALLOWED=" /etc/default/security | wc -l)" -eq 1 ]; then
 awk -v opf="$Results" -F= '/^NUMBER_OF_LOGINS_ALLOWED=/ {
	if($2 <= 10) {
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
 if [ -f /etc/default/security ] && [ "$(grep "^NUMBER_OF_LOGINS_ALLOWED=" /etc/default/security | wc -l)" -eq 1 ]; then
 awk -v opf="$Results" -F= '/^NUMBER_OF_LOGINS_ALLOWED=/ {
	if($2 > 10) {
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
fi