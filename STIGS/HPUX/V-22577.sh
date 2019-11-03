#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Automated file system mounting tools may provide unprivileged users with the ability to access local media and network shares.  If this access is not necessary for the system’s operation, it must be disabled to reduce the risk of unauthorized access to these resources.

#STIG Identification
GrpID="V-22577"
GrpTitle="GEN008440"
RuleID="SV-38377r1_rule"
STIGID="GEN008440"
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

if [ -f /etc/rc.config.d/nfsconf ] && [ "$(grep "^AUTOFS=" /etc/rc.config.d/nfsconf | wc -l)" -eq 1 ]; then
 awk -v opf="$Results" -F= '/^AUTOFS=/ {
	if($2 == "0") {
	 print $0 >> opf
	 print "Pass" >> opf
	} else {
	 print $0 >> opf
	 print "Fail" >> opf
	}
}' /etc/rc.config.d/nfsconf
else
 echo "Setting not defined or more than 1 configuration" >> $Results
 echo "Fail" >> $Results
fi
