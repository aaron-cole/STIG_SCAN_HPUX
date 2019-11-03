#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If a file executed through a mail aliases file is not owned and writable only by root, it may be subject to unauthorized modification. Unauthorized modification of files executed through aliases may allow unauthorized users to attain root privileges.

#STIG Identification
GrpID="V-833"
GrpTitle="GEN004400"
RuleID="SV-35169r1_rule"
STIGID="GEN004400"
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

if cut -f 2,2 -d ":" /etc/mail/aliases | grep "|" | grep -v "^#" >> $Results; then
 for lineentry in $(cut -f 2,2 -d ":" /etc/mail/aliases | grep "|" | grep -v "^#" | cut -f 2 -d "|"); do
  if [ -e $lineentry ]; then
   OwnerID="$(perl -le'print((stat shift)[4])' $lineentry)"
   echo "UID for $lineentry is $OwnerID" >> $Results
   case "$OwnerID" in
	0|root) echo "PASS - $(ls -l $lineentry)" >> $Results;;
	*) echo "FAIL - $(ls -l $lineentry)" >> $Results
	   ((scorecheck+=1));;
   esac
   delimitercount="$(echo "$lineentry" | tr "/" "\n" | grep -v "^$" | wc -l)"
   filedir="$(echo "$lineentry" | cut -f "1-$count" -d "/")"
   DIROWNER="$(perl -le'print((stat shift)[4])' $filedir)"
   echo "UID for $lineentry is $DIROWNER" >> $Results
   case "$DIROWNER" in
	0|root) echo "PASS - $(ls -ld $filedir)" >> $Results;;
	*) echo "FAIL - $(ls -ld $filedir)" >> $Results
	   ((scorecheck+=1));;
   esac 
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