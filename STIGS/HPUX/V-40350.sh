#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The user database stores per-user information. It consists of the /var/adm/userdb directory and the files within it. A per-user value in /var/adm/userdb will override any corresponding system-wide default configured in the /etc/default/security file. Allowing per-user files to relax system-wide security settings creates potential security gaps that can compromise overall system security.

#STIG Identification
GrpID="V-40350"
GrpTitle="GEN000000-HPUX0200"
RuleID="SV-52330r1_rule"
STIGID="GEN000000-HPUX0200"
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
 /usr/sbin/userdbget -a >> $Results
 echo "Manual" >> $Results
fi