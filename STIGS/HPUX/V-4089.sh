#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#System start-up files not owned by root could lead to system compromise by allowing malicious users or applications to modify them for unauthorized purposes.  This could lead to system and network compromise.

#STIG Identification
GrpID="V-4089"
GrpTitle="GEN001660"
RuleID="SV-38420r1_rule"
STIGID="GEN001660"
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
#File or Directory to check
files="/sbin/init.d/* /sbin/rc*.d/* /etc/rc.config.d/*"
scorecheck=0

for file in $files; do
 if [ -e $file ]; then
  OwnerID="$(perl -le'print((stat shift)[4])' $file)"
  case "$OwnerID" in
	0|2|root|bin) echo "PASS - UID for $file is $OwnerID" >> $Results;;
	*) echo "FAIL - UID for $file is $OwnerID" >> $Results
	   ((scorecheck+=1));;
  esac
 else
  echo "$file does not exist" >> $Results
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi