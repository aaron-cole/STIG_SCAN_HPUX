#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The ability to boot from removable media is the same as being able to boot into single user, or maintenance, mode without a password. This ability could allow a malicious user to boot the system and perform changes possibly compromising or damaging the system. It could also allow the system to be used for malicious purposes by a malicious anonymous user.

#STIG Identification
GrpID="V-1013"
GrpTitle="GEN008600"
RuleID="SV-38234r1_rule"
STIGID="GEN008600"
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
   y|yes) echo "SA response is that system is booted from other devices" >> $Results
		  echo "Fail" >> $Results ;;
   n|no)  echo "SA response is that system is NOT booted from other devices" >> $Results
		  echo "Pass" >> $Results ;;
   *) echo "Fail" >> $Results ;;
  esac
 else
  echo "Fail" >> $Results
 fi
else
 echo "Fail" >> $Results
fi