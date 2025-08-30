# ~/.config/fish/completions/ufw.fish
# UFW completion for Fish Shell
# Converted from Bash completion script

function __fish_ufw_commands
    ufw --help | sed -e '1,/^Commands:/d' -e '/^Application profile commands:/Q' -e 's/^[ \t]\+\([a-z|]\+\)[ \t]\+.*/\1/g' -e 's/|/ /g' | uniq
    echo "app"
end

function __fish_ufw_app_commands
    ufw --help | sed -e '1,/^Application profile commands:/d' -e '/^ [^ ]/!d' -e 's/[ \t]\+app[ \t]\+\([a-z|]\+\)[ \t]\+.*/\1/g'
end

function __fish_ufw_logging_commands
    echo "off on low medium high full"
end

function __fish_ufw_default_commands
    echo "allow deny reject"
end

function __fish_ufw_rule_commands
    __fish_ufw_default_commands
    echo "limit"
end

function __fish_ufw_route_commands
    __fish_ufw_default_commands
    echo "limit delete insert"
end

function __fish_ufw_show_commands
    echo "raw"
end

function __fish_ufw_status_commands
    echo "numbered verbose"
end

# Main completion function
complete -c ufw -f

# Global options
complete -c ufw -n "__fish_is_first_token" -l dry-run -d "Dry run"
complete -c ufw -n "__fish_is_first_token" -l force -d "Force operation"
complete -c ufw -n "__fish_is_first_token" -l help -d "Show help"

# Main commands
complete -c ufw -n "__fish_is_first_token" -a "(__fish_ufw_commands)" -f

# App subcommands
complete -c ufw -n "__fish_seen_subcommand_from app; and __fish_is_nth_token 2" -a "(__fish_ufw_app_commands)" -f

# Status subcommands
complete -c ufw -n "__fish_seen_subcommand_from status; and __fish_is_nth_token 2" -a "(__fish_ufw_status_commands)" -f

# Delete subcommands
complete -c ufw -n "__fish_seen_subcommand_from delete; and __fish_is_nth_token 2" -a "(__fish_ufw_rule_commands)" -f

# Route subcommands
complete -c ufw -n "__fish_seen_subcommand_from route; and __fish_is_nth_token 2" -a "(__fish_ufw_route_commands)" -f

# Logging subcommands
complete -c ufw -n "__fish_seen_subcommand_from logging; and __fish_is_nth_token 2" -a "(__fish_ufw_logging_commands)" -f

# Show subcommands
complete -c ufw -n "__fish_seen_subcommand_from show; and __fish_is_nth_token 2" -a "(__fish_ufw_show_commands)" -f

# Default subcommands
complete -c ufw -n "__fish_seen_subcommand_from default; and __fish_is_nth_token 2" -a "(__fish_ufw_default_commands)" -f
