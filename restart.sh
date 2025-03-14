#!/bin/bash

# 检查并安装 screen
function check_and_install_screen() {
    if ! command -v screen &> /dev/null; then
        echo "screen 未安装，正在安装..."
        apt update && apt install -y screen
    else
        echo "screen 已安装。"
    fi
}

# 列出所有 screen 会话
function list_sessions() {
    echo "当前存在的 screen 会话:"
    screen -ls
}

# 选择并进入指定的 screen 会话
function select_session() {
    read -p "请输入要进入的会话名称: " session_name
    if screen -ls | grep -q "$session_name"; then
        echo "正在连接到 '$session_name' 会话..."
        screen -r "$session_name"
    else
        echo "会话 '$session_name' 不存在。"
    fi
}

# 在指定的 screen 会话中重启服务
function restart_in_session() {
    read -p "请输入要操作的会话名称: " session_name
    if screen -ls | grep -q "$session_name"; then
        echo "在会话 '$session_name' 中重启服务..."
        screen -S "$session_name" -X stuff "aios-cli kill\n"
        sleep 2
        screen -S "$session_name" -X stuff "aios-cli start --connect >> /root/aios-cli.log 2>&1\n"
        echo "服务已重启。"
    else
        echo "会话 '$session_name' 不存在。"
    fi
}

# 主菜单函数
function main_menu() {
    check_and_install_screen
    while true; do
        clear
        echo "请选择要执行的操作:"
        echo "1. 列出所有会话"
        echo "2. 进入指定会话"
        echo "3. 在指定会话中重启服务"
        echo "4. 退出脚本"
        read -p "请输入选择 (1/2/3/4): " choice
        case $choice in
            1) list_sessions ;;
            2) select_session ;;
            3) restart_in_session ;;
            4) exit 0 ;;
            *) echo "无效选择，请重新输入！"; sleep 2 ;;
        esac
    done
}

# 调用主菜单函数
main_menu
