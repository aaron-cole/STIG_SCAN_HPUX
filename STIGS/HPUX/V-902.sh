#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If users do not own their home directories, unauthorized users could access user files.

#STIG Identification
GrpID="V-902"
GrpTitle="GEN001500"
RuleID="SV-38490r1_rule"
STIGID="GEN001500"
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
 USERUID="$(grep "^$user:" /etc/passwd | cut -f 3 -d ":")"
 if [ -e "$checkdir" ]; then
  OwnerID="$(perl -le'print((stat shift)[4])' $checkdir)"
  if [ $USERUID -eq $OwnerID ]; then
   echo "PASS - $(ls -ld $checkdir)" >> $Results
  else
   echo "FAIL - Make sure this is not an application account - $(ls -ld $checkdir)" >> $Results
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