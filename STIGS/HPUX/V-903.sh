#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the GID of the home directory is not the same as the GID of the user, this would allow unauthorized access to files.

#STIG Identification
GrpID="V-903"
GrpTitle="GEN001520"
RuleID="SV-38491r1_rule"
STIGID="GEN001520"
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
userlist="$(egrep -v "^daemon:|^bin:|^sys:|^adm:|^uucp:|^lp:|^nuucp:|^hpdb:|^nobody:|^www:|^cimsrvr:|^sfmdb:|^iwww:|^owww:|^hpsmh:|^sshd:|^ids:" /etc/passwd | cut -f 1 -d ":")"

for user in $userlist; do
 checkdir="$(grep "^$user:" /etc/passwd | cut -f 6 -d ":")"
 USERGID="$(grep "^$user:" /etc/passwd | cut -f 4 -d ":")"
 if [ -e "$checkdir" ]; then
  OwnerGID="$(perl -le'print((stat shift)[5])' $checkdir)"
  if [ $USERGID -eq $OwnerGID ]; then
   echo "PASS - $(ls -ld $checkdir)" >> $Results
  else
   echo "FAIL - if application account it needs to be documented with ISSM - $(ls -ld $checkdir)" >> $Results
  ((scorecheck+=1))
  fi
 else
  echo "$user - $checkdir - Home directory does not exist" >> $Results
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi