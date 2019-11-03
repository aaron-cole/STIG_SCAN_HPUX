#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Restricting SSH logins to a limited group of users, such as system administrators, prevents password guessing and other SSH attacks from reaching system accounts and other accounts not authorized for SSH access.

#STIG Identification
GrpID="V-22470"
GrpTitle="GEN005521"
RuleID="SV-35052r1_rule"
STIGID="GEN005521"
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

if egrep "DenyUsers|AllowUsers|DenyGroups|AllowGroups" /opt/ssh/etc/sshd_config | grep -v "#" >> $Results; then
 echo "Restriction to ssh found" >> $Results
 echo "Pass" >> $Results 
else
 echo "Restriction to ssh not found" >> $Results
 echo "Fail" >> $Results
fi