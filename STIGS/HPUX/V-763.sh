#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Failure to display the logon banner prior to a logon attempt will negate legal proceedings resulting from unauthorized access to system resources.

#STIG Identification
GrpID="V-763"
GrpTitle="GEN000400"
RuleID="SV-38444r1_rule"
STIGID="GEN000400"
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
banner="You are accessing a U.S. Government (USG) Information System (IS) that is provided for USG-authorized use only.

By using this IS (which includes any device attached to this IS), you consent to the following conditions:

-The USG routinely intercepts and monitors communications on this IS for purposes including, but not limited to, penetration testing, COMSEC monitoring, network operations and defense, personnel misconduct (PM), law enforcement (LE), and counterintelligence (CI) investigations.

-At any time, the USG may inspect and seize data stored on this IS.

-Communications using, or data stored on, this IS are not private, are subject to routine monitoring, interception, and search, and may be disclosed or used for any USG-authorized purpose.

-This IS includes security measures (e.g., authentication and access controls) to protect USG interests--not for your personal benefit or privacy.

-Notwithstanding the above, using this IS does not constitute consent to PM, LE or CI investigative searching or monitoring of the content of privileged communications, or work product, related to personal representation or services by attorneys, psychotherapists, or clergy, and their assistants. Such communications and work product are private and confidential. See User Agreement for details."

cat /etc/issue >> $Results
if [ "$(cat /etc/issue)" = "$banner" ]; then 
 echo "Pass" >> $Results
else
 echo "Banner incorrectly defined" >> $Results 
 echo "Fail" >> $Results
fi