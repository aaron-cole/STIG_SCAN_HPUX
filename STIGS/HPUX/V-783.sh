#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Timely patching is critical for maintaining the operational availability, confidentiality, and integrity of Information Technology (IT) systems. However, failure to keep operating system and application software patched is a common mistake made by IT professionals. New patches are released daily, and it is often difficult for even experienced system administrators to keep abreast of all the new patches. When new weaknesses in an operating system exist, patches are usually made available by the vendor to resolve the problems. If the most recent security patches and updates are not installed, unauthorized users may take advantage of weaknesses present in the unpatched software. The lack of prompt attention to patching could result in a system compromise.

#STIG Identification
GrpID="V-783"
GrpTitle="GEN000120"
RuleID="SV-38456r2_rule"
STIGID="GEN000120"
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

echo "Manual Review Necessary" >> $Results
echo "Are there any available security patches for the system?" >> $Results
echo "Fail" >> $Results