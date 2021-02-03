#!/bin/bash
#Discord = depasty#7902

#You need to add below to crontab. after 7 days delete from cron
#38 12 * * * /home/concordium/Documents/concordium-software/T4.sh


#Below should be address not account name !!
receiver="4TbQUfAdKp6SHg42fhmfDm2fufW2ThNKDWfXxXrkFhMgmhna29"
#Below should be address not account name !!
sender="3eeDPX7PywZNzrMtxkQU3FTRE55Xt38gh89GmNq29oSP8bDNLG"
pass="323632\n"

cd /home/concordium/Documents/concordium-software

scheduleString=""
for i in {1..55}
do
	myDateString=`date -d $i' mins' +%Y-%m-%dT%H:%M:%SZ`
	scheduleString+="0.001 at $myDateString, "
done

scheduleString2=${scheduleString::-2}

echo "RUN "
/usr/bin/expect << EOF  >> t4-v2.log
set timeout -1
spawn ./concordium-client transaction send-gtu-scheduled --schedule "$scheduleString2" --receiver "$receiver" --sender "$sender" --no-confirm

expect "Enter password for signing key:"
send -- $pass
expect eof

EOF

echo "END"
