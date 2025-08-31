# ll-cli.fish - fish completion for ll-cli
# SPDX-FileCopyrightText: 2023 - 2025 UnionTech Software Technology Co., Ltd.
# SPDX-License-Identifier: LGPL-3.0-or-later

function __ll_cli_get_container_list
    ll-cli ps | tail -n +2 | awk '{print $1}'
end

function __ll_cli_get_installed_app_list
    ll-cli list --type=app | tail -n +2 | awk '{print $1}'
end

function __ll_cli_get_installed_list
    ll-cli list | tail -n +2 | awk '{print $1}'
end

function __ll_cli_get_app_list --argument-names q
    ll-cli search $q | tail -n +2 | awk '{print $1}' | sort | uniq
end

function __ll_cli_get_layer_list --argument-names prefix
    ls $prefix*.layer 2>/dev/null
end

function __ll_cli_get_repo_alias_list
    ll-cli repo show | tail -n +3 | awk '{print $3}'
end

# Global options
set -l common_opts -h --help --help-all
set -l global_opts --version --json
set -l subcommands run ps enter kill prune install uninstall upgrade list info content search repo

# Top-level completion
complete -c ll-cli -n "not __fish_seen_subcommand_from $subcommands" -a "$common_opts $global_opts $subcommands"

# ---- Subcommands ----

# run
complete -c ll-cli -n "__fish_seen_subcommand_from run" -a "(__ll_cli_get_installed_app_list)" -d "Installed apps"
complete -c ll-cli -n "__fish_seen_subcommand_from run" -l file -d "Run from file"
complete -c ll-cli -n "__fish_seen_subcommand_from run" -l url -d "Run from URL"

# ps (no extra options)

# enter
complete -c ll-cli -n "__fish_seen_subcommand_from enter" -a "(__ll_cli_get_container_list)" -d "Running containers"
complete -c ll-cli -n "__fish_seen_subcommand_from enter" -l working-directory -d "Set working directory"

# kill
complete -c ll-cli -n "__fish_seen_subcommand_from kill" -a "(__ll_cli_get_container_list)" -d "Running containers"

# prune (no extra options)

# install
complete -c ll-cli -n "__fish_seen_subcommand_from install" -l module -d "Install module"
complete -c ll-cli -n "__fish_seen_subcommand_from install" -l force -d "Force install"
complete -c ll-cli -n "__fish_seen_subcommand_from install" -s y -d "Assume yes"
# 本地文件（.layer/.uab）
complete -c ll-cli -n "__fish_seen_subcommand_from install" -a "(ls ./*.layer ./*.uab ^/dev/null)" -d "Local layer/uab files"
# 搜索应用
complete -c ll-cli -n "__fish_seen_subcommand_from install" -a "(__ll_cli_get_app_list (commandline -ct))" -d "Available apps"

# uninstall
complete -c ll-cli -n "__fish_seen_subcommand_from uninstall" -a "(__ll_cli_get_installed_app_list)" -d "Installed apps"

# upgrade
complete -c ll-cli -n "__fish_seen_subcommand_from upgrade" -a "(__ll_cli_get_installed_list)" -d "Installed packages"

# list
complete -c ll-cli -n "__fish_seen_subcommand_from list" -l type -d "Filter by type"
complete -c ll-cli -n "__fish_seen_subcommand_from list" -l upgradable -d "Show upgradable"

# info
complete -c ll-cli -n "__fish_seen_subcommand_from info" -a "(__ll_cli_get_installed_list)" -d "Installed packages"
complete -c ll-cli -n "__fish_seen_subcommand_from info" -a "(__ll_cli_get_layer_list (commandline -ct))" -d "Layer files"

# content
complete -c ll-cli -n "__fish_seen_subcommand_from content" -a "(__ll_cli_get_installed_app_list)" -d "Installed apps"

# search
complete -c ll-cli -n "__fish_seen_subcommand_from search" -l type -d "Filter by type"
complete -c ll-cli -n "__fish_seen_subcommand_from search" -l dev -d "Development packages"
complete -c ll-cli -n "__fish_seen_subcommand_from search" -a "(__ll_cli_get_app_list (commandline -ct))" -d "Available apps"

# repo
complete -c ll-cli -n "__fish_seen_subcommand_from repo" -a "add remove update set-default show"
complete -c ll-cli -n "__fish_seen_subcommand_from repo; and __fish_seen_subcommand_from remove" -a "(__ll_cli_get_repo_alias_list)" -d "Repo aliases"
complete -c ll-cli -n "__fish_seen_subcommand_from repo; and __fish_seen_subcommand_from set-default" -a "(__ll_cli_get_repo_alias_list)" -d "Repo aliases"
