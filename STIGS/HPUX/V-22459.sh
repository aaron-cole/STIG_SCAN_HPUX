#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The CBC mode of encryption as implemented in the SSHv2 protocol is vulnerable to chosen plaintext attacks and must not be used.

#STIG Identification
GrpID="V-22459"
GrpTitle="GEN005506"
RuleID="SV-35218r1_rule"
STIGID="GEN005506"
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

if [ -f /opt/ssh/etc/sshd_config ] && [ "$(grep "^Ciphers " /opt/ssh/etc/sshd_config | wc -l)" -eq 1 ]; then
 awk -v opf="$Results" '/^Ciphers / {
	if($2 == "aes128-ctr,aes192-ctr,aes256-ctr" || $2 == "aes256-ctr,aes192-ctr,aes128-ctr" ) {
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