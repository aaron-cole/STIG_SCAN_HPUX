#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If unrestricted mail relaying is permitted, unauthorized senders could use this host as a mail relay for the purpose of sending SPAM or other unauthorized activity.

#STIG Identification
GrpID="V-23952"
GrpTitle="GEN004710"
RuleID="SV-38410r1_rule"
STIGID="GEN004710"
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

fncheck () 
{
if grep -v "^#" /etc/rc.config.d/mailservers | grep "=1" >> $Results ; then
 echo "Some portion of Sendmail is configured to run" >> $Results
 if grep -i "O DaemonPortOptions" /etc/mail/sendmail.cf | egrep -v "^#|loopback|localhost|127.0.0.1" >> $Results; then
  echo "Fail" >> $Results
 else
  grep -i "O DaemonPortOptions" /etc/mail/sendmail.cf >> $Results
  echo "Pass" >> $Results
 fi
else
 echo "Sendmail is not configured to run" >> $Results
 grep -v "^#" /etc/rc.config.d/mailservers >> $Results
 echo "Pass" >> $Results
fi

# find / -name sendmail.mc
# grep -i promiscuous_relay </path/to/sendmail.mc>

}
if [ -e "$answerfile" ]; then
 if [ "$(grep "$GrpID" $answerfile | cut -f 2 -d ":" | wc -m)" -ge 1 ]; then
  case "$(grep "$GrpID" $answerfile | cut -f 2 -d ":")" in
   y|yes) echo "SA response is that the system is a documented mail relay" >> $Results
		  echo "NA" >> $Results ;;
   n|no)  echo "SA response is that the system is not a documented mail relay" >> $Results
		  fncheck ;;
   *) echo "Fail" >> $Results ;;
  esac
 else
  echo "Fail" >> $Results
 fi
else
 echo "Fail" >> $Results
fi