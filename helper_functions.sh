#!/bin/bash
function restartJudge {
    systemctl restart lighttpd
}

function startJudge {
    systemctl start lighttpd
}

function stopJudge {
    systemctl stop lighttpd
}

function checkInginious {
    sudo cat /var/log/ligtthpd/error.log
}

function checkServer {
    systemctl status lighttpd
}


