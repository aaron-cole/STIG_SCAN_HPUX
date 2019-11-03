#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Having the "+" character in the hosts.lpd (or equivalent) file allows all hosts to use local system print resources.

#STIG Identification
GrpID="V-827"
GrpTitle="GEN003900"
RuleID="SV-35140r1_rule"
STIGID="GEN003900"
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

if [ "$(grep -v "^#" /etc/inetd.conf | grep -c rlpdaemon)" -ge 1 ]; then
 grep -v "^#" /etc/inetd.conf | grep rlpdaemon >> $Results
 echo "Print Services are started by inetd" >> $Results
 if [ "$(grep -v "^#" /etc/services | grep printer | grep -c spooler)" -ge 1 ]; then
  grep -v "^#" /etc/services | grep printer | grep spooler >> $Results
  if [ "$(grep -v "^#"  /var/adm/inetd.sec | tr '' ' ' | tr -s ' ' | grep printer | grep allow | grep -c "\+")" -ge 1 ]; then
   grep -v "^#"  /var/adm/inetd.sec | tr '' ' ' | tr -s ' ' | grep printer | grep allow | grep "\+" >> $Results
   ((scorecheck+=1))
  else
   echo "Pass - No + entries found in /var/adm/inetd.sec" >> $Results
  fi
 else
  echo "Pass - Spooler not found in /etc/services" >> $Results
 fi
elif ps -ef | grep rlpdaemon | grep -v grep >> $Results; then
 echo "Print Services started as service" >> $Results
 for file in /etc/hosts.equiv /var/spool/lp/.rhosts; do
  if [ -e "$file" ] ; then
   if [ "$(grep -v "^#" "$file" | grep -c "\+")" -ge 1 ]; then
    echo "Fail - $file - $(grep -v "^#" "$file" | grep -c "\+")" >> $Results
    ((scorecheck+=1))
   else
    echo "Pass - $file - no entries with + found" >> $Results
   fi
  else
   echo "Pass - $file does not exist" >> $Results
  fi
 done
else
 echo "Print services not started through inetd or as a service" >> $Results
fi
 
if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi