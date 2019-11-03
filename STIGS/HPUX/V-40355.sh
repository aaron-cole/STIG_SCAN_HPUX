#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Disabling accounts after a limited number of unsuccessful SSH login attempts improves protection against password guessing attacks.

#STIG Identification
GrpID="V-40355"
GrpTitle="GEN000000-HPUX0210"
RuleID="SV-52335r1_rule"
STIGID="GEN000000-HPUX0210"
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

#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 echo "Not Applicable for Trusted Mode Systems"  >> $Results
 echo "NA" >> $Results
else
#For SMSE
 if [ -f /opt/ssh/etc/sshd_config ] && [ "$(grep "^UsePAM " /opt/ssh/etc/sshd_config | wc -l)" -eq 1 ]; then
 awk -v opf="$Results" '/^UsePAM / {
	if($2 == "yes" || $2 == "Yes") {
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
fi