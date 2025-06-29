#!/usr/bin/bash
. /opt/wcl/wcl-help-en.sh
. /opt/wcl/wcl-help-cn.sh
############### color ###############
COL_yellow='\033[103m'
COL_pink='\033[48;2;255;105;180m'
COL_gray='\033[48;5;242m'
COL_red='\033[48;5;196m'
COL_green='\033[48;5;34m'
COL_blue='\033[48;5;27m'
COL_purple='\033[48;5;129m'
COL_cyan='\033[48;5;51m'

RED='\033[38;2;255;0;0m'
PINK='\033[38;2;255;105;180m'
ORG='\033[1;31m'
YELLOW='\033[1;33m'
BLUE='\033[38;5;117m'
NC='\033[0m'
############### color ###############


# 此處有bug 每次運行的時候都是一個新的會話，不是全局變量，所以無法儲存是否設定語言的信息，
# 這裏也許可以更改為運行install.sh 的時候來選擇語言，然後保留一個，用戶的語言/直到用戶輸入 wcl -language 來修改語言
###############Language sitting###############
setting() {
    if [[ "$language" = "wcl-help-en" || "$language" = "wcl-help-cn" ]]; then
        : # 已設定語言，跳過
    else
        while true; do # 循環直至正確
            wcl -pink "Enter your language"
            echo -e -n "${YELLOW}"
            wcl -gray "1➜ English"
            echo -e -n "${YELLOW}"
            wcl -gray "2➜ Chinese"
            echo "${YELLOW}Choose (1/2): ${BLUE}"
            read -r LanguageChoice
            echo -e "${NC}"
            if [ "$LanguageChoice" = "1" ]; then
                language="wcl-help-en"
                break
            elif [ "$LanguageChoice" = "2" ]; then
                language="wcl-help-cn"
                break
            else
                clear
                wcl -red "Invalid choice! Please enter 1 or 2."
            fi
        done
    fi
}
############### Language sitting ###############

############### Main of Wall Color ####################
wcl() {
    if [ $# -lt 2 ] || [ "$(echo -e "$1" | cut -c 1)" != "-" ]; then
        if [ -z "${language:-}" ]; then
            setting # L 未定义或为空
            ${language}
        else
            ${language} # L 已定义且非空
        fi
        return 1
    fi

    # 解析參數
    color_option=$(echo -e "$1" | cut -c 2-) # 去掉前面的短橫線
    text="$2"

    # 檢查顏色是否存在
    bg_var="COL_${color_option}"
    eval "BG=\$$bg_var"
    if [ -z "$BG" ]; then
        if [ -z "${language:-}" ]; then
            setting
            ${language}
        else
            ${language}
        fi
        return 1
    fi
    ########################################
    calculate_width() {
        if command -v wc >/dev/null 2>&1 && [ "$(
            wc -L <<EOF
$text
EOF
        )" -gt 0 ] 2>/dev/null; then
            wc -L <<EOF
$text
EOF
            return
        fi

        echo -e "$text" | awk '{
        width = 0;
        for (i=1; i<=length; i++) {
            c = substr($0, i, 1);
            if (c ~ /[[:print:]]/) {  # 可打印ASCII字符
                width += 1;
                } else {
                width += 2;
            }
        }
        print width;
    }'
    }

    get_term_width() {
        stty size 2>/dev/null | awk '{print $2}' || echo -e 80
    }

    term_width=$(get_term_width)
    text_width=$(calculate_width "$text")

    left_pad=$(((term_width - text_width) / 2))
    [ $left_pad -lt 0 ] && left_pad=0
    right_pad=$((term_width - text_width - left_pad))
    [ $right_pad -lt 0 ] && right_pad=0

    left_fill=$(printf "%${left_pad}s" "")
    right_fill=$(printf "%${right_pad}s" "")

    # 输出
    printf "%b%s%b\n" "${BG}" "${left_fill}${text}${right_fill}" "${NC}"
}
############### Main of Wall Color ####################
wcl "$@"
wcl -red "Konichiwa"
