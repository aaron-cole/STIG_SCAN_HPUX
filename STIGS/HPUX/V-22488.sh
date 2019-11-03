#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If compression is allowed in an SSH connection prior to authentication, vulnerabilities in the compression software could result in compromise of the system from an unauthenticated connection, potentially with root privileges.

#STIG Identification
GrpID="V-22488"
GrpTitle="GEN005539"
RuleID="SV-35146r1_rule"
STIGID="GEN005539"
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

if [ -f /opt/ssh/etc/sshd_config ] && [ "$(grep "^Compression " /opt/ssh/etc/sshd_config | wc -l)" -eq 1 ]; then
awk -v opf="$Results" '/^Compression / {
	if($2 == "yes" || $2 == "Yes") {
	 print $0 >> opf
	 print "Fail" >> opf
	} else {
	 print $0 >> opf
	 print "Pass" >> opf
	}
}' /opt/ssh/etc/sshd_config 
else
 echo "Setting not defined or more than 1 configuration defined" >> $Results
 echo "Fail" >> $Results
fi