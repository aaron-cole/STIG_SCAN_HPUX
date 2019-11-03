#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#A system's BIOS or system controller handles the initial startup of a system and its configuration must be protected from unauthorized modification. When the BIOS or system controller supports the creation of user accounts or passwords, such protections must be used and accounts/passwords only assigned to system administrators. Failure to protect BIOS or system controller settings could result in Denial of Service or compromise of the system resulting from unauthorized configuration changes.

#STIG Identification
GrpID="V-4246"
GrpTitle="GEN008620"
RuleID="SV-38423r1_rule"
STIGID="GEN008620"
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

echo "HPUX does not have BIOSs, they have firmware" >> $Results
echo "Pass" >> $Results