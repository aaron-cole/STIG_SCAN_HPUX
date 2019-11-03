#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If an unauthorized user obtains the private SSH host key file, the host could be impersonated.

#STIG Identification
GrpID="V-22472"
GrpTitle="GEN005523"
RuleID="SV-35063r1_rule"
STIGID="GEN005523"
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
#File or Directory to check
files="/opt/ssh/etc/ssh_host_dsa_key /opt/ssh/etc/ssh_host_rsa_key"
scorecheck=0

for file in $files; do
 if [ -e $file ]; then
  filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
  checkmode="600"
  if [ $filemode -le $checkmode ]; then
   echo "$file is $filemode and less than or equal to $checkmode" >> $Results
  else
   echo "$file is $filemode and not less than or equal to $checkmode" >> $Results
   ((scorecheck+=1))
  fi
 else
  echo "$file does not exist" >> $Results
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi