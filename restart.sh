#!/bin/bash

# 设置屏幕会话名称
SCREEN_NAME="hyper"
LOG_FILE="/root/aios-cli.log"

# 检查并安装 aios-cli
function check_and_install_aios_cli() {
    if ! command -v aios-cli &>/dev/null; then
        echo "aios-cli 未安装，正在安装..."
        curl -sSL https://download.hyper.space/api/install | bash
        source /root/.bashrc
    else
        echo "aios-cli 已安装。"
    fi
}

# 重启节点
function restart_node() {
    echo "正在停止当前节点..."
    aios-cli kill
    sleep 2
    echo "正在启动新节点..."
    screen -S "$SCREEN_NAME" -X quit
    sleep 2
    screen -S "$SCREEN_NAME" -dm
    screen -S "$SCREEN_NAME" -X stuff "aios-cli start --connect >> $LOG_FILE 2>&1\n"
    echo "节点已重启。"
}

# 查看日志
function view_logs() {
    if [ -f "$LOG_FILE" ]; then
        echo "显示日志的最后 100 行:"
        tail -n 100 "$LOG_FILE"
    else
        echo "日志文件不存在: $LOG_FILE"
    fi
}

# 查询积分
function check_points() {
    aios-cli hive points
}

# 主菜单
function main_menu() {
    clear
    echo "====================================="
    echo "1. 重启节点"
    echo "2. 查看日志"
    echo "3. 查询积分"
    echo "4. 退出"
    echo "====================================="
    read -p "请输入选择 (1/2/3/4): " choice
    case $choice in
        1) restart_node ;;
        2) view_logs ;;
        3) check_points ;;
        4) exit 0 ;;
        *) echo "无效选择，请重新输入！"; sleep 2; main_menu ;;
    esac
}

# 检查并安装 aios-cli
check_and_install_aios_cli

# 显示主菜单
while true; do
    main_menu
done
