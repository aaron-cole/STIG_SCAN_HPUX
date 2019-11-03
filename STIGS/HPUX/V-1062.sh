#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#To ensure the root shell is available in repair and administrative modes, the root shell must be located in the / file system.

#STIG Identification
GrpID="V-1062"
GrpTitle="GEN001080"
RuleID="SV-38208r1_rule"
STIGID="GEN001080"
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

ROOTSHELL="$(grep "^root" /etc/passwd | cut -f 7 -d ":")"
delimitercount="$(echo "$ROOTSHELL" | tr "/" "\n" | grep -v "^$" | wc -l)"
SHELLDIR="$(echo "$ROOTSHELL" | cut -f "1-$delimitercount" -d "/")"

grep "^root" /etc/passwd | cut -f 1,7 -d ":" >> $Results

if grep "$SHELLDIR " /etc/fstab >> $Results; then
 echo "root's SHELL appears to be located on a mountable file system in /etc/fstab" >> $Results
 echo "Fail" >> $Results
else
 echo "root's SHELL is not located on a mountable file system in /etc/fstab" >> $Results
 echo "Pass" >> $Results
fi 
