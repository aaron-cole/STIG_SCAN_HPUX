#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If SSH permits rhosts RSA authentication, a user may be able to login based on the keys of the host originating the request and not any user-specific authentication..

#STIG Identification
GrpID="V-22487"
GrpTitle="GEN005538"
RuleID="SV-35142r1_rule"
STIGID="GEN005538"
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

#Check for Protocol 2 for NA
if [ -f /opt/ssh/etc/sshd_config ] && [ "$(grep "^Protocol " /opt/ssh/etc/sshd_config | wc -l)" -eq 1 ]; then
awk -v opf="$Results" '/^Protocol / {
	if($2 == 2) {
	 print $0 >> opf
	 print "Protocol 2 is only enabled - check is NA" >> opf
	 print "NA" >> opf
	} else {
	 print $0 >> opf
	 print "Fail" >> opf
	}
}' /opt/ssh/etc/sshd_config 
elif [ -f /opt/ssh/etc/sshd_config ] && [ "$(grep "^RhostsRSAAuthentication " /opt/ssh/etc/sshd_config | wc -l)" -eq 1 ]; then
awk -v opf="$Results" '/^RhostsRSAAuthentication / {
	if($2 == "no" || $2 == "No") {
	 print $0 >> opf
	 print "Pass" >> opf
	} else {
	 print $0 >> opf
	 print "Fail" >> opf
	}
}' /opt/ssh/etc/sshd_config 
else
 echo "Setting not defined or more than 1 configuration defined" >> $Results
 echo "Fail" >> $Results
fi