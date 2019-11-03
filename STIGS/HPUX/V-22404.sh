#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Kernel core dumps may contain the full contents of system memory at the time of the crash. Kernel core dumps may consume a considerable amount of disk space and may result in Denial of Service by exhausting the available space on the target file system. The kernel core dump process may increase the amount of time a system is unavailable due to a crash. Kernel core dumps can be useful for kernel debugging.

#STIG Identification
GrpID="V-22404"
GrpTitle="GEN003510"
RuleID="SV-26607r1_rule"
STIGID="GEN003510"
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

crashconf -v >> $Results

if [ "$(crashconf -v | tr '' ' ' | tr -s ' ' | sed -e 's/^[ ]*//'  | cut -f 3,3 -d " " | egrep -c -i "yes,")" -gt 0 ]; then
 echo "Fail" >> $Results
else
 echo "Pass" >> $Results
fi 