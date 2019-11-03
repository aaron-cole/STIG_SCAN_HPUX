#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#NIS/NIS+/yp files are part of the system's identification and authentication processes and are, therefore, critical to system security.  Failure to give ownership of sensitive files or utilities to root or bin provides the designated owner and unauthorized users with the potential to access sensitive information or change the system configuration which could weaken the system's security posture.

#STIG Identification
GrpID="V-789"
GrpTitle="GEN001320"
RuleID="SV-38460r1_rule"
STIGID="GEN001320"
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
 OwnerID="$(perl -le'print((stat shift)[4])' $file)"
 if [ -f $file ]; then
  ls -lL $file >> $Results
 elif [ -d $file ]; then
  ls -ld $file >> $Results
 else
  echo "Not a file or dir" >> $Results
 fi

 echo "Perl stat for UID is $OwnerID" >> $Results
 
 case "$OwnerID" in
	0|2|3|root|bin|sys) echo "Pass"  >> $Results;;
	*) echo "Fail" >> $Results;;
 esac
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