#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The Internet service daemon configuration files must be protected as malicious modification could cause Denial of Service or increase the attack surface of the system.

#STIG Identification
GrpID="V-822"
GrpTitle="GEN003740"
RuleID="SV-35072r1_rule"
STIGID="GEN003740"
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
files="$(find / \( -path /var/adm/sw -o -path /usr/newconfig -o -path /usr/old/usr/newconfig \) -prune -o -type f \( -name inetd.conf -o -name xinetd.conf \) -print)"

if [ -z "$files" ]; then
 echo "inetd.conf and xinet.conf not found" >> $Results
 echo "Pass" >> $Results
else
 for file in $files; do
  checkmode="440"
  scorecheck=0
  filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
   if [ $filemode -le $checkmode ]; then
    echo "$file is $filemode and less than or equal to $checkmode" >> $Results
    echo "$file - Pass" >> $Results
   else
    echo "$file is $filemode and not less than or equal to $checkmode" >> $Results
    echo "$file - Fail" >> $Results
	((scorecheck+=1))
   fi
 done
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else
 echo "Pass" >> $Results
fi