#!/bin/bash

while true
do
    echo "[$(date)] 执行 rivalz run..." >> /root/rivalz_auto_restart.log

    # 执行 rivalz run 并记录输出和错误到日志
    /usr/bin/rivalz run >> /root/rivalz_auto_restart.log 2>&1
    EXIT_CODE=$?

    echo "[$(date)] rivalz run 执行完成，退出码: $EXIT_CODE" >> /root/rivalz_auto_restart.log

    # 检查退出状态码
    if [ $EXIT_CODE -eq 0 ]; then
        echo "[$(date)] rivalz run 正常退出。" >> /root/rivalz_auto_restart.log
        break
    else
        echo "[$(date)] rivalz run 异常退出，错误码: $EXIT_CODE。重新启动中..." >> /root/rivalz_auto_restart.log
    fi

    # 等待 5 秒后重试
    sleep 5
done
