#!/bin/bash
if [[ "$(uname)" != "Linux" ]]; then
    echo "Sorry, this is only for Linux."
    exit 1
fi


get_system_info() {
    echo -e "\e[1m\e[32mSystem Information:\e[0m"
    echo -e "-------------------"
    echo -e "\e[32mHostname:\e[0m $(hostname)"
    echo -e "\e[32mKernel version:\e[0m $(uname -r)"
    echo -e "\e[32mDistribution:\e[0m $(lsb_release -ds)"
    echo -e "\e[32mUptime:\e[0m $(uptime -p)"
    echo -e "\e[32mCPU:\e[0m $(grep 'model name' /proc/cpuinfo | head -n1 | awk -F: '{print $2}' | sed 's/^[ \t]*//')"
    echo -e "\e[32mMemory Usage:\e[0m $(free -h | awk '/^Mem/ {print $3 "/" $2}')"
    echo -e "\e[32mDisk Usage:\e[0m $(df -h / | awk '/\// {print $5}')"
    echo -e "\e[32mGPU:\e[0m $(lspci | grep -i 'VGA\|3D' | awk -F: '{print $3}' | sed 's/^[ \t]*//')"
    echo -e "-------------------"
}


get_network_info() {
    echo -e "\e[1m\e[32mNetwork Information:\e[0m"
    echo -e "-------------------"
    echo -e "\e[32mIP Address:\e[0m $(hostname -I)"
    echo -e "\e[32mMAC Address:\e[0m $(ip link show | awk '/ether/ {print $2}')"
    echo -e "\e[32mGateway:\e[0m $(ip route | awk '/default/ {print $3}')"
    echo -e "\e[32mDNS Servers:\e[0m $(cat /etc/resolv.conf | awk '/^nameserver/ {print $2}')"
    echo -e "-------------------"
}


get_storage_info() {
    echo -e "\e[1m\e[32mStorage Information:\e[0m"
    echo -e "-------------------"
    echo -e "\e[32mTotal Storage:\e[0m $(df -h --total | awk '/total/ {print $2}')"
    echo -e "\e[32mUsed Storage:\e[0m $(df -h --total | awk '/total/ {print $3}')"
    echo -e "\e[32mAvailable Storage:\e[0m $(df -h --total | awk '/total/ {print $4}')"
    echo -e "-------------------"
}


get_user_info() {
    echo -e "\e[1m\e[32mUser Information:\e[0m"
    echo -e "-------------------"
    echo -e "\e[32mCurrent user:\e[0m $(whoami)"
    echo -e "\e[32mHome Directory:\e[0m $HOME"
    echo -e "\e[32mUser ID:\e[0m $(id -u)"
    echo -e "\e[32mGroup ID:\e[0m $(id -g)"
    echo -e "\e[32mShell:\e[0m $(basename $SHELL)"
    echo -e "\e[32mTTY:\e[0m $(tty)"
    echo -e "-------------------"
}

main() {
    get_system_info
    get_network_info
    get_storage_info
    get_user_info
}

main

