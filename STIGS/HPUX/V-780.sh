#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Reserved GIDs are typically used by system software packages. If non-system groups have GIDs in this range, they may conflict with system software, possibly leading to the group having permissions to modify system files.

#STIG Identification
GrpID="V-780"
GrpTitle="GEN000360"
RuleID="SV-38454r1_rule"
STIGID="GEN000360"
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

for f in $(cut -f 1,4 -d ":" /etc/passwd); do
 if [ $(echo $f | cut -f 2 -d ":") -le 99 ]; then
  case "$(echo $f | cut -f 1 -d ":")" in 
    root|daemon|bin|sys|adm|uucp|lp|nuucp|hpdb|nobody|www|cimsrvr|sfmdb|iwww|owww|hpsmh|smmsp|guidmgr|guiddb) echo "" >> /dev/null;;
	*) ((scorecheck+=1))
	   echo "$f - Fail" >> $Results;;
  esac
 fi  
done

if [ "$scorecheck" != 0 ]
then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results 
 echo "Pass" >> $Results
fi