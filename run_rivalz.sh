#!/bin/bash

# 无限循环，确保命令在退出后会自动重启
while true
do
    # 记录启动时间到日志
    echo "[$(date)] 启动 rivalz run..." >> rivalz_auto_restart.log

    # 执行 rivalz run 并记录输出和错误到日志
    rivalz run >> rivalz_auto_restart.log 2>&1
    EXIT_CODE=$?

    # 检查退出状态码
    if [ $EXIT_CODE -eq 0 ]; then
        echo "[$(date)] rivalz run 正常退出。" >> rivalz_auto_restart.log
        break
    else
        echo "[$(date)] rivalz run 异常退出，错误码: $EXIT_CODE。重新启动中..." >> rivalz_auto_restart.log
    fi

    # 等待 5 秒后重试
    sleep 5
done
