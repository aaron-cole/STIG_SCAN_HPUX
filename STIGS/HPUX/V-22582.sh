#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#A local firewall protects the system from exposing unnecessary or undocumented network services to the local enclave.  If a system within the enclave is compromised, firewall protection on an individual system continues to protect it from attack.

#STIG Identification
GrpID="V-22582"
GrpTitle="GEN008520"
RuleID="SV-38403r1_rule"
STIGID="GEN008520"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

#Check

if [ -f /etc/rc.config.d/ipfconf ] && [ "$(grep "^IPF_START" /etc/rc.config.d/ipfconf | wc -l)" -eq 1 ]; then
 awk -v opf="$Results" -F= '/^IPF_START=/ {
	if($2 == 1) {
	 print $0 >> opf
	 print "Pass" >> opf
	} else {
	 print $0 >> opf
	 print "Fail" >> opf
	}
}' /etc/rc.config.d/ipfconf
else
 echo "Setting not defined or more than 1 configuration" >> $Results
 echo "Fail" >> $Results
fi