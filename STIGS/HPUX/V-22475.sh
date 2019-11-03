#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-22475"
GrpTitle="GEN005526"
RuleID="SV-35075r1_rule"
STIGID="GEN005526"
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

if [ -n /etc/krb5.conf ] && [ -n /etc/krb5.keytab ]; then
 if [ -f /opt/ssh/etc/sshd_config ] && [ "$(grep "^KerberosAuthentication " /opt/ssh/etc/sshd_config | wc -l)" -eq 1 ]; then
  awk -v opf="$Results" '/^KerberosAuthentication / {
	if($2 == "yes" || $2 == "Yes") {
	 print $0 >> opf
	 print "Fail" >> opf
	} else {
	 print $0 >> opf
	 print "Pass" >> opf
	}
}' /opt/ssh/etc/sshd_config 
 elif [ "$(grep "^KerberosAuthentication " /opt/ssh/etc/sshd_config | wc -l)" -eq 0 ]; then
  echo "Setting not defined" >> $Results
  echo "Pass" >> $Results
 else
  echo "Setting not defined or more than 1 configuration defined" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "System does not use Kerberos for Authentication" >> $Results
 echo "NA" >> $Results
fi