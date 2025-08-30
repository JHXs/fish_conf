# Claude code
function glaude
    # 检查必要的环境变量是否已设置
    if not set -q ANTHROPIC_BASE_URL_GLM
        echo "错误: ANTHROPIC_BASE_URL_GLM 未设置"
        return 1
    end

    set -gx ANTHROPIC_BASE_URL $ANTHROPIC_BASE_URL_GLM
    set -gx ANTHROPIC_API_KEY $ANTHROPIC_API_KEY_GLM
    set -gx ANTHROPIC_SMALL_FAST_MODEL $ANTHROPIC_SMALL_FAST_MODEL_GLM
    set -gx ANTHROPIC_MODEL $ANTHROPIC_MODEL_GLM
    claude $argv
end

function klaude
    # 检查必要的环境变量是否已设置
    if not set -q ANTHROPIC_BASE_URL_KIMI
        echo "错误: ANTHROPIC_BASE_URL_KIMI 未设置"
        return 1
    end
    
    set -gx ANTHROPIC_BASE_URL $ANTHROPIC_BASE_URL_KIMI
    set -gx ANTHROPIC_API_KEY $ANTHROPIC_API_KEY_KIMI
    set -gx ANTHROPIC_SMALL_FAST_MODEL $ANTHROPIC_SMALL_FAST_MODEL_KIMI
    set -gx ANTHROPIC_MODEL $ANTHROPIC_MODEL_KIMI
    claude $argv
end
