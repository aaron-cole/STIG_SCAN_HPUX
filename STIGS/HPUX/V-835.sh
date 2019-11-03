#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If Sendmail is not configured to log at level 9, system logs may not contain the information necessary for tracking unauthorized use of the sendmail service.

#STIG Identification
GrpID="V-835"
GrpTitle="GEN004440"
RuleID="SV-35047r1_rule"
STIGID="GEN004440"
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

if [ -f /etc/mail/sendmail.cf ] && [ "$(grep "^O LogLevel=" /etc/mail/sendmail.cf | wc -l)" -eq 1 ]; then
 awk -v opf="$Results" -F= '/^O LogLevel=/ {
	if($2 >= 9) {
	 print $0 >> opf
	 print "Pass" >> opf
	} else {
	 print $0 >> opf
	 print "Fail" >> opf
	}
}' /etc/mail/sendmail.cf
else
 echo "Setting not defined or more than 1 configuration" >> $Results
 echo "Fail" >> $Results
fi