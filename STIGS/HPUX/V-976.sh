#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If cron executes group-writable or world-writable programs, there is a possibility that unauthorized users could manipulate the programs with malicious intent.  This could compromise system and network security.

#STIG Identification
GrpID="V-976"
GrpTitle="GEN003000"
RuleID="SV-38543r1_rule"
STIGID="GEN003000"
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
checkdir="/var/spool/cron/crontabs"
CRONTABCHECK="$(ls "$checkdir")"

if [ -n $CRONTABCHECK ]; then
 for f in $(ls "$checkdir"); do
   while IFS='' read -r line; do 
    case "$(echo "$line")" in
     \#*|^$) ;;
     *) for item in $(echo "$line" | cut -f 6- -d " "); do
		case "$item" in
	     -*|/bin/sh|/bin/ksh|/bin/bash|[12]\>*|\&*|*/dev/null*|*nohup*|*perl*|find|core|rm|uvscan|*logrotate.out|^$) ;;
		 /*) if [ -f "$item" ]; then
			  if [ "$(ls -l "$item" | cut -c 6)" = "w" ]; then
			   echo "Fail - $(ls -l "$item")" >> $Results
			   ((scorecheck+=1))
			  elif [ "$(ls -l "$item" | cut -c 9)" = "w" ]; then
			   echo "Fail - $(ls -l "$item")" >> $Results
			   ((scorecheck+=1))
			  else
			   echo "Pass - $(ls -l "$item")" >> $Results
			  fi 
			 fi;;
		 *) FLOCACTION="$(whereis "$item" | cut -f 2 -d " " 2>>/dev/null)"
		    if [ -n $FLOCACTION ] && [ -f $FLOCACTION ]; then
			 if [ "$(ls -l "$item" | cut -c 6)" = "w" ]; then
			  echo "Fail - $(ls -l "$item")" >> $Results
			  ((scorecheck+=1))
			 elif [ "$(ls -l "$item" | cut -c 9)" = "w" ]; then
			  echo "Fail - $(ls -l "$item")" >> $Results
			  ((scorecheck+=1))
			 else
			  echo "Pass - $(ls -l "$item")" >> $Results
			 fi 
			fi;;			
		esac
		done;;
        
    esac
   done < $checkdir/$f
 done
else
 echo "No Crontabs found" >> $Results
 echo "$CRONTABCHECK" >> $Results
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Pass" >> $Results
fi