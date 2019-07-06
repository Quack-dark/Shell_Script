#!/bin/bash

echo "* * * * * sh '/data/xBoxScript/crontab/run_xBox.sh'" >>/var/spool/cron/root
service crond reload
