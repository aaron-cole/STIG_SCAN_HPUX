#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Globally accessible audio and video devices have proven to be another security hazard. There is software capable of activating system microphones and video devices connected to user workstations and/or X terminals. Once the microphone has been activated, it is possible to eavesdrop on otherwise private conversations without the victim being aware of it. This action effectively changes the user's microphone into a bugging device.

#STIG Identification
GrpID="V-1049"
GrpTitle="GEN002340"
RuleID="SV-38242r1_rule"
STIGID="GEN002340"
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

if ioscan -f | grep "audio" >> $Results; then
 echo "Audio files found - manual check required" >> $Results
 echo "Manual" >> $Results
else
 echo "No Audio device files found" >> $Results
 echo "Pass" >> $Results
fi