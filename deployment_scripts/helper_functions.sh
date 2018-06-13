#!/bin/bash
function restartServer {
    systemctl restart lighttpd
}

function startServer {
    systemctl start lighttpd
}

function enableServer {
    systemctl enable lighttpd
}

function stopServer {
    systemctl stop lighttpd
}

function checkServerLog {
    sudo cat /var/log/lighttpd/error.log
}

function checkServerStatus {
    systemctl status lighttpd
}


