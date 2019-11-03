#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#LDAP can be used to provide user authentication and account information, which are vital to system security.  The LDAP client configuration must be protected from unauthorized modification.

#STIG Identification
GrpID="V-22559"
GrpTitle="GEN008060"
RuleID="SV-38383r1_rule"
STIGID="GEN008060"
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
#File or Directory to check
files="/etc/opt/ldapux/ldapux_client.conf /etc/opt/ldapux/ldapclientd.conf /etc/opt/ldapux/ldapug.conf"
scorecheck=0

if grep -v "^#" /etc/nsswitch.conf | grep ldap >> $Results; then
 for file in $files; do
  if [ -e $file ]; then
   filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
   checkmode="644"
   if [ $filemode -le $checkmode ]; then
    echo "$file is $filemode and less than or equal to $checkmode" >> $Results
   else
    echo "$file is $filemode and not less than or equal to $checkmode" >> $Results
    ((scorecheck+=1))
   fi
  else
   echo "$file does not exist" >> $Results
   ((scorecheck+=1))
  fi
 done
else
 echo "System is not using LDAP"  >> $Results
 echo "NA" >> $Results
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi