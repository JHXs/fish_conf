source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/miniforge/bin/conda
    eval /opt/miniforge/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/miniforge/etc/fish/conf.d/conda.fish"
        . "/opt/miniforge/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/miniforge/bin" $PATH
    end
end
# <<< conda initialize <<<
