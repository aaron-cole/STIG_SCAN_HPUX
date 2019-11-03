#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#NIS/NIS+/yp files are part of the system's identification and authentication processes and are, therefore, critical to system security.  Unauthorized modification of these files could compromise these processes and the system.

#STIG Identification
GrpID="V-791"
GrpTitle="GEN001360"
RuleID="SV-38462r1_rule"
STIGID="GEN001360"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

###Check###

fn_check()
{
filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
checkmode="755"

#Check
if [ $filemode -le $checkmode ]; then
 echo "Perl stat for $file is $filemode and less than or equal to $checkmode" >> $Results
 echo "Pass" >> $Results
else
 echo "Perl stat for $file is $filemode and not less than or equal to $checkmode" >> $Results
 echo "Fail" >> $Results
fi
 }

file="/var/yp/$(domainname)"

if [ "$(awk -F= '/^NIS_MASTER_SERVER/ {print $2}' /etc/rc.config.d/namesvrs)" = 0 ]; then
 echo "System is not a NIS Master Server" >> $Results
 if [ "$(awk -F= '/^NIS_SLAVE_SERVER/ {print $2}' /etc/rc.config.d/namesvrs)" = 0 ]; then
  echo "System is not a NIS Slave Server" >> $Results
  if [ "$(awk -F= '/^NIS_CLIENT/ {print $2}' /etc/rc.config.d/namesvrs)" = 0 ]; then
   echo "System is not a NIS Slave Server" >> $Results
   if [ ! -e $file ]; then
    echo "$file does not exist" >> $Results
    echo "Pass"
   else
    fn_check
   fi
  else
   fn_check
  fi
 else
  fn_check
 fi
else
 fn_check
fi