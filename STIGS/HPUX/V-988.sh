#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the at facility executes group- or world-writable programs, it is possible for the programs to be accidentally or maliciously changed or replaced without the owner's intent or knowledge. This would cause a system security breach.

#STIG Identification
GrpID="V-988"
GrpTitle="GEN003360"
RuleID="SV-38554r1_rule"
STIGID="GEN003360"
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
checkdir="/var/spool/cron/atjobs"
ATJOBCHECK="$(ls "$checkdir")"

if [ -n "$ATJOBCHECK" ]; then
 for f in $(ls "$checkdir"); do
  if [ "$f" != "dead.letter" ]; then
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
		 *) FLOCACTION="$(whereis "$item" | cut -f 2 -d " ")"
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
  fi
 done
else
 echo "No atjobs found" >> $Results
 echo "$ATJOBCHECK" >> $Results
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Pass" >> $Results
fi