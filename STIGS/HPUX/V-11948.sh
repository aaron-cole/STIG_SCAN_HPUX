#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#To enforce the use of complex passwords, minimum numbers of characters of different classes are mandated. The use of complex passwords reduces the ability of attackers to successfully obtain valid passwords using guessing or exhaustive search techniques. Complexity requirements increase the password search space by requiring users to construct passwords from a larger character set than they may otherwise use.

#STIG Identification
GrpID="V-11948"
GrpTitle="GEN000600"
RuleID="SV-38244r2_rule"
STIGID="GEN000600"
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
if [ -f /etc/default/security ] && [ "$(grep "^PASSWORD_MIN_UPPER_CASE_CHARS=" /etc/default/security | wc -l)" -eq 1 ]; then
 awk -v opf="$Results" -F= '/^PASSWORD_MIN_UPPER_CASE_CHARS=/ {
	if($2 >= 1) {
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