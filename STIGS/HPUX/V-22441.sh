#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Excessive permissions on files executed through a mail alias file could result in modification by an unauthorized user, execution of malicious code, and/or system compromise.

#STIG Identification
GrpID="V-22441"
GrpTitle="GEN004430"
RuleID="SV-38369r1_rule"
STIGID="GEN004430"
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

if [ -e /etc/mail/aliases ]; then
 if grep -v "^#" /etc/mail/aliases | cut -f 2 -d ":" | grep "|" >> $Results; then
  CMDLIST="$(grep -v "^#" /etc/mail/aliases | cut -f 2 -d ":" | grep "|" | cut -f 2 -d "|")"
  for CMD in $CMDLIST; do
   if [ -e "$CMD" ]; then
    if ls -lLd $CMD | grep '^[a-zA-Z\-]\{10\}+' >> $Results; then
     echo "FAIL - $CMD has an ACL" >> $Results
	 ((scorecheck+=1))
    else
     echo "PASS - $CMD DOES NOT have an ACL" >> $Results
    fi
   else
    echo "$CMD does not exist" >> $Results
   fi
  done
 else
  echo "No files executed from /etc/mail/aliases" >> $Results
 fi
else
 echo "/etc/mail/aliases does not exist"
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi