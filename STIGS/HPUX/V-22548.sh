#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#DHCP allows for the unauthenticated configuration of network parameters on the system by exchanging information with a DHCP server.

#STIG Identification
GrpID="V-22548"
GrpTitle="GEN007840"
RuleID="SV-26932r1_rule"
STIGID="GEN007840"
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

grep "^DHCP_ENABLE" /etc/rc.config.d/netconf >> $Results

for line in $(awk -F= '/^DHCP_ENABLE/ {print $2}' /etc/rc.config.d/netconf | cut -f 2 -d '"'); do
 if [ "$line" -eq 1 ]; then
  echo "DHCP is enabled" >> $Results
  ((scorecheck+=1))
 else
  echo "DHCP is not enabled" >> $Results
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi