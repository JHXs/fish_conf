# claude code 使用 GLM
function glaude
    # 检查必要的环境变量是否已设置
    if not set -q CC_BASE_URL_GLM
        echo "错误: CC_BASE_URL_GLM 未设置"
        return 1
    end

    # 清除可能存在的ANTHROPIC_环境变量
    for v in (set -n | grep ^ANTHROPIC_)
        set -e $v
    end

    set -gx ANTHROPIC_BASE_URL $CC_BASE_URL_GLM
    set -gx ANTHROPIC_API_KEY $CC_API_KEY_GLM
    set -gx ANTHROPIC_SMALL_FAST_MODEL $CC_SMALL_FAST_MODEL_GLM
    set -gx ANTHROPIC_MODEL $CC_MODEL_GLM
    claude $argv
end
