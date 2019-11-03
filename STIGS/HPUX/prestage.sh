#!/bin/sh
TempDIR="./Results"
STIGS="V-1013 V-4247 V-4255 V-4392 V-4398 V-11977 V-12024 V-12025 V-23952"

#Remove File if it exists
if [ -e $TempDIR/prestage ]; then
 rm -rf $TempDIR/prestage
fi

echo ""
echo "Please answer the Following Questions with yes, no, y, n"
echo ""

###Check###
for stig in $STIGS; do
 STOP=0
 answer=""
 while [ $STOP -eq 0 ]; do
  case $stig in
		V-1013) echo "Does the System boot from DVD/Tape/USB Drives?";;
		V-4247|V-4255) echo "Does the System use removable media for the boot loader?";;
		V-4392) echo "Is this a Network Management Server?";;
		V-4398) echo "Is the system a designated Router?";;
		V-11977) echo "Are application/system account passwords changed every year?";;
		V-12024) echo "Is there any Instant Messaging clients on the system?";;
		V-12025) echo "Is there any peer-to-peer file sharing applications on the system?"
				 echo "Like napster, kazaa, limewire, IRC Chat Relay?";;
		V-23952) echo "Is the system a documented mail relay?";;
  esac
  read -r answer
  case "$answer" in
	y|yes|n|no) STOP=1;;
	*) echo "Please answer the Following Questions with yes, no, y, n";;
  esac
 done
 echo "$stig:$answer" >> $TempDIR/prestage
done

#For V-4427 V-4428 V-11988
RHOSTfiles="$(find /bin /sbin /dev /etc /home /lib /opt /root /tcb /tmp /var /usr -type f \
 \( -name ".rhosts" -o -name ".shosts" -o -name "hosts.equiv" -o -name "shosts.equiv" \) 2>>/dev/null)"

for f in V-4427 V-4428 V-11988 V-11987; do
 echo "$f:$RHOSTfiles" >> $TempDIR/prestage
done

