#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Configuring a supplemental group for users permitted to switch to the root user prevents unauthorized users from accessing the root account, even with knowledge of the root credentials.

#STIG Identification
GrpID="V-22308"
GrpTitle="GEN000850"
RuleID="SV-26349r1_rule"
STIGID="GEN000850"
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
if [ -f /etc/default/security ] && [ "$(grep "^SU_ROOT_GROUP=" /etc/default/security | wc -l)" -eq 1 ]; then
 awk -v opf="$Results" -F= '/^SU_ROOT_GROUP=/ {
	if($2 != "") {
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