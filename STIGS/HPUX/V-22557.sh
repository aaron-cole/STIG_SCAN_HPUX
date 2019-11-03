#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The NSS LDAP service provides user mappings which are a vital component of system security.  Communication between an LDAP server and a host using LDAP for NSS require authentication.

#STIG Identification
GrpID="V-22557"
GrpTitle="GEN008020"
RuleID="SV-38381r1_rule"
STIGID="GEN008020"
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

if grep -v "^#" /etc/nsswitch.conf | grep ldap >> $Results; then
 if [ -f /etc/opt/ldapux/ldapux_client.conf ] && [ "$(grep "^peer_cert_policy=" /etc/opt/ldapux/ldapux_client.conf | wc -l)" -eq 1 ]; then
 awk -v opf="$Results" -F= '/^peer_cert_policy=/ {
	if($2 == "WEAK" || $2 == "") {
	 print $0 >> opf
	 print "Fail" >> opf
	} else {
	 print $0 >> opf
	 print "Pass" >> opf
	}
}' /etc/opt/ldapux/ldapux_client.conf
 else
  echo "Setting not defined or more than 1 configuration" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "System is not using LDAP"  >> $Results
 echo "NA" >> $Results
fi