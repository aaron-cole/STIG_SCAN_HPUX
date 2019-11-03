#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-915"
GrpTitle="GEN001560"
RuleID="SV-38498r1_rule"
STIGID="GEN001560"
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
 if [ -e $checkdir ]; then
  filelist="$(find "$checkdir" ! -fstype nfs ! -user "$user" ! \( -name .login -o -name .cshrc -o -name .logout \
  -o -name .profile -o -name .bash_profile -o -name .bashrc -o -name .env -o -name .dtprofile -o -name .dispatch \
  -o -name .emacs -o -name .exrc \) \( -perm -0001 -o -perm -0002 -o -perm -0004 -o -perm -0020 -o -perm -2000 \
  -o -perm -4000 \) -exec ls -ld '{}' \;)"
  if [ -z "$filelist" ]; then
   echo "$user - $checkdir - All files have correct permissions" >> $Results
  else
   ((scorecheck+=1))
   echo "FAIL - $user - $checkdir:" >> $Results
   echo "$filelist" >> $Results
  fi
 else
  echo "$checkdir does not exist for $user" >> $Results
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi