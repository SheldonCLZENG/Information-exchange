#!/bin/bash

login_user=$(who | grep -i -m 1 $1 | awk '{print $1}')

if [ -z $login_user ]
then
	echo "$1 不在线！"
	echo "脚本退出.."
	exit
fi

is_allowed=$(who -T | grep -i -m 1 $1 | awk '{print $2}')

if [ $is_allowed != "+" ]
then
	echo "$1 没有开启消息功能"
	echo "脚本退出.."
	exit
fi

if [ -z $2 ]
then
	echo "没有消息发出"
	echo "脚本退出.."
	exit
fi

whole_msg=$(echo $* | cut -d " " -f 2- )

user_terminal=$(who | grep -i -m 1 $1 | awk '{print $2}')

echo $whole_msg | write $login_user $user_terminal

if [ $? != 0 ]
then
	echo "发送失败！"
else
	echo "发送成功！"
fi

exit