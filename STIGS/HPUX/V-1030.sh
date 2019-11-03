#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Samba increases the attack surface of the system and must be restricted to communicate only with systems requiring access.

#STIG Identification
GrpID="V-1030"
GrpTitle="GEN006220"
RuleID="SV-35107r1_rule"
STIGID="GEN006220"
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

if swlist -l bundle | egrep -i "cifs-server|cifs-client" >> $Results; then 
 if [ -e /etc/opt/samba/smb.conf ]; then
  cat /etc/opt/samba/smb.conf | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -v "^#" | egrep "^hosts|^ hosts allow|^hosts deny" >> $Results
  echo "Examine for restricted access" >> $Results
  echo "Fail" >> $Results
 else
  echo "File does not exist" >> $Results
  echo "Pass" >> $Results
 fi
else
 echo "Samaba is not installed" >> $Results
 echo "Pass" >> $Results
fi