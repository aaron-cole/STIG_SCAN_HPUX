#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#SSH daemon privilege separation causes the SSH process to drop root privileges when not needed, which would decrease the impact of software vulnerabilities in the unprivileged section.

#STIG Identification
GrpID="V-22486"
GrpTitle="GEN005537"
RuleID="SV-35139r1_rule"
STIGID="GEN005537"
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

if [ -f /opt/ssh/etc/sshd_config ] && [ "$(grep "^UsePrivilegeSeparation " /opt/ssh/etc/sshd_config | wc -l)" -eq 1 ]; then
awk -v opf="$Results" '/^UsePrivilegeSeparation / {
	if($2 == "no" || $2 == "No") {
	 print $0 >> opf
	 print "Fail" >> opf
	} else {
	 print $0 >> opf
	 print "Pass" >> opf
	}
}' /opt/ssh/etc/sshd_config 
elif [ "$(grep "^UsePrivilegeSeparation " /opt/ssh/etc/sshd_config | wc -l)" -eq 0 ]; then
 echo "Setting not defined" >> $Results
 echo "Pass" >> $Results
else
 echo "Setting not defined or more than 1 configuration defined" >> $Results
 echo "Fail" >> $Results
fi