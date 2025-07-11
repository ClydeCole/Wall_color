#!/bin/bash
wcl-help-en() {
  echo -e "${BLUE}#####${RED}This is the wall color tool help documentation${BLUE}#####${NC}"
  echo -e "
Usage:
  ${BLUE}➜${NC} ${YELLOW}wcl -[color] \"Text\"${NC}

Description:
  Outputs a centered line of text with a background.
  Perfect for scripts, warnings, or status displays.

Supported Colors:
  \033[103m  ${NC}-yellow
  ${COL_pink}  ${NC}-pink
  ${COL_gray}  ${NC}-gray
  ${COL_red}  ${NC}-red
  ${COL_green}  ${NC}-green
  ${COL_blue}  ${NC}-blue
  ${COL_purple}  ${NC}-purple
  ${COL_cyan}  ${NC}-cyan

Advanced Usage:
  To modify font color or boldness, prepend the command with 
  [${YELLOW}echo -n${NC}] and the defined function variable name.

Usage:
  ${BLUE}➜${NC} ${YELLOW}echo -n "\${color}";wcl -[color] \"Text\";echo -n \"\${NoColor}\"

Author:
  ${BLUE}Clyde Cole${NC}

Version:
  1.0

Status:
  Actively adding new features. Stay tuned!
"
}
