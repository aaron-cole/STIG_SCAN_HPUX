#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Failure to give ownership of sensitive files or utilities to system groups may provide unauthorized users with the potential to access sensitive information or change the system configuration which could weaken the system's security posture.

#STIG Identification
GrpID="V-22423"
GrpTitle="GEN003730"
RuleID="SV-35069r1_rule"
STIGID="GEN003730"
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
  GOwnerID="$(perl -le'print((stat shift)[5])' $file)"
  echo "GID for $file is $GOwnerID" >> $Results
  case "$GOwnerID" in
	0|2|3|root|bin|sys) echo "PASS - $(ls -ld $file)" >> $Results;;
	*) echo "FAIL - $(ls -l $file)" >> $Results
	   ((scorecheck+=1));;
  esac
  if grep -v "^#" $file | grep -i "includedir" >> $Results; then
   filedir="$(grep -v "^#" $file | grep -i "includedir" | cut -f 2 -d " ")"
   GDIROWNER="$(perl -le'print((stat shift)[5])' $filedir)"
   echo "GID for $filedir is $GDIROWNER" >> $Results
   case "$GDIROWNER" in
	0|2|3|root|bin|sys) echo "PASS - $(ls -ld $filedir)" >> $Results;;
	*) echo "FAIL - $(ls -ld $filedir)" >> $Results
	   ((scorecheck+=1));;
   esac
   for filedirfile in $filedir/*; do
    GFILEDIRFILEOWNER="$(perl -le'print((stat shift)[5])' $filedirfile)"
    echo "GID for $filedirfile is $GFILEDIRFILEOWNER" >> $Results
    case "$GFILEDIRFILEOWNER" in
	 0|2|3|root|bin|sys) echo "PASS - $(ls -ld $filedirfile)" >> $Results;;
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
