#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Systems must employ cryptographic hashes for passwords using the SHA-2 family of algorithms or FIPS 140-2 approved successors.  The use of unapproved algorithms may result in weak password hashes that are more vulnerable to compromise.

#STIG Identification
GrpID="V-22303"
GrpTitle="GEN000590"
RuleID="SV-52489r3_rule"
STIGID="GEN000590"
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

#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 echo "System is in Trusted Mode and there is no Fix per STIG"  >> $Results
 echo "Fail" >> $Results
else
#For SMSE
 if [ -f /etc/default/security ] && [ "$(grep "^CRYPT_ALGORITHMS_DEPRECATE=" /etc/default/security | wc -l)" -eq 1 ]; then
 awk -v opf="$Results" -F= '/^CRYPT_ALGORITHMS_DEPRECATE=/ {
	if($2 == "__unix__") {
	 print "Pass - $0" >> opf
	} else {
	 print "Fail - $0" >> opf
	}
}' /etc/default/security
  if [ -f /etc/default/security ] && [ "$(grep "^CRYPT_DEFAULT=" /etc/default/security | wc -l)" -eq 1 ]; then
   awk -v opf="$Results" -F= '/^CRYPT_DEFAULT=/ {
	if($2 == 6) {
	 print "Pass - $0" >> opf
	} else {
	 print "Fail - $0" >> opf
	}
}' /etc/default/security
  else
   echo "Setting not defined or more than 1 configuration" >> $Results
   echo "Fail" >> $Results
  fi
 else
  echo "Setting not defined or more than 1 configuration" >> $Results
  echo "Fail" >> $Results
 fi
fi

if grep "Fail" $Results >> /dev/null; then
 echo "Fail" >> $Results
else
 echo "Pass" >> $Results
fi
