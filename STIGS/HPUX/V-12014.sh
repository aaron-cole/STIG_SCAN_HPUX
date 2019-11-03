#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#.Xauthority files ensure the user is authorized to access the specific X Windows host. Excessive permissions may permit unauthorized modification of these files, which could lead to Denial of Service to authorized access or allow unauthorized access to be obtained.

#STIG Identification
GrpID="V-12014"
GrpTitle="GEN005180"
RuleID="SV-35162r1_rule"
STIGID="GEN005180"
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
scorecheck=0
USERSDIRS="$(logins -u -o -x | cut -f 6 -d ":")"
checkmode=600

for USERDIR in $USERDIRS; do
 if [ -f $USERDIR/.Xauthority ]; then
  filedirmode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $USERDIR/.Xauthority)"
   if [ $filedirmode -le $checkmode ]; then
    echo "$USERDIR/.Xauthority is $filedirmode and less than or equal to $checkmode" >> $Results
   else
    echo "$USERDIR/.Xauthority is $filedirmode and not less than or equal to $checkmode" >> $Results
    ((scorecheck+=1))
   fi
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi