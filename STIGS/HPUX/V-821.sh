#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Failure to give ownership of sensitive files or utilities to root provides the designated owner and unauthorized users with the potential to access sensitive information or change the system configuration which could weaken the system's security posture.

#STIG Identification
GrpID="V-821"
GrpTitle="GEN003720"
RuleID="SV-35067r1_rule"
STIGID="GEN003720"
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
files="/etc/inetd.conf /etc/xinetd.conf /etc/xinetd.d"
scorecheck=0

for file in $files; do
 if [ -e "$file" ]; then
  OwnerID="$(perl -le'print((stat shift)[4])' $file)"
  echo "UID for $file is $OwnerID" >> $Results
  case "$OwnerID" in
	0|2|root|bin) echo "PASS - $(ls -ld $file)" >> $Results;;
	*) echo "FAIL - $(ls -l $file)" >> $Results
	   ((scorecheck+=1));;
  esac
  if grep -v "^#" $file | grep -i "includedir" >> $Results; then
   filedir="$(grep -v "^#" $file | grep -i "includedir" | cut -f 2 -d " ")"
   DIROWNER="$(perl -le'print((stat shift)[4])' $filedir)"
   echo "UID for $filedir is $DIROWNER" >> $Results
   case "$DIROWNER" in
	0|2|root|bin) echo "PASS - $(ls -ld $filedir)" >> $Results;;
	*) echo "FAIL - $(ls -ld $filedir)" >> $Results
	   ((scorecheck+=1));;
   esac
   for filedirfile in $filedir/*; do
    FILEDIRFILEOWNER="$(perl -le'print((stat shift)[4])' $filedirfile)"
    echo "UID for $filedirfile is $FILEDIRFILEOWNER" >> $Results
    case "$FILEDIRFILEOWNER" in
	 0|2|root|bin) echo "PASS - $(ls -ld $filedirfile)" >> $Results;;
	 *) echo "FAIL - $(ls -ld $filedirfile)" >> $Results
	   ((scorecheck+=1));;
    esac
   done
  else
   echo "No includedir statement found in $file" >> $Results
  fi
 else
  echo "$file does not exist on the system" >> $Results
 fi
done
 
if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi