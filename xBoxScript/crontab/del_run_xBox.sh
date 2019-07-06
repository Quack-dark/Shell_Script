#!/bin/bash

#删除crond
sed -i '/run_xBox.sh/d' /var/spool/cron/root
#删除空白行
sed -i '/^$/d' /var/spool/cron/root
service crond reload
