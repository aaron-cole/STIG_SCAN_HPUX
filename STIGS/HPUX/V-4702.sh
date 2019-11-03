#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Anonymous FTP is a public data service which is only permitted in a server capacity when located on the DMZ network.

#STIG Identification
GrpID="V-4702"
GrpTitle="GEN004840"
RuleID="SV-35101r1_rule"
STIGID="GEN004840"
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

if [ "$(grep -v "^#" /etc/inetd.conf | grep -c -i ^"ftp")" != 0 ]; then
 OUTPUT1="$(ftp -n -v localhost<<EOF
user anonymous guest
quit
EOF)"
 OUTPUT2="$(ftp -n -v localhost<<EOF
user anonymous guest@mail.com
quit
EOF)"
 if [ -z "$OUTPUT1" ] || [ -z "$OUTPUT2" ]; then
  echo "Manual check Required" >> $Results
  echo "Fail" >> $Results
 else
  if echo "$OUTPUT1" | grep -i "login failed" >> /dev/null; then
   echo "Username of anonymous and password of guest failed" >> $Results
   echo "$OUTPUT1" >> $Results
   if echo "$OUTPUT2" | grep -i "login failed" >> /dev/null; then
    echo "Username of anonymous and password of guest@mail.com failed" >> $Results
    echo "$OUTPUT2" >> $Results
	echo "Pass" >> $Results
   else
    echo "Username of anonymous and password of guest@mail.com WORKED" >> $Results
    echo "$OUTPUT2" >> $Results
	echo "Fail" >> $Results
   fi
  else
   echo "Username of anonymous and password of guest WORKED" >> $Results
   echo "$OUTPUT1" >> $Results
   echo "Fail" >> $Results
  fi
 fi
else
 echo "FTP service is not found or enabled" >> $Results 
 echo "NA" >> $Results
fi