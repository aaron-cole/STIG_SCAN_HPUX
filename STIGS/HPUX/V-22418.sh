#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Martian packets are packets containing addresses known by the system to be invalid. Logging these messages allows the SA to identify misconfigurations or attacks in progress.

#STIG Identification
GrpID="V-22418"
GrpTitle="GEN003611"
RuleID="SV-29772r1_rule"
STIGID="GEN003611"
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
IPADDR="$(grep "IP_ADDRESS\[0\]=" /etc/rc.config.d/netconf | grep -v "^#" | cut -f 2 -d "=" | cut -f 2 -d '"')"
IPFIROCT="$(echo "$IPADDR" | cut -f 1 -d ".")"
IPSECOCT="$(echo "$IPADDR" | cut -f 2 -d ".")"
IPTHIOCT="$(echo "$IPADDR" | cut -f 3 -d ".")"
IPLASTOCTECT="$(echo "$IPADDR" | cut -f 4 -d ".")"
subnetmask="$(grep "SUBNET_MASK\[0\]=" /etc/rc.config.d/netconf | grep -v "^#" | cut -f 2 -d "=" | cut -f 2 -d '"')"
SUBLASTOCTET="$(echo "$subnetmask" | cut -f 4 -d ".")"
FAIL=0

case "$SUBLASTOCTET" in
	0) bitsforsubnet=0 
	   if [ "$IPTHIOCT" -eq 255 ]; then
	    echo "" >> /dev/null
	   else
	    FAIL=0
	   fi ;;
	255) bitsforsubnet=0
		 BCASTLASTOCT=255 ;;
	128) bitsforsubnet=1 ;;
	192) bitsforsubnet=2 ;;
	224) bitsforsubnet=3 ;;
	240) bitsforsubnet=4 ;;
	248) bitsforsubnet=5 ;;
	252) bitsforsubnet=6 ;;
	254) bitsforsubnet=7 ;;
esac

hostbits="$(echo "8-$bitsforsubnet" | bc)"
numofsubnets="$(echo "2^$bitsforsubnet" | bc)"
lastbitofsubnet="$(echo "2^$hostbits" | bc)"
startnum=1

while [ "$startnum" -le "$numofsubnets" ] ; do
 case "$startnum" in
  1) BCASTLASTOCT="$(echo "$lastbitofsubnet-1" | bc)" ;;
  *) BCASTLASTOCT="$(echo "$BCASTLASTOCT+$lastbitofsubnet" | bc)" ;;
 esac
 
 if [ "$IPLASTOCTECT" -lt "$BCASTLASTOCT" ]; then
  startnum="$(echo "$numofsubnets+1" |bc)"
 else
  startnum="$(echo "$startnum+1" | bc)"
 fi  
done

if [ $FAIL -eq 1 ]; then
 echo "Unable to supernet with this script" >> $Results
 echo "Manual Review Necessary" >> $Results
 ((scorecheck+=1))
else
 BCASTADDR="$(echo "$IPFIROCT.$IPSECOCT.$IPTHIOCT.$BCASTLASTOCT")"
 ipfstat -i 2>>/dev/null | egrep "$IPADDR|$BCASTADDR" >> $Results
 if [ "$(ipfstat -i 2>>/dev/null | grep "block in " | grep "$IPADDR to any" | wc -l)" -ge 1 ] && [ "$(grep "^block in " /etc/opt/ipf/ipf.conf 2>>/dev/null | grep "$IPADDR to any" | wc -l)" -ge 1 ]; then
  echo "IPF is configured to block inbound IP Address Requests of $IPADDR" >> $Results
 else
  echo "IPF is NOT configured to block inbound IP Address Requests of $IPADDR" >> $Results
  ((scorecheck+=1))
 fi
 if [ "$(ipfstat -i 2>>/dev/null | grep "block in " | grep "$BCASTADDR to any" | wc -l)" -ge 1 ] && [ "$(grep "^block in " /etc/opt/ipf/ipf.conf 2>>/dev/null | grep "$BCASTADDR to any" | wc -l)" -ge 1 ]; then
  echo "IPF is configured to block inbound Broadcast Requests from $BCASTADDR" >> $Results
 else
  echo "IPF is NOT configured to block inbound Broadcast Requests from $BCASTADDR" >> $Results
  ((scorecheck+=1))
 fi
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi
