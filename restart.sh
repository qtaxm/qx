#!/bin/bash

# 日志文件路径
LOG_FILE="/root/aios-cli.log"

# 主菜单函数
function main_menu() {
    while true; do
        clear
        echo "==================== 主菜单 ===================="
        echo "1. 重启节点"
        echo "2. 查看日志"
        echo "3. 查询积分"
        echo "4. 退出脚本"
        echo "==============================================="
        read -p "请输入选择 (1/2/3/4): " choice

        case $choice in
            1) restart_node ;;
            2) view_logs ;;
            3) check_points ;;
            4) exit_script ;;
            *) echo "无效选择，请重新输入！"; sleep 2 ;;
        esac
    done
}

# 重启节点
function restart_node() {
    echo "正在停止当前节点..."
    aios-cli kill
    sleep 2
    echo "正在启动新节点..."
    aios-cli start --connect >> "$LOG_FILE" 2>&1 &
    sleep 2
    echo "节点已重启。"
    read -n 1 -s -r -p "按任意键返回主菜单..."
}

# 查看日志
function view_logs() {
    echo "显示日志的最后 100 行:"
    tail -n 100 "$LOG_FILE"
    read -n 1 -s -r -p "按任意键返回主菜单..."
}

# 查询积分
function check_points() {
    echo "当前积分:"
    aios-cli hive points
    read -n 1 -s -r -p "按任意键返回主菜单..."
}

# 退出脚本
function exit_script() {
    echo "退出脚本..."
    exit 0
}

# 调用主菜单函数
main_menu
