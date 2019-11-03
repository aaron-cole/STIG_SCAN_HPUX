#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#When an NFS server is configured to deny remote root access, a selected UID and GID are used to handle requests from the remote root user.  The UID and GID should be chosen from the system to provide the appropriate level of non-privileged access.

#STIG Identification
GrpID="V-932"
GrpTitle="GEN005820"
RuleID="SV-35199r1_rule"
STIGID="GEN005820"
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

if [ -e /etc/dfs/dfstab ]; then
 if [ "$(cat /etc/dfs/dfstab | grep -v "^#" | wc -l)" = 0 ]; then
  echo "No NFS Shares on the System" >> $Results
 else
  while IFS='' read -r line; do
   case "$(echo "$line")" in
    \#* |^$) ;;
    *) if echo "$line" | egrep "anon=-1|anon=60001|anon=65534|anon=65535" >> /dev/null; then
		echo "PASS - $line" >> $Results
   	   else
		echo "FAIL/REVIEW - $line" >> $Results
	    ((scorecheck+=1))
	   fi;;
   esac
  done < /etc/dfs/dfstab
 fi
else
 echo "/etc/dfs/dfstab does not exist"
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Pass" >> $Results
fi