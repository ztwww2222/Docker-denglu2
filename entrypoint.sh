#!/bin/bash

cd /app/

NEZHA_KEY=${NEZHA_KEY:-'shuoming15487887'}
  echo "======================启动 NeZha======================"
if [[ -n "${NEZHA_SERVER}" && -n "${NEZHA_KEY}" ]]; then
NEZHA_PORT=${NEZHA_PORT:-'443'}
NEZHA_TLS=${NEZHA_TLS:-'1'}
[ "${NEZHA_TLS}" = "1" ] && TLS='--tls'

nohup ./web/nez -s ${NEZHA_SERVER}:${NEZHA_PORT} -p ${NEZHA_KEY} ${TLS}  >/dev/null 2>&1 &

fi


# 启动 nginx

  echo "======================启动 nginx======================"
  echo ""
  echo "详细使用说明查看 ： ${SPACE_HOST}/shuoming"
  echo ""


nohup nginx -c /app/nginx.conf -g 'daemon off;' >/dev/null 2>&1 &

     if [[ -n "${SEC_TION}" ]]; then
  echo "======================开始section保活!===================="
      python3 ./section.py
     fi
     if [[ -n "${KOY_EB}" ]]; then
  echo "======================开始KOYEB保活!===================="
      python3 ./koyeb.py
     fi
     if [[ -n "${ST_URL}" ]]; then
  echo "======================开始streamlit保活!===================="
      python3 ./streamlit.py
     fi

  echo "======================全部账号登陆保活结束，你的小鸡鸡长度+1!===================="
#tail -f /dev/null
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."

#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
