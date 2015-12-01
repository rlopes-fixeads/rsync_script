#!/bin/sh
# rsync -oavzr /media/Server/realestate/id /home/rlopes/Codes/php/ > /dev/null 2>&1
while true ; do 
    /usr/bin/rsync -ar --delete --exclude 'log' /home/rlopes/Codes/php/realestates/id/ /media/Server/realestate/id  > /dev/null 2>&1 ; 
    #sleep 2; 
done
