#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The /var/adm/userdb directory is the system user database repository used for storing per-user security configuration information. If the configuration is modified maliciously, individual users may gain unauthorized system access. 

#STIG Identification
GrpID="V-40447"
GrpTitle="GEN000000-HPUX0240"
RuleID="SV-52434r1_rule"
STIGID="GEN000000-HPUX0240"
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
file="/var/adm/userdb"

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