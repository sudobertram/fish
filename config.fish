# Fish Shell Configuration

# Interactive Mode Configuration
if status is-interactive
    set -g fish_greeting
end

# Language Default
set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

# Prepare Shell Env
set -x PATH "$HOME/bin" $PATH
set -x PATH "$PWD/bin" $PATH

set -x EDITOR nvim

# user configs
source "$HOME/.config/fish/aliases.fish"
source "$HOME/.config/fish/functions.fish"
source "$HOME/.config/fish/utils.fish"

