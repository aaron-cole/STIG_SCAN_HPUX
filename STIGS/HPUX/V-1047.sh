#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Even though communications are encrypted, an additional layer of security may be gained by extending the policy of not logging directly on as root. In addition, logging in with a user-specific account preserves the audit trail.

#STIG Identification
GrpID="V-1047"
GrpTitle="GEN001120"
RuleID="SV-38207r1_rule"
STIGID="GEN001120"
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

if [ -f /opt/ssh/etc/sshd_config ] && [ "$(grep "^PermitRootLogin " /opt/ssh/etc/sshd_config | wc -l)" -eq 1 ]; then
awk -v opf="$Results" '/^PermitRootLogin / {
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