# Claude code 使用AgentRouter

function alaude
    # 检查必要的环境变量是否已设置
    if not set -q ANTHROPIC_BASE_URL_AgentRouter
        echo "错误: ANTHROPIC_BASE_URL_AgentRouter 未设置"
        return 1
    end
    
    set -gx ANTHROPIC_BASE_URL $ANTHROPIC_BASE_URL_AgentRouter
    set -gx ANTHROPIC_API_KEY $ANTHROPIC_API_KEY_AgentRouter
    set -gx ANTHROPIC_AUTH_TOKEN $ANTHROPIC_AUTH_TOKEN_AgentRouter
    # set -gx ANTHROPIC_SMALL_FAST_MODEL $ANTHROPIC_SMALL_FAST_MODEL_AgentRouter
    # set -gx ANTHROPIC_MODEL $ANTHROPIC_MODEL_AgentRouter
    claude $argv
end
