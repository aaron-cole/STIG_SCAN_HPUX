#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#LDAP can be used to provide user authentication and account information, which are vital to system security.  The LDAP client configuration must be protected from unauthorized modification.

#STIG Identification
GrpID="V-22561"
GrpTitle="GEN008100"
RuleID="SV-38385r1_rule"
STIGID="GEN008100"
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
   GOwnerID="$(perl -le'print((stat shift)[5])' $file)"
   echo "GID for $file is $GOwnerID" >> $Results
   case "$GOwnerID" in
	0|2|3|root|bin|sys) echo "" >> /dev/null;;
	*) ((scorecheck+=1));;
   esac
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