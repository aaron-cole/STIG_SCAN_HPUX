#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#System device files in writable directories could be modified, removed, or used by an unprivileged user to control system hardware.

#STIG Identification
GrpID="V-924"
GrpTitle="GEN002280"
RuleID="SV-38505r2_rule"
STIGID="GEN002280"
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

chkfiles="$(find / -perm -002 \( -type b -o -type c -o -type p \) -a ! \( -path "/dev/pts*" -o -path "/dev/pty*" -o -path "/dev/full" -o -path "/dev/dlpi*" -o -path "/dev/tty[pqr]*" \
 -o -path "/dev/zero" -o -path "/dev/null" -o -path "/dev/tty*" -o -path "/dev/ptmx" -o -path "/dev/tcp" -o -path "/dev/udp" -o -path "/dev/ip" -o -path "/dev/arp" \
 -o -path "/dev/udp6" -o -path "/dev/tcp6" -o -path "/dev/rawip6" -o -path "/dev/ip6" -o -path "/dev/rawip" -o -path "/dev/rtsock" -o -path "/dev/ipsecpol" \
 -o -path "/dev/ipseckey" -o -path "/dev/sad" -o -path "/dev/sasd*" -o -path "/dev/strlog" -o -path "/dev/telnetm" -o -path "/dev/tlclts" -o -path "/dev/async" \
 -o -path "/dev/tlcots" -o -path "/dev/tlcotsod" -o -path "/dev/echo" -o -path "/dev/beep" -o -path "/dev/gvid0" -o -path "/dev/gvid" -o -path "/dev/poll" \
 -o -path "/dev/log" -o -path "/dev/log.um" -o -path "/dev/stcpmap" -o -path "/dev/nuls" -o -path "/dev/usctp6" -o -path "/dev/sctp6" -o -path "/dev/usctp" \
 -o -path "/dev/syscon" -o -path "/dev/sctp" \) -exec ls -l '{}' \; 2>>/dev/null)"
 
if [ -n "$chkfiles" ]; then
 echo "$chkfiles" >> $Results
 echo "Fail" >> $Results
else
 echo "Nothing found" >> $Results
 echo "Pass" >> $Results
fi
