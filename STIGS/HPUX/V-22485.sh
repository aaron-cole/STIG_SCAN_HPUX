#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If other users have access to modify user-specific SSH configuration files, they may be able to log into the system as another user.

#STIG Identification
GrpID="V-22485"
GrpTitle="GEN005536"
RuleID="SV-35137r1_rule"
STIGID="GEN005536"
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

if [ -f /opt/ssh/etc/sshd_config ] && [ "$(grep "^StrictModes " /opt/ssh/etc/sshd_config | wc -l)" -eq 1 ]; then
awk -v opf="$Results" '/^StrictModes / {
	if($2 == "no" || $2 == "No") {
	 print $0 >> opf
	 print "Fail" >> opf
	} else {
	 print $0 >> opf
	 print "Pass" >> opf
	}
}' /opt/ssh/etc/sshd_config 
elif [ "$(grep "^StrictModes " /opt/ssh/etc/sshd_config | wc -l)" -eq 0 ]; then
 echo "Setting not defined" >> $Results
 echo "Pass" >> $Results
else
 echo "Setting not defined or more than 1 configuration defined" >> $Results
 echo "Fail" >> $Results
fi