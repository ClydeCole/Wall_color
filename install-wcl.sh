#!/usr/bin/bash

copy_file(){ # copy 程式檔案目錄到bin 和 opt
    cp ./wall-color-tool.sh /usr/bin
    cp ./wcl-help-en.sh /opt/wcl
    cp ./wcl-help-cn.sh /opt/wcl
    mv ./usr/bin/wall-color-tool.sh ./usr/bin/wcl
}

if [[ -d /usr/bin/wall-color-tool.sh || -d /opt/wcl ]]; then # 檢索/usr/bin 和/opt/是否有wcl
    printf "\033[31mERROR ➜\033[0mYour /usr/bin/ or /opt/ have a \"wcl\" dir\n"
    read -r -p "do you want delete it (Y/N)" choice # 詢問是否保留
    if [[ $choice == "Y" || $choice == "y" ]]; then # 保留
        rm -rf /usr/bin/wcl # 如果有
        rm -rf /opt/wcl
        mkdir /opt/wcl
        copy_file
        printf "\033[1;32mInstallation\033[1;33m completed\033[0m\n"
    else # 不保留
        echo "Stop installation"
    fi
else
    mkdir /opt/wcl # 入果沒有直接直接安裝
    copy_file
    printf "\033[1;32mInstallation\033[1;33m completed\033[0m\n"
fi

#刪除當前目錄文件