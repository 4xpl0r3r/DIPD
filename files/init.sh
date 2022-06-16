#!/bin/bash
cp -r /tmp/init_files/* ~
mkdir ~/debug
cp -r /tmp/debug/* ~/debug/
cd ~
chmod +x ~/debug/*

apt install ./debs/`dpkg --print-architecture`/*.deb

cd debug
if [ -n "$flag_pos" ]
then
    echo 'flag{debug_success_flag}' > $flag_pos
fi

if [ `dpkg --print-architecture` = 'amd64' ]
then
    socat tcp-l:23458,fork exec:./$debug_name &
    ~/linux_server64
elif [ `dpkg --print-architecture` = 'i386' ]
then
    socat tcp-l:23458,fork exec:./$debug_name &
    ~/linux_server
else
    echo "[Error] Architecture `dpkg --print-architecture` haven't been supported\!"
fi

