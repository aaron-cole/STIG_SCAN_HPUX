#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If manual pages are compromised, misleading information could be inserted, causing actions possibly compromising the system.

#STIG Identification
GrpID="V-792"
GrpTitle="GEN001280"
RuleID="SV-38463r2_rule"
STIGID="GEN001280"
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
checkfiles="$(find $(env | grep MANPATH | cut -f 2,2 -d "=" | tr ':' ' ' | sed 's/\%L//g') -type f \( -perm -100 -o -perm -030 -o -perm -003 \) \( -name "*.[1-8]" -o -name "*.[1-8]m" \) 2>>/dev/null)"

if [ -n "$checkfiles" ]; then
 echo "Man Pages are more permissive than 644" >> $Results
 echo "$checkfiles" >> $Results
 echo "Fail" >> $Results 
else
 echo "Man Pages are NOT more permissive than 644" >> $Results
 echo "Pass" >> $Results
fi