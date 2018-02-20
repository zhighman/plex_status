#!/bin/sh
  
#pull the latest status file from git
status=/Users/zachary/Documents/plex_status/status.dat
cd /Users/zachary/Documents/plex_status

git fetch --all
git reset --hard origin/master

grep -e "reboot" $status
RC=$?

if [[ $RC -eq 0 ]]; then
        killAll "Plex Media Server"
        sleep 10
        open /Applications/Plex\ Media\ Server.app

        now=`date`
        echo $now > $status
        git add $status
        git commit -m "rebooted PMS"
        git push -u origin master
fi

exit 0
