#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#DoD information systems are required to use FIPS 140-2 approved cryptographic hash functions.

#STIG Identification
GrpID="V-22460"
GrpTitle="GEN005507"
RuleID="SV-35220r2_rule"
STIGID="GEN005507"
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

if [ -f /opt/ssh/etc/sshd_config ] && [ "$(grep "^MACS" /opt/ssh/etc/sshd_config | wc -l)" -eq 1 ]; then
 awk -v opf="$Results" '/^MACS/ {
	if($2 == "hmac-sha1") {
	 print $0 >> opf
	 print "Pass" >> opf
	} else {
	 print $0 >> opf
	 print "Fail" >> opf
	}
}' /opt/ssh/etc/sshd_config
else
 echo "Setting not defined or more than 1 configuration" >> $Results
 echo "Fail" >> $Results
fi