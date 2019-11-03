#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If a file executed through a mail alias file has permissions greater than 0755, it can be modified by an unauthorized user and may contain malicious code or instructions possibly compromising the system.

#STIG Identification
GrpID="V-834"
GrpTitle="GEN004420"
RuleID="SV-35043r1_rule"
STIGID="GEN004420"
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
filecheckmode="755"

if cut -f 2,2 -d ":" /etc/mail/aliases | grep "|" | grep -v "^#" >> $Results; then
 for lineentry in $(cut -f 2,2 -d ":" /etc/mail/aliases | grep "|" | grep -v "^#" | cut -f 2 -d "|"); do
  if [ -e $lineentry ]; then
   filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
   if [ $filemode -le $filecheckmode ]; then
    echo "PASS - $(ls -l $file)" >> $Results
   else
    echo "FAIL - $(ls -l $file)" >> $Results
   ((scorecheck+=1))
   fi
  fi
 done
else
 echo "No directories or paths found in /etc/mail/aliases" >> $Results
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi
