#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The /etc/security.dsc file is the system description file that contains all attributes and default values that are configurable on a per user basis in /var/adm/userdb. If the description file is modified maliciously, users may gain unauthorized system access. 	

#STIG Identification
GrpID="V-40467"
GrpTitle="GEN000000-HPUX0330"
RuleID="SV-52455r1_rule"
STIGID="GEN000000-HPUX0330"
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
file="/etc/security.dsc"

#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 echo "Not Applicable for Trusted Mode Systems"  >> $Results
 echo "NA" >> $Results
else
#For SMSE
 if [ -e $file ]; then
  GOwnerID="$(perl -le'print((stat shift)[5])' $file)"
  echo "GID for $file is $GOwnerID" >> $Results
  case "$GOwnerID" in
	3|sys) echo "Pass"  >> $Results;;
	*) echo "Fail" >> $Results;;
  esac
 else
  echo "$file does not exist" >> $Results
  echo "Fail" >> $Results
 fi
fi