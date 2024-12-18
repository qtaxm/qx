#!/bin/bash

while true
do
    echo "[$(date)] 启动 rivalz run..." >> rivalz_auto_restart.log
    rivalz run >> rivalz_auto_restart.log 2>&1
    EXIT_CODE=$?
    
    if [ $EXIT_CODE -eq 0 ]; then
        echo "[$(date)] rivalz run 正常退出。" >> rivalz_auto_restart.log
        break
    else
        echo "[$(date)] rivalz run 异常退出，错误码: $EXIT_CODE。重新启动中..." >> rivalz_auto_restart.log
    fi

    sleep 5  # 等待 5 秒后重试
done
