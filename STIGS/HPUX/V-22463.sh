#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#DoD information systems are required to use FIPS 140-2 approved cryptographic hash functions.

#STIG Identification
GrpID="V-22463"
GrpTitle="GEN005512"
RuleID="SV-35210r3_rule"
STIGID="GEN005512"
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

if [ -f /opt/ssh/etc/ssh_config ] && [ "$(grep "MACs" /opt/ssh/etc/ssh_config | grep -v "^#" | wc -l)" -eq 1 ]; then
 awk -v opf="$Results" '/MACs / {
	if($2 == "hmac-sha1") {
	 print $0 >> opf
	 print "Pass" >> opf
	} else {
	 print $0 >> opf
	 print "Fail" >> opf
	}
}' /opt/ssh/etc/ssh_config
else
 echo "Setting not defined or more than 1 configuration" >> $Results
 echo "Fail" >> $Results
fi