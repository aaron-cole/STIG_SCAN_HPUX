#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The use of hard-to-guess NIS domain names provides additional protection from unauthorized access to the NIS directory information.

#STIG Identification
GrpID="V-12026"
GrpTitle="GEN006420"
RuleID="SV-35153r1_rule"
STIGID="GEN006420"
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
echo "domainname returns - $(domainname)" >> $Results

if [ "$(domainname)" = "" ]; then
 echo "No NIS domain name specified" >> $Results
 echo "Pass" >> $Results 
elif [ "$(domainname)" = "*.mil" ]; then
 echo "Domain name specified" >> $Results
 echo "Pass" >> $Results
else
 echo "Check domainname" >> $Results
 echo "Manual" >> $Results
fi