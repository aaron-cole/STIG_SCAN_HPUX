#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Restricting permission on daemons will protect them from unauthorized modification and possible system compromise.

#STIG Identification
GrpID="V-786"
GrpTitle="GEN001180"
RuleID="SV-38458r1_rule"
STIGID="GEN001180"
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
chkowner=7
chkgroup=5
chkother=5
LISTENING="$(netstat -an | grep "LISTEN" | awk '{print $1"-"$4}'| sed 's/tcp6/tcp/g' | sort | uniq)"

for line in $LISTENING; do
 PROTO="$(echo "$line" | cut -f 1 -d "-" )"
 PORT="$(echo "$line" | cut -f 2 -d "-" | rev | cut -f 1 -d "." | rev)"
 CHECKPIDS="$(lsof -ni $PROTO:$PORT | grep "LISTEN" | awk '{print $2}' | sort | uniq)"
 for CHECKPID in $CHECKPIDS; do
  if [ "$(ps -p $CHECKPID 2>>/dev/null | wc -l)" -eq 2 ]; then
   file="$(ps -fp $CHECKPID 2>>/dev/null | tail -1 | awk '{print $9}')"
   if [ -f "$file" ]; then
    ls -alL "$file" >> $Results
   elif [ -f /sbin/init.d/"$file" ]; then
    file="/sbin/init.d/$file"
	ls -alL "$file" >> $Results
   elif [ "$file" = "sshd" ]; then
    file="/opt/ssh/sbin/sshd"
	ls -alL "$file" >> $Results
   else
    file="$(ps -fp $CHECKPID 2>>/dev/null | tail -1 | awk '{print $8}')"
    ls -alL "$file" >> $Results
   fi
   start=1
   filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
   while [ "$start" -le ${#filemode} ] ; do
    if [ ${#filemode} = 4 ] && [ "$start" = 1 ]; then
     start="$((start+1))"  
     continue
    fi
    if [ ${#filemode} = 4 ]; then
     case "$start" in
      2)effectivestart=1;;
      3)effectivestart=2;;
      4)effectivestart=3;;
     esac
    else
     effectivestart="$start"
    fi
 
    checknum=$(echo $filemode | cut -c $start)
 
    case "$effectivestart" in
     1) if [ $chkowner -lt $checknum ]; then
         ((scorecheck+=1))
	    fi
        start="$((start+1))" ;;
     2) if [ $chkgroup -lt $checknum ]; then
         ((scorecheck+=1))
	    fi
        start="$((start+1))" ;;
   
     3) if [ $chkother -lt $checknum ]; then
         ((scorecheck+=1))
	    fi
        start="$((start+1))" ;;
    esac
   done
  else
   echo "Manual Review for $(ps -fp $CHECKPID) is required" >> $Restricting
   ((scorecheck+=1))
  fi
 done
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi


