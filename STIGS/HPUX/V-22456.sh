#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#SSHv1 is not a DoD-approved protocol and has many well-known vulnerability exploits. Exploits of the SSH client could provide access to the system with the privileges of the user running the client.

#STIG Identification
GrpID="V-22456"
GrpTitle="GEN005501"
RuleID="SV-35212r1_rule"
STIGID="GEN005501"
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

if [ -f /opt/ssh/etc/ssh_config ] && [ "$(grep "Protocol " /opt/ssh/etc/ssh_config | grep -v "^#" | wc -l)" -eq 1 ]; then
awk -v opf="$Results" '/Protocol / {
	if($2 == 2) {
	 print $0 >> opf
	 print "Pass" >> opf
	} else {
	 print $0 >> opf
	 print "Fail" >> opf
	}
}' /opt/ssh/etc/ssh_config 
else
 echo "Setting not defined or more than 1 configuration defined" >> $Results
 echo "Fail" >> $Results
fi