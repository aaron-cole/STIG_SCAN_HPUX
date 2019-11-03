#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-12024"
GrpTitle="GEN006000"
RuleID="SV-35205r1_rule"
STIGID="GEN006000"
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
   y|yes) echo "SA response is that system has IM clients installed" >> $Results
		  echo "Fail" >> $Results ;;
   n|no)  echo "SA response is that system does not have IM clients installed" >> $Results
		  echo "Pass" >> $Results ;;
   *) echo "Fail" >> $Results ;;
  esac
 else
  echo "Fail" >> $Results
 fi
else
 echo "Fail" >> $Results
fi