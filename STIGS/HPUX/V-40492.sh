#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Password aging attributes are stored in /etc/default/security and /etc/shadow. Anytime a password aging policy is changed, policy requirements are updated in /etc/default/security. If the system is allowed to override or ignore updates made to /etc/default/security, deprecated password aging policies will remain intact and never enforce newer requirements.

#STIG Identification
GrpID="V-40492"
GrpTitle="GEN000000-HPUX0450"
RuleID="SV-52481r1_rule"
STIGID="GEN000000-HPUX0450"
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
###########################

#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 echo "Not Applicable for Trusted Mode Systems"  >> $Results
 echo "NA" >> $Results
else
#For SMSE
 if [ "$(grep "OVERRIDE_SYSDEF_PWAGE" /etc/default/security)" != "0" ]; then
  echo "Fail" >> $Results
 else
  echo "Pass" >> $Results
 fi
fi