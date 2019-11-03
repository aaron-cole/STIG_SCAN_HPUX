#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If a file executed through a mail aliases file is not group-owned by root or a system group, it may be subject to unauthorized modification.  Unauthorized modification of files executed through aliases may allow unauthorized users to attain root privileges.

#STIG Identification
GrpID="V-22440"
GrpTitle="GEN004410"
RuleID="SV-38373r1_rule"
STIGID="GEN004410"
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
    GOwnerID="$(perl -le'print((stat shift)[5])' $CMD)"
    echo "GID for $CMD is $GOwnerID" >> $Results
    case "$GOwnerID" in
	 0|2|3|root|bin|sys) echo "PASS - $(ls -l $CMD)" >> $Results;;
	 *) echo "FAIL - $(ls -l $CMD)" >> $Results
	   ((scorecheck+=1));;
    esac
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