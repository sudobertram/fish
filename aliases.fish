# Aliases
alias source_fish_conf 'source ~/.config/fish/config.fish' 
alias edit_fish_conf 'nvim ~/.config/fish/config.fish'

abbr enc 'file -i'

# Basic
abbr .. "cd .."
abbr ... "cd ../.."
abbr downloads 'cd ~/Downloads'
abbr documents 'cd ~/Documents'
abbr desktop 'cd ~/Desktop'
abbr office 'cd ~/Office'
abbr db 'cd ~/Office/db'
abbr cdb 'cd ~/Office/cdb'
abbr temp 'cd ~/Temp'
abbr sd 'pwd > ~/.savedir'
abbr jd 'cd "$(cat ~/.savedir)"'
abbr rm 'trash'

alias la "ls -Gla"
alias ld 'ls -l | grep "^d"'
alias ll 'ls -ahlF'
if type -q exa
    alias l exa
    alias la 'exa --long --all --group --header --binary --links --inode --blocks  --group-directories-first'
    alias ld 'exa --long --all --group --header --list-dirs'
    alias ll 'exa --long --all --group --header --git'
    alias lt='exa --long --all --group --header --tree --level --color=always'
    alias l. 'exa --all | grep -E "^\."'
    alias tree 'exa -aT --icons --color=always --group-directories-first'
end

if type -q bat
    alias cat 'bat --paging=never'
end

# Text file operations
abbr h 'head'
abbr hn 'head -n'
abbr t 'tail'
abbr wcl 'wc --lines'

# editor
alias vim nvim
alias vs 'code .'

# Python Virtual Environment
abbr venv 'python -m venv .venv'
abbr venv-activate 'source .venv/bin/activate.fish'
abbr req 'pip freeze > requirements.txt'
abbr reqlist 'cat requirements.txt'

# Django
abbr djstart 'django-admin startproject'
abbr djapp 'python manage.py startapp'
abbr makemigrations 'python managu.py makemigrations'
abbr migrate 'python manage.py migrate'
abbr run 'python manage.py runserver'
abbr djsuser 'python manage.py createsuperuser'
abbr collectstatic 'python manage.py collectstatic'

# GIT
abbr gi 'git init'
abbr gs 'git status'
abbr ga 'git add'
abbr gign 'touch .gitignore' 
abbr gaa 'git add --all'
abbr gd 'git diff'
abbr gco 'git checkout'
abbr gl 'git log --oneline'
abbr gcm 'git commit --message='
abbr gpush 'git push'
abbr gpushmaster 'git push --set-upstream origin main'
abbr gpull 'git pull'
abbr git_commands 'cat ~/.config/fish/config.fish | grep git | grep -v "#"'

# System Information
abbr df 'df --human-readable --si -k --total'
abbr free 'free --giga --human --total'

# Miscellaneous
abbr c 'clear'
abbr q 'exit'

# Office
alias vc 'vcard --zip'
abbr ddoc 'rm ~/Downloads/document*.pdf'
abbr ddil 'rm ~/Downloads/7*.wav'
