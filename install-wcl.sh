#!/usr/bin/bash
# if [[ "$EUID" -ne 0 ]]; then
#     echo "必須擁有管理員權限，正在嘗試 sudo 執行..."
#     sudo "$0" "$@"
# fi

# 後期將設定全局安裝和用戶安裝兩個選項

# 首次安裝時選擇語言
setting_language() {
    echo "cn" > ~/.local/share/wcl/language.conf
    printf "\033[1;33m 請選擇你的語言:\033[0m\n"
    printf "\033[1;32m1\033[0m. 正體中文\n"
    printf "\033[1;32m2\033[0m. English\n"
    read -r -p "輸入你的選擇 (1/2): " lang_choice

    if [[ $lang_choice == "1" ]]; then # 選擇中文
        echo "language=\"cn\"" > ~/.local/share/wcl/settings.conf
    elif [[ $lang_choice == "2" ]]; then # 選擇英文
        echo "language=\"en\"" > ~/.local/share/wcl/settings.conf
    else # 都不選
        echo "cn" > ~/.local/share/wcl/language.conf 
        echo "無效選擇, 預設爲繁體中文. 你可以使用命令 \"wcl -lang\" 來更改語言"
    fi
}

copy_file() { # 用來複製檔案的函數
    mkdir -p ~/.local/bin ~/.local/share/wcl

    cp -r ./help/ ./picture/ ./color ./functions ./settings.conf ~/.local/share/wcl
    cp ./wcl ~/.local/bin/
    chmod +x ~/.local/bin/wcl
}


if [ -f ~/.local/bin/wcl ]; then # 檢查目錄是否存在
    echo "你似乎已經安裝了WCL,是否繼續安裝?(y/N)" # 如果存在
    read -r choice
    if [[ $choice == "y" || $choice == "Y" ]]; then # 確認安裝
        rm ~/.local/bin/wcl
        rm -rf ~/.local/share/wcl
        copy_file
        echo "WCL安裝完成"
    else # 取消安裝
        echo "停止安裝"
        exit 0
    fi
else
    copy_file
    echo "WCL安裝完成"
fi

bash ~/.local/bin/wcl -gray "如果你沒有將~/.local/bin添加進你的.rc文檔內"
bash ~/.local/bin/wcl -gray "請在你的終端鍵入(注意, 將bashrc更換成你的run command文檔名稱):"
bash ~/.local/bin/wcl -gray "echo \'export PATH=\"\$HOME/.local/bin:\$PATH\"\' >> ~/.bashrc && source ~/.bashrc"
setting_language
