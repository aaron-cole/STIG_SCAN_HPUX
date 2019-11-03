#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Best practices standard operating procedures for computing systems includes account management. If the root account is allowed to be configured without a password, or not configured to lock if there have been no logins to the root account for an organization defined time interval, the entire system can be compromised.

#STIG Identification
GrpID="V-40445"
GrpTitle="GEN000000-HPUX0220"
RuleID="SV-52432r2_rule"
STIGID="GEN000000-HPUX0220"
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
 echo "Not Applicable for Trusted Mode Systems"  >> $Results
 echo "NA" >> $Results
else
#For SMSE
 if [ -f /etc/default/security ] && [ "$(grep "^LOGIN_POLICY_STRICT=" /etc/default/security | wc -l)" -eq 1 ]; then
 awk -v opf="$Results" -F= '/^LOGIN_POLICY_STRICT=/ {
	if($2 == 1) {
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