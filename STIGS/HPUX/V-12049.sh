#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Network analysis tools allow for the capture of network traffic visible to the system.

#STIG Identification
GrpID="V-12049"
GrpTitle="GEN003865"
RuleID="SV-35138r2_rule"
STIGID="GEN003865"
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

checkfiles="$(find /etc /opt /usr /bin /sbin -type f \( -name "ethereal" -o -name "wireshark" -o -name "tshark" -o -name "netcat" -o -name "tcpdump" -o -name "snoop" -o -name "nettl" \) 2>>/dev/null)"
checkfiles2="$(echo "$checkfiles" | sed 's/^.*\/usr\/newconfig\/.*$//g' | sed 's/^.*\/etc\/rc.config.d\/.*$//g' | sed 's/^.*\/sbin\/init.d\/.*$//g')"

if [ -z "$checkfiles2" ]; then
 echo "No network analysis tools installed" >> $Results
 echo "Pass" >> $Results
else
 echo "Network analysis tools found" >> $Results
 for file in $checkfiles2; do
  ls -l $file >> $Results
 done
 echo "Fail" >> $Results
fi
 