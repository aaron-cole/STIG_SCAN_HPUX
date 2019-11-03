#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Unless the userdb is required, the /var/adm/userdb/USERDB.DISABLED file must be created to disable the use of per-user security attributes in the user database. Attributes in the user database override the system-wide settings configured in /etc/default/security. If the system-wide configuration is overridden maliciously, users may gain unauthorized system access. 

#STIG Identification
GrpID="V-40451"
GrpTitle="GEN000000-HPUX0280"
RuleID="SV-52438r1_rule"
STIGID="GEN000000-HPUX0280"
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
#File or Directory to check
file="/var/adm/userdb/USERDB.DISABLED"

#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 echo "Not Applicable for Trusted Mode Systems"  >> $Results
 echo "NA" >> $Results
else
#For SMSE
 if [ -e $file ]; then
  OwnerID="$(perl -le'print((stat shift)[4])' $file)"
  echo "UID for $file is $OwnerID" >> $Results
  case "$OwnerID" in
	0|root) echo "Pass" >> $Results;;
	*) echo "Fail" >> $Results;;
  esac
 else
  echo "$file does not exist" >> $Results
  echo "Fail" >> $Results
 fi
fi