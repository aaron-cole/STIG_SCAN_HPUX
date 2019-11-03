#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The Internet service daemon configuration files must be protected as malicious modification could cause denial of service or increase the attack surface of the system.

#STIG Identification
GrpID="V-22426"
GrpTitle="GEN003755"
RuleID="SV-29790r1_rule"
STIGID="GEN003755"
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

if [ -e /etc/xinetd.conf ]; then
 if grep -v "^#" /etc/xinetd.conf | grep -i "includedir" >> $Results; then
  filedir="$(grep -v "^#" $file | grep -i "includedir" | cut -f 2 -d " ")"
  if [ -e "$filedir" ]; then
   if ls -lLd $filedir | grep '^[a-zA-Z\-]\{10\}+' >> $Results; then
    echo "$filedir has an ACL" >> $Results
	echo "Fail" >> $Results
   else
    echo "$filedir DOES NOT have an ACL" >> $Results
    echo "Pass" >> $Results
   fi
  else
   echo "xinetd.conf includedir of $filedir does not exist" >> $Results
   echo "NA" >> $Results
  fi
 else
  echo "No includedir stanza found in /etc/xinetd.conf" >> $Results
  echo "NA" >> $Results
 fi  
else
 echo "/etc/xinetd.conf does not exist on the system" >> $Results
 echo "NA" >> $Results
fi 