#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Vendor accounts and software may contain backdoors that will allow unauthorized access to the system.  These backdoors are common knowledge and present a threat to system security if the account is not disabled.

#STIG Identification
GrpID="V-810"
GrpTitle="GEN002640"
RuleID="SV-27264r2_rule"
STIGID="GEN002640"
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
OTHERSYSACCTS="cimsrvr sfmdb iwww owww hpsmh sshd ids smtp"
SYSACCTS="$(logins -s | awk '{print $1}')"
for SYSACCT in $SYSACCTS; do
 if [ "$SYSACCT" = "root" ]; then
  continue
 fi
 if grep "u_pwd=" /tcb/files/auth/[a-z,A-Z]/$SYSACCT | grep ":u_pwd=\*:" >> /dev/null; then
  echo "PASS - $SYSACCT - $(grep "u_pwd=" /tcb/files/auth/[a-z,A-Z]/$SYSACCT)" >> $Results
  continue
 else
  echo "FAIL - $SYSACCT - $(grep "u_pwd=" /tcb/files/auth/[a-z,A-Z]/$SYSACCT)" >> $Results
  ((scorecheck+=1))
 fi
done

#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 for OTHERSYSACCT in $OTHERSYSACCTS; do
  if grep "^$OTHERSYSACCT:" /etc/passwd >> /dev/null; then
   if grep "u_pwd=" /tcb/files/auth/[a-z,A-Z]/$OTHERSYSACCT | grep ":u_pwd=\*:" >> /dev/null; then
    echo "PASS - $OTHERSYSACCT - $(grep "u_pwd=" /tcb/files/auth/[a-z,A-Z]/$OTHERSYSACCT)" >> $Results
    continue
   else
    echo "FAIL - $OTHERSYSACCT - $(grep "u_pwd=" /tcb/files/auth/[a-z,A-Z]/$OTHERSYSACCT)" >> $Results
    ((scorecheck+=1))
   fi
  else
   echo "PASS - $OTHERSYSACCT does not exist on the system" >> $Results
  fi
 done
else
#For SMSE
 for OTHERSYSACCT in $OTHERSYSACCTS; do
  if grep "^$OTHERSYSACCT:" /etc/shadow >> /dev/null; then
   if grep "^$OTHERSYSACCT:" /etc/shadow | cut -f 2 -d ":" | egrep "\*|\!\!|\!" >> $Results; then
    continue
   else
    echo "FAIL - $OTHERSYSACCT - $(grep "^$OTHERSYSACCT:" /etc/shadow | cut -f 1,2 -d ":")" >> $Results
    ((scorecheck+=1))
   fi
  else
   echo "PASS - $OTHERSYSACCT does not exist on the system" >> $Results
  fi
 done
fi
 
if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi
 