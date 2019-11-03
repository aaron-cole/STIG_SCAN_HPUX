#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Providing users with feedback on when account accesses last occurred facilitates user recognition and reporting of unauthorized account use.

#STIG Identification
GrpID="V-40493"
GrpTitle="GEN000000-HPUX0460"
RuleID="SV-52482r3_rule"
STIGID="GEN000000-HPUX0460"
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
###########################
scorecheck=0

if [ -f /tcb/files/auth/system/default ]; then
#For Trusted Mode
 for f in /tcb/files/auth/[a-z.A-Z]/*; do 
  if egrep "u_succhg#[0-9]+:" $f >> $Results; then
   if egrep "u_unsucchg#[0-9]+:" $f >> $Results; then
    echo "" >> /dev/null
   fi
  else
   ((scorecheck+=1))
   echo "$f - Fail" >> $Results
  fi
 done
#For SMSE mode
else 
 grep "DISPLAY_LAST_LOGIN" /etc/default/security | grep -v "^#" >> $Results
 if [ "$(grep "DISPLAY_LAST_LOGIN" /etc/default/security | grep -v "^#" | cut -f 2 -d "=")" = "1" ]; then
  echo "Pass" >> $Results
 else
  echo "Fail" >> $Results
 fi
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi