#!/bin/sh
  
#pull the latest status file from git
status=/Users/zachary/Documents/plex_status/status.dat
git fetch --all
git reset --hard origin/master

grep -e "reboot" $status
RC=$?

if [[ $RC -eq 0 ]]; then
        killAll "Plex Media Server"
        open /Applications/Plex\ Media\ Server.app

        now=`date`
        echo $now > $status
        git commit -m "rebooted PMS"
        git push -u origin master
fi

exit 0
