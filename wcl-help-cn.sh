#!/bin/bash
wall-help-cn() {
  echo -e "${BLUE}#####${RED}This is the wall color tool help documentation${BLUE}#####${NC}"
  echo -e "
用法：
  ${BLUE}➜${NC} ${YELLOW}wall -[color] \"Text\"${NC}

描述:
  輸出一行居中且帶有背景的文本。
  非常適合腳本、警告或狀態顯示。

支援的顏色：
  \033[103m  ${NC}-yellow
  ${COL_pink}  ${NC}-pink
  ${COL_gray}  ${NC}-gray
  ${COL_red}  ${NC}-red
  ${COL_green}  ${NC}-green
  ${COL_blue}  ${NC}-blue
  ${COL_purple}  ${NC}-purple
  ${COL_cyan}  ${NC}-cyan

進階用法：
  若要更改字體顏色或粗體，
  在指令前加上 [${YELLOW}echo -n${NC}] 和被定義的函數變量名。

  用法：
  ${BLUE}➜${NC} ${YELLOW}echo -n "\${color}";wall -[color] \"Text\";echo -n \"\${NoColor}\"

Author:
  ${BLUE}Clyde Cole${NC}

Version:
  1.0

Status:
  Actively adding new features. Stay tuned!
"
}
