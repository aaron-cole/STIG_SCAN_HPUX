#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-777"
GrpTitle="GEN000960"
RuleID="SV-38452r1_rule"
STIGID="GEN000960"
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

for f in $(echo $PATH | sed "s/:/ /g");do
 if [ -e $f ]; then
  filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $f | awk '{print substr($0,length,1)}')"
  case "$filemode" in
   2|3|6|7) echo "FAIL - $(ls -ld $f)" >> $Results 
		   ((scorecheck+=1));;
   *)	   echo "Pass - $(ls -ld $f)" >> $Results ;;
  esac
 else
  echo "Does Not Exist - $f" >> $Results 
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi
