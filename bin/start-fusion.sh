#!/bin/bash
#export OOO_FORCE_DESKTOP=kde4
export FLASH_FORCE_PULSEAUDIO=1 
#source ~/.bash_profile
#compiz ccp &
kwin --replace &
nitrogen --restore &
pulseaudio -D &
#sleep 5  && amixer -c 1 -- sset Speaker playback 10% &
#emerald &         #edit to add: this is optional, you don't need emerald at all.
#fusion-icon &
#sleep 15 && skype &
#sleep 20 && transmission-gtk -m &
#sleep 20 && qbittorrent --no-splash &
#sleep 40 && deluged &
#sleep 5  && devilspie &
sleep 8  && kupfer  --no-splash &
sleep 3 && avant-window-navigator &
sleep 6 && nm-applet&
sleep 3  && tilda 
