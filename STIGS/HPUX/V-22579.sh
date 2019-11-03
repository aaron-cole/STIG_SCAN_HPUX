#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#USB is a common computer peripheral interface.  USB devices may include storage devices that could be used to install malicious software on a system or exfiltrate data.

#STIG Identification
GrpID="V-22579"
GrpTitle="GEN008480"
RuleID="SV-38401r1_rule"
STIGID="GEN008480"
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

ioscan -fnC usb >> $Results

if [ "$(ioscan -fnC usb)" ]; then
 if hpvminfo | grep "guest" >> $Results; then
  if [ "$(ioscan -fnC usb | egrep -i "usbms|Mass Storage")" ]; then
   echo "USB Mass storage is being used" >> $Results
   echo "Fail" >> $Results
  else
   echo "Server is a Virtual Machine and there are no Mass Storage devices" >> $Results
   echo "Pass" >> $Results
  fi
 else
  if [ "$(ioscan -fnC usb | egrep -i "usbms|Mass Storage")" ]; then
   echo "USB Mass storage is being used" >> $Results
   echo "Fail" >> $Results
  else
   echo "Server is appears to be physical and requires USB for keyboard/mouse - can't disable" >> $Results
   echo "There are no Mass Storage devices" >> $Results
   echo "NA" >> $Results
  fi
 fi
else
 echo "No USB controller or devices found" >> $Results
 echo "Pass" >> $Results
fi