#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Permissions greater than 0700 could allow unauthorized users access to the root home directory.

#STIG Identification
GrpID="V-775"
GrpTitle="GEN000920"
RuleID="SV-38450r1_rule"
STIGID="GEN000920"
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
#File to check
file="$(grep ^root /etc/passwd | cut -f 6 -d ":")"
filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
checkmode="700"

#Check
if [ $filemode -le $checkmode ]; then
 echo "Perl stat for $file is $filemode and less than or equal to $checkmode" >> $Results
 echo "Pass" >> $Results
else
 echo "Perl stat for $file is $filemode and not less than or equal to $checkmode" >> $Results
 echo "Fail" >> $Results
fi