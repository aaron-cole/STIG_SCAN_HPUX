#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If a user, or root, used the same password continuously or was allowed to change it back shortly after being forced to change it, this would provide a potential intruder with the opportunity to keep guessing at one user's password until it was guessed correctly.

#STIG Identification
GrpID="V-4084"
GrpTitle="GEN000800"
RuleID="SV-38417r2_rule"
STIGID="GEN000800"
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
if [ -f /etc/default/security ] && [ "$(grep "^PASSWORD_HISTORY_DEPTH=" /etc/default/security | wc -l)" -eq 1 ]; then
 awk -v opf="$Results" -F= '/^PASSWORD_HISTORY_DEPTH=/ {
	if($2 >= 5) {
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