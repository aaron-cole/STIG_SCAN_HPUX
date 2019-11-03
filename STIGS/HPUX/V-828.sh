#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Failure to give ownership of the hosts.lpd file to root, bin, sys, or lp provides the designated owner, and possible unauthorized users, with the potential to modify the hosts.lpd file. Unauthorized modifications could disrupt access to local printers from authorized remote hosts or permit unauthorized remote access to local printers.

#STIG Identification
GrpID="V-828"
GrpTitle="GEN003920"
RuleID="SV-35143r1_rule"
STIGID="GEN003920"
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
files="/var/spool/lp/.rhosts /var/adm/inetd.sec /etc/hosts.equiv"
scorecheck=0

for file in $files; do
 if [ -e $file ]; then
  OwnerID="$(perl -le'print((stat shift)[4])' $file)"
  echo "UID for $file is $OwnerID" >> $Results
  case "$OwnerID" in
	0|2|3|9|root|bin|sys|lp) echo "" >> /dev/null;;
	*) ((scorecheck+=1));;
  esac
 else
  echo "$file does not exist" >> $Results
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi