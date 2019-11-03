#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Storing the boot loader on removable media in an insecure location could allow a malicious user to modify the systems boot instructions or boot to an insecure operating system.

#STIG Identification
GrpID="V-4255"
GrpTitle="GEN008680"
RuleID="SV-38425r1_rule"
STIGID="GEN008680"
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