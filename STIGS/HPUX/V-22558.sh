#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#LDAP can be used to provide user authentication and account information, which are vital to system security. Communication between an LDAP server and a host using LDAP requires authentication.

#STIG Identification
GrpID="V-22558"
GrpTitle="GEN008040"
RuleID="SV-38382r1_rule"
STIGID="GEN008040"
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
 if [ -f /etc/ldap.conf ] && [ "$(grep -i "^tls_crlcheck " /etc/ldap.conf | wc -l)" -eq 1 ]; then
 awk -v opf="$Results" '/^tls_crlcheck / {
	if($2 == "all") {
	 print $0 >> opf
	 print "Pass" >> opf
	} else {
	 print $0 >> opf
	 print "Fail" >> opf
	}
}' /etc/ldap.conf
 else
  echo "Setting not defined or more than 1 configuration" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "System is not using LDAP"  >> $Results
 echo "NA" >> $Results
fi