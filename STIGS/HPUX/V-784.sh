#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Discretionary access control is undermined if users, other than a file owner, have greater access permissions to system files and directories than the owner.

#STIG Identification
GrpID="V-784"
GrpTitle="GEN001140"
RuleID="SV-38457r1_rule"
STIGID="GEN001140"
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

#chkfiles="$(find  /etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin -type f \( -perm /u-x,g+x -o -perm /u-w,g+w -o -perm /u-r,g+r -o -perm /g-x,o+x -o -perm /g-w,o+w -o -perm /g-r,o+r -o -perm /u-x,o+x -o -perm /u-w,o+w -o -perm /u-r,o+r \) -exec ls -l '{}' \;)"
chkfiles="$(find  /etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin -type f \( ! -perm -u=x -perm -g=x \) -o \( ! -perm -u=w -perm -g=w \) -o \( ! -perm -u=r -perm -g=r \) \
 -o \( ! -perm -u=x -perm -o=x \) -o \( ! -perm -u=w -perm -o=w \) -o \( ! -perm -u=r -perm -o=r \) -o \( ! -perm -g=x -perm -o=x \) -o \( ! -perm -g=w -perm -o=w \) -o \( ! -perm -g=r -perm -o=r \) 2>>/dev/null)"

if [ -z "$chkfiles" ]; then
 echo "No uneven file permissions found" >> $Results
 echo "Pass" >> $Results
else
 echo "Uneven File Permissions found" >> $Results
 for FILE in $chkfiles; do
  ls -l $FILE >> $Results
 done
 echo "Fail" >> $Results
fi
