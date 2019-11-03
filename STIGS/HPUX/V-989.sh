#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If at programs are located in, or subordinate, to world-writable directories, they become vulnerable to removal and replacement by malicious users or system intruders.

#STIG Identification
GrpID="V-989"
GrpTitle="GEN003380"
RuleID="SV-38555r1_rule"
STIGID="GEN003380"
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
			  delimitercount="$(echo "$item" | tr "/" "\n" | grep -v "^$" | wc -l)"
			  filedir="$(echo "$item" | cut -f "1-$delimitercount" -d "/")"
			  if [ "$(ls -ld "$filedir" | cut -c 6)" = "w" ]; then
			   echo "Fail - $(ls -ld "$filedir")" >> $Results
			   ((scorecheck+=1))
			  elif [ "$(ls -ld "$filedir" | cut -c 9)" = "w" ]; then
			   echo "Fail - $(ls -ld "$filedir")" >> $Results
			   ((scorecheck+=1))
			  else
			   echo "Pass - $(ls -ld "$filedir")" >> $Results
			  fi 
			 fi;;
		 *) FLOCACTION="$(whereis "$item" | cut -f 2 -d " ")"
		    if [ -n $FLOCACTION ] && [ -f $FLOCACTION ]; then
			 delimitercount="$(echo "$item" | tr "/" "\n" | grep -v "^$" | wc -l)"
			 filedir="$(echo "$item" | cut -f "1-$delimitercount" -d "/")"
			 if [ "$(ls -ld "$filedir" | cut -c 6)" = "w" ]; then
			  echo "Fail - $(ls -ld "$filedir")" >> $Results
			  ((scorecheck+=1))
			 elif [ "$(ls -ld "$filedir" | cut -c 9)" = "w" ]; then
			  echo "Fail - $(ls -ld "$filedir")" >> $Results
			  ((scorecheck+=1))
			 else
			  echo "Pass - $(ls -ld "$filedir")" >> $Results
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