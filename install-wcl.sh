#!/usr/bin/bash
if [[ "$EUID" -ne 0 ]]; then
    echo "必須以 root 權限執行，正在嘗試 sudo 執行..."
    sudo "$0" "$@"
fi

setting_language() {
    printf "\033[1;33mPlease choose your language:\033[0m\n"
    printf "\033[1;32m1\033[0m. English\n"
    printf "\033[1;32m2\033[0m. 中文\n"
    read -r -p "Enter your choice (1/2): " lang_choice
    if [[ $lang_choice == "1" ]]; then # 選擇英文
        echo "y"
    elif [[ $lang_choice == "2" ]]; then # 選擇中文
        echo "y"
    else # 都不選
        echo "Invalid choice, defaulting to English. You can use the command \"wcl -lang\" to change language"
        echo "y"
    fi
}

copy_file() { # 函數 用來複製檔案
    mkdir -p /opt/wcl
    cp ./wcl /usr/bin
    cp ./wcl-help-en /opt/wcl
    cp ./wcl-help-cn /opt/wcl
    cp ./color /opt/wcl
    cp ./setting-help-language /opt/wcl
}

if [ -f /usr/bin/wcl ]; then # 檢查目錄是否存在
    echo "你的系統已經安裝了WCL是否要覆蓋？(y/n)"
    read -r choice
    if [[ $choice == "y" || $choice == "Y" ]]; then
        rm -rf /opt/wcl
        rm -f /usr/bin/wcl
        copy_file
        echo "WCL安裝完成"
        setting_language
    else
        echo "Stop Installation."
    fi
else
    copy_file
    echo "WCL安裝完成"
    setting_language
fi
