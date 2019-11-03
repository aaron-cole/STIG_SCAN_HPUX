#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Excessive permissions on the hosts.lpd (or equivalent) file may permit unauthorized modification. Unauthorized modifications could disrupt access to local printers from authorized remote hosts or permit unauthorized remote access to local printers.

#STIG Identification
GrpID="V-829"
GrpTitle="GEN003940"
RuleID="SV-35148r1_rule"
STIGID="GEN003940"
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
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi