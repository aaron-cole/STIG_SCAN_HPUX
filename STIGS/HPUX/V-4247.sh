#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Malicious users with removable boot media can gain access to a system configured to use removable media as the boot loader.

#STIG Identification
GrpID="V-4247"
GrpTitle="GEN008640"
RuleID="SV-38424r1_rule"
STIGID="GEN008640"
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
answerfile="./Results/prestage"

if [ -e "$answerfile" ]; then
 if [ "$(grep "$GrpID" $answerfile | cut -f 2 -d ":" | wc -m)" -ge 1 ]; then
  case "$(grep "$GrpID" $answerfile | cut -f 2 -d ":")" in
   y|yes) echo "SA response is that system uses removable media for the boot loader" >> $Results
		  echo "Fail" >> $Results ;;
   n|no)  echo "SA response is that system DOES NOT use removable media for the boot loader" >> $Results
		  echo "Pass" >> $Results ;;
   *) echo "Fail" >> $Results ;;
  esac
 else
  echo "Fail" >> $Results
 fi
else
 echo "Fail" >> $Results
fi