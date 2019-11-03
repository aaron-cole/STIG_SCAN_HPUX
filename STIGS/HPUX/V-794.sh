#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Restricting permissions will protect system command files from unauthorized modification. System command files include files present in directories used by the operating system for storing default system executables and files present in directories included in the system's default executable search paths.

#STIG Identification
GrpID="V-794"
GrpTitle="GEN001200"
RuleID="SV-38465r1_rule"
STIGID="GEN001200"
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
files="$(find /etc /bin /usr/bin /usr/lbin /sbin /usr/sbin -type f \( -perm -020 -o -perm -002 \))"

if [ -z "$files" ]; then
 echo "Nothing found" >> $Results
else
 echo "Review files to see if they are system commands" >> $Results
 for file in $files; do
  case "$file" in
   *.conf|_conf|*.dat|/etc/lvmrc|/etc/kbdland|/etc/jlumachine.id|/usr/sbin/stm/ui/config/.stmrc) continue;;
  esac
  ls -l "$file" >> $Results
  ((scorecheck+=1))
 done
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi