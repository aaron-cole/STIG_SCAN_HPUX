#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-23732"
GrpTitle="GEN000410"
RuleID="SV-38407r1_rule"
STIGID="GEN000410"
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
fullbanner="You are accessing a U.S. Government (USG) Information System (IS) that is provided for USG-authorized use only.

By using this IS (which includes any device attached to this IS), you consent to the following conditions:

-The USG routinely intercepts and monitors communications on this IS for purposes including, but not limited to, penetration testing, COMSEC monitoring, network operations and defense, personnel misconduct (PM), law enforcement (LE), and counterintelligence (CI) investigations.

-At any time, the USG may inspect and seize data stored on this IS.

-Communications using, or data stored on, this IS are not private, are subject to routine monitoring, interception, and search, and may be disclosed or used for any USG-authorized purpose.

-This IS includes security measures (e.g., authentication and access controls) to protect USG interests--not for your personal benefit or privacy.

-Notwithstanding the above, using this IS does not constitute consent to PM, LE or CI investigative searching or monitoring of the content of privileged communications, or work product, related to personal representation or services by attorneys, psychotherapists, or clergy, and their assistants. Such communications and work product are private and confidential. See User Agreement for details."
shortbanner="I've read & consent to terms in IS user agreem't."

if [ "$(grep -v "^#" /etc/inetd.conf | grep -c -i ^"ftp")" != 0 ]; then
 if [ ! -f /etc/ftpd/ftpaccess ]; then
  echo "FTP Service is active and /etc/ftpd/ftpaccess does not exist" >> $Results
  echo "Fail" >> $Results
 else
  if grep -v "^#" /etc/ftpd/ftpaccess | grep "banner" >> $Results; then
   bannerfile="$(grep -v "^#" /etc/ftpd/ftpaccess | grep "banner" | awk '{print $2}')"
   if [ ! -f $bannerfile ]; then
    echo "FTP Service running, banner file does not exist" >> $Results
	echo "Fail" >> $Results
   else
    if [ "$(cat "$banner")" = "$fullbanner" ] || [ "$(cat "$banner")" = "$shortbanner" ]; then
	 echo "$banner contains the proper text" >> $Results
	 echo "Pass" >> $Results
	else
	 echo "$banner DOES NOT contains the proper text" >> $Results
	 echo "Fail" >> $Results
	fi
   fi
  else
   echo "no banner directive found in /etc/ftpd/ftpaccess" >> $Results
   echo "Fail" >> $Results
  fi
 fi
else
 echo "FTP service is not found or enabled" >> $Results 
 echo "NA" >> $Results
fi