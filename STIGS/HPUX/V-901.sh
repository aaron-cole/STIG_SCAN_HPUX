#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Excessive permissions on home directories allow unauthorized access to user files.

#STIG Identification
GrpID="V-901"
GrpTitle="GEN001480"
RuleID="SV-34870r1_rule"
STIGID="GEN001480"
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
dircheckmode="750"

for user in $userlist; do
 checkdir="$(grep "^$user:" /etc/passwd | cut -f 6 -d ":")"
 if [ -e $checkdir ]; then
  filedirmode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $checkdir)"
  if [ $filedirmode -le $dircheckmode ]; then
   echo "PASS - $(ls -ld $checkdir)" >> $Results
  else
   echo "FAIL Make sure this is not an application account - $(ls -ld $checkdir)" >> $Results
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