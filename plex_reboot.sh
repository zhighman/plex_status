#!/bin/sh

#pull the latest status file from git
status=/tmp/plex_status.dat
curl -o $status https://raw.githubusercontent.com/zhighman/plex_status/master/status.dat



grep -e "reboot" $status
RC=$?

if [[ $RC -eq 0 ]]; then
	killAll "Plex Media Server"
	open /Applications/Plex\ Media\ Server.app

	now=`date`
	echo $now > ~/Documents/plex_status/status.dat
	cd /Documents/git/plex_status/
	git commit -m "rebooted PMS"
	git push -u origin master
fi

exit 0
