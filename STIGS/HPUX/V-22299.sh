#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-22299"
GrpTitle="GEN000452"
RuleID="SV-38302r1_rule"
STIGID="GEN000452"
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

if [ -f /opt/ssh/etc/sshd_config ] && [ "$(grep "^PrintLastLog " /opt/ssh/etc/sshd_config | wc -l)" -eq 1 ]; then
awk -v opf="$Results" '/^PrintLastLog / {
	if($2 == "no" || $2 == "No") {
	 print $0 >> opf
	 print "Fail" >> opf
	} else {
	 print $0 >> opf
	 print "Pass" >> opf
	}
}' /opt/ssh/etc/sshd_config 
elif [ "$(grep "^PrintLastLog " /opt/ssh/etc/sshd_config | wc -l)" -eq 0 ]; then
 echo "Setting not defined" >> $Results
 echo "Pass" >> $Results
else
 echo "Setting not defined or more than 1 configuration defined" >> $Results
 echo "Fail" >> $Results
fi