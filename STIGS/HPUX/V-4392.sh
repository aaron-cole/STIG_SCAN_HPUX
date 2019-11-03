#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Installing extraneous software on a system designated as a dedicated NMS server poses a security threat to the system and the network. Should an attacker gain access to the NMS through unauthorized software, the entire network may be susceptible to malicious activity.

#STIG Identification
GrpID="V-4392"
GrpTitle="GEN005380"
RuleID="SV-35181r1_rule"
STIGID="GEN005380"
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
   y|yes) echo "SA response is that system is a Network Management Server" >> $Results
		  echo "Fail" >> $Results ;;
   n|no)  echo "SA response is that system is NOT a Network Management Server" >> $Results
		  echo "Pass" >> $Results ;;
   *) echo "Fail" >> $Results ;;
  esac
 else
  echo "Fail" >> $Results
 fi
else
 echo "Fail" >> $Results
fi