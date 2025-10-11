# 用于设置命令别名。

# clash tun 开关
alias tun="curl http://127.0.0.1:8090/configs -X PATCH -H 'Authorization: Bearer ikunji' -d '{\"tun\": {\"enable\": true}}'"
alias tunno="curl http://127.0.0.1:8090/configs -X PATCH -H 'Authorization: Bearer ikunji' -d '{\"tun\": {\"enable\": false}}'"

alias daeon="sudo systemctl start dae"
alias daeno="sudo systemctl stop dae"

# 兼容yay
alias yay=paru

