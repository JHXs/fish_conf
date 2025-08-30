# SPDX-FileCopyrightText: 2023 - 2025 UnionTech Software Technology Co., Ltd.
# SPDX-License-Identifier: LGPL-3.0-or-later

# ll-cli  fish completion

# ----------- 工具函数 -----------
function __ll_cli_container_list
    ll-cli ps | tail -n +2 | awk '{print $1}'
end

function __ll_cli_installed_app_list
    ll-cli list --type=app | tail -n +2 | awk '{print $1}'
end

function __ll_cli_installed_list
    ll-cli list | tail -n +2 | awk '{print $1}'
end

function __ll_cli_app_list --argument search
    ll-cli search $search | tail -n +2 | awk '{print $1}' | sort -u
end

function __ll_cli_layer_list --argument dir
    ls $dir*.layer 2>/dev/null
end

function __ll_cli_repo_alias_list
    ll-cli repo show | tail -n +3 | awk '{print $3}'
end

# ----------- 补全定义 -----------
# 全局选项
set -l common_opts -h --help --help-all
set -l global_opts --version --json
set -l subcmds run ps enter kill prune install uninstall upgrade list info content search repo

# 顶层（子命令 + 全局选项）
complete -c ll-cli -n '__fish_use_subcommand' -a "$subcmds $global_opts"

# 子命令级别的补全
# run
complete -c ll-cli -n '__fish_seen_subcommand_from run' -s f -l file -d '指定 layer/uab 文件'
complete -c ll-cli -n '__fish_seen_subcommand_from run' -l url -d '从 url 安装并运行'
complete -c ll-cli -n '__fish_seen_subcommand_from run' -f -a '(__ll_cli_installed_app_list)'

# enter
complete -c ll-cli -n '__fish_seen_subcommand_from enter' -l working-directory -d '进入容器的工作目录'
complete -c ll-cli -n '__fish_seen_subcommand_from enter' -f -a '(__ll_cli_container_list)'

# kill
complete -c ll-cli -n '__fish_seen_subcommand_from kill' -f -a '(__ll_cli_container_list)'

# prune（无额外参数）

# install
complete -c ll-cli -n '__fish_seen_subcommand_from install' -l module -d '指定模块'
complete -c ll-cli -n '__fish_seen_subcommand_from install' -l force -d '强制安装'
complete -c ll-cli -n '__fish_seen_subcommand_from install' -s y -d '自动确认'
# 如果以 ./ 开头，只补全本地 .layer/.uab 文件
complete -c ll-cli -n '__fish_seen_subcommand_from install; and string match -q "./*" (commandline -ct)' \
         -f -r -a '(__fish_complete_suffix .layer)' -d '本地 layer 文件'
complete -c ll-cli -n '__fish_seen_subcommand_from install; and string match -q "./*" (commandline -ct)' \
         -f -r -a '(__fish_complete_suffix .uab)'  -d '本地 uab 文件'
# 否则补全远端应用
complete -c ll-cli -n '__fish_seen_subcommand_from install' -f -a '(__ll_cli_app_list (commandline -ct))'

# uninstall
complete -c ll-cli -n '__fish_seen_subcommand_from uninstall' -f -a '(__ll_cli_installed_app_list)'

# upgrade
complete -c ll-cli -n '__fish_seen_subcommand_from upgrade' -f -a '(__ll_cli_installed_list)'

# list
complete -c ll-cli -n '__fish_seen_subcommand_from list' -l type -d '指定类型'
complete -c ll-cli -n '__fish_seen_subcommand_from list' -l upgradable -d '只列出可升级项'

# info
complete -c ll-cli -n '__fish_seen_subcommand_from info' -f -a '(__ll_cli_installed_list)'
complete -c ll-cli -n '__fish_seen_subcommand_from info' -f -a '(__ll_cli_layer_list (commandline -ct))'

# content
complete -c ll-cli -n '__fish_seen_subcommand_from content' -f -a '(__ll_cli_installed_app_list)'

# search
complete -c ll-cli -n '__fish_seen_subcommand_from search' -l type -d '指定类型'
complete -c ll-cli -n '__fish_seen_subcommand_from search' -l dev -d '搜索开发包'
complete -c ll-cli -n '__fish_seen_subcommand_from search' -f -a '(__ll_cli_app_list (commandline -ct))'

# repo 子命令
complete -c ll-cli -n '__fish_seen_subcommand_from repo' -a 'add remove update set-default show'
complete -c ll-cli -n '__fish_seen_subcommand_from repo; and __fish_seen_subcommand_from remove set-default' \
         -f -a '(__ll_cli_repo_alias_list)'
