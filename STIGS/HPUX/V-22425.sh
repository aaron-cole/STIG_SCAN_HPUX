#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The Internet service daemon configuration files must be protected as malicious modification could cause Denial of Service or increase the attack surface of the system.

#STIG Identification
GrpID="V-22425"
GrpTitle="GEN003750"
RuleID="SV-35074r1_rule"
STIGID="GEN003750"
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
scorecheck=0
checkmode="755"

if [ -e /etc/xinetd.conf ]; then
 if grep -v "^#" /etc/xinetd.conf | grep -i "includedir" >> $Results; then
  filedir="$(grep -v "^#" $file | grep -i "includedir" | cut -f 2 -d " ")"
  if [ -e "$filedir" ]; then
   filedirmode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $filedir)"
   if [ $filedirmode -le $checkmode ]; then
    echo "$filedir is $filedirmode and less than or equal to $checkmode" >> $Results
   else
    echo "$filedir is $filedirmode and not less than or equal to $checkmode" >> $Results
    ((scorecheck+=1))
   fi
  else
   echo "xinetd.conf includedir of $filedir does not exist" >> $Results
  fi
 else
  echo "No includedir stanza found in /etc/xinetd.conf" >> $Results
 fi  
else
 echo "/etc/xinetd.conf does not exist on the system" >> $Results
fi 
  
if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi