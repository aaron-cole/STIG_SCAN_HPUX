#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The NFS access option limits user access to the specified level. This assists in protecting shared file systems.  If access is not restricted, unauthorized hosts may be able to access the system's NFS shares.

#STIG Identification
GrpID="V-933"
GrpTitle="GEN005840"
RuleID="SV-35201r1_rule"
STIGID="GEN005840"
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

if [ -e /etc/dfs/sharetab ]; then
 if [ "$(cat /etc/dfs/sharetab | grep -v "^#" | wc -l)" = 0 ]; then
  echo "No NFS Shares on the System" >> $Results
 else
  while IFS='' read -r line; do
   case "$(echo "$line")" in
    \#* |^$) ;;
    *) if echo "$line" | egrep "rw=|ro=" >> /dev/null; then
		echo "PASS - $line" >> $Results
   	   else
		echo "FAIL/REVIEW - $line" >> $Results
	    ((scorecheck+=1))
	   fi;;
   esac
  done < /etc/dfs/sharetab
 fi
else
 echo "/etc/dfs/sharetab does not exist" >> $Results
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Pass" >> $Results
fi