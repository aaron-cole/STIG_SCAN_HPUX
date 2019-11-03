#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Limiting the lifespan of authenticators limits the period of time an unauthorized user has access to the system while using compromised credentials and reduces the period of time available for password-guessing attacks to run against a single password. Locking the password for non-interactive and automated processing accounts is preferred as it removes the possibility of accessing the account by a password. On some systems, locking the passwords of these accounts may prevent the account from functioning properly. Passwords for non-interactive/automated processing accounts must not be used for direct logon to the system.

#STIG Identification
GrpID="V-11977"
GrpTitle="GEN000740"
RuleID="SV-38211r1_rule"
STIGID="GEN000740"
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
   y|yes) echo "SA response is that system/application passwords are changed every year" >> $Results
		  echo "Pass" >> $Results ;;
   n|no)  echo "SA response is that system/application passwords are changed every year" >> $Results
		  echo "Fail" >> $Results ;;
   *) echo "Fail" >> $Results ;;
  esac
 else
  echo "Fail" >> $Results
 fi
else
 echo "Fail" >> $Results
fi