# SPDX-FileCopyrightText: 2023 - 2025 UnionTech Software Technology Co., Ltd.
# SPDX-License-Identifier: LGPL-3.0-or-later

# ll-builder fish completion

# ----------- 工具函数 -----------
function __ll_builder_layer_list
    ls *.layer 2>/dev/null
end

function __ll_builder_repo_name_list
    ll-builder repo show | tail -n +3 | awk '{print $1}'
end

# ----------- 补全定义 -----------
# 通用选项
set -l common_opts -h --help --help-all

# 子命令
set -l subcmds create build run export push import extract repo migrate

# 顶层
complete -c ll-builder -n '__fish_use_subcommand' -a "$subcmds $common_opts"

# create（无额外参数）

# build
set -l build_opts \
    --file -f \
    --arch -a \
    --exec -e \
    --offline \
    --full-develop-module \
    --skip-fetch-source \
    --skip-pull-depend \
    --skip-run-container \
    --skip-commit-output \
    --skip-output-check \
    --skip-strip-symbols
complete -c ll-builder -n '__fish_seen_subcommand_from build' -a "$build_opts"

# run
set -l run_opts --file --url
complete -c ll-builder -n '__fish_seen_subcommand_from run' -a "$run_opts"

# export
set -l export_opts --file --icon --layer --loader --no-develop
complete -c ll-builder -n '__fish_seen_subcommand_from export' -a "$export_opts"

# push
set -l push_opts --file --repo-url --repo-name --channel --module
complete -c ll-builder -n '__fish_seen_subcommand_from push' -a "$push_opts"

# import / extract：按本地 *.layer 文件补全
complete -c ll-builder -n '__fish_seen_subcommand_from import' -f -r -a '(__ll_builder_layer_list)'
complete -c ll-builder -n '__fish_seen_subcommand_from extract' -f -r -a '(__ll_builder_layer_list)'

# repo 子命令
complete -c ll-builder -n '__fish_seen_subcommand_from repo' -a 'add remove update set-default show'
complete -c ll-builder -n '__fish_seen_subcommand_from repo; and __fish_seen_subcommand_from remove set-default' \
         -f -a '(__ll_builder_repo_name_list)'

# migrate（无额外参数）
