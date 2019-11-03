#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#.Xauthority files ensure the user is authorized to access the specific X Windows host. Extended ACLs may permit unauthorized modification of these files, which could lead to Denial of Service to authorized access or allow unauthorized access to be obtained.

#STIG Identification
GrpID="V-22446"
GrpTitle="GEN005190"
RuleID="SV-35167r1_rule"
STIGID="GEN005190"
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
USERSDIRS="$(logins -u -o -x | cut -f 6 -d ":")"

for USERDIR in $USERDIRS; do
 if [ -f $USERDIR/.Xauthority ]; then
  if ls -lLd $USERDIR/.Xauthority | grep '^[a-zA-Z\-]\{10\}+' >> $Results; then
   ((scorecheck+=1))
  else
   echo "PASS - $USERDIR/.Xauthority DOES NOT have an ACL" >> $Results
  fi
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi
  