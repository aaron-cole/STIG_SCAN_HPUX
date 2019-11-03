#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If a user's files are group-owned by a group of which the user is not a member, unintended users may be able to access them.

#STIG Identification
GrpID="V-22351"
GrpTitle="GEN001550"
RuleID="SV-35145r1_rule"
STIGID="GEN001550"
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

									
for userline in $(logins -o -x | awk -F: '{print $1":"$6}'); do
 Findings=""
 HOMEDIR="$(echo "$userline" | cut -f 2 -d ":")"
 if [ -d "$HOMEDIR" ]; then
  case "$HOMEDIR" in 
	/|/bin|/usr/bin|/var/adm|/var/spool/lp|/var/spool/uucppublic|/var/opt/hpsmh|/var/pddb|/var/empty|/opt/ids/home)continue;;
  esac
  USRSGRPS="$(groups "$(echo $userline | cut -f 1 -d ":")")"
  findgrps="$(echo "$USRSGRPS" | sed 's/ / -o -group /g' | sed 's/^/-group /g')"
  Findings="$(find $HOMEDIR ! \( $findgrps \) -exec ls -ld '{}' \; )"
  if [ -n "$Findings" ]; then
   echo "$Findings" >> $Results
   ((scorecheck+=1))
  fi
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else
 echo "Nothing Found" >> $Results  
 echo "Pass" >> $Results
fi