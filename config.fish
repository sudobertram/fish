if status is-interactive
    set -g fish_greeting
end

alias source_fish_conf 'source ~/.config/fish/config.fish' 
alias edit_fish_conf 'nvim ~/.config/fish/config.fish'
alias aliases 'cat ~/.config/fish/config.fish | grep alias | grep -v "#"'


# ---------------------------------------------------------------------
# NAVIGATION (CD)
# ---------------------------------------------------------------------
alias .. 'cd ..'
alias ... 'cd ../..'
alias .3 '../../..'
alias downloads 'cd ~/Downloads'
alias documents 'cd ~/Documents'
alias desktop 'cd ~/Desktop'


# ---------------------------------------------------------------------
# LISTING DIR (LS)
# ---------------------------------------------------------------------
alias ls='exa -al --icons --color=always --group-directories-first'
alias la='exa -a --icons --color=always --group-directories-first'
alias ll='exa -l --icons --color=always --group-directories-first'
alias lt='exa -aT --icons --color=always --group-directories-first'
alias l.='exa -a | grep -E "^\."'
alias tree='exa -aT --icons --color=always --group-directories-first'


# ---------------------------------------------------------------------
# DELETING FILES (RM)
# ---------------------------------------------------------------------
alias rm='trash'


# ---------------------------------------------------------------------
# READING FILES
# ---------------------------------------------------------------------
alias cat 'bat'
alias H 'head'
alias T 'tail'

alias vim 'nvim'
alias v 'nvim'
alias vs 'code .'


# ---------------------------------------------------------------------
# MEMORY
# ---------------------------------------------------------------------
alias df 'df -h'
alias free 'free -m'


# ---------------------------------------------------------------------
# GIT HUB
# ---------------------------------------------------------------------
alias gi 'git init'
alias gs 'git status'
alias ga 'git add'
alias gig 'touch .gitignore' 
alias ga 'git add'
alias gaa 'git add --all'
alias gd 'git diff'
alias gco 'git checkout'
alias gl 'git log --oneline'
alias gcm 'git commit -m'
alias gpush 'git push'
alias gpushmain 'git push -u origin main'
alias gpull 'git pull'
alias git_commands 'cat ~/.config/fish/config.fish | grep git | grep -v "#"'


# ---------------------------------------------------------------------
# PYTHON ENV
# ---------------------------------------------------------------------
alias venv 'python -m venv .venv'
alias venv-activate 'source .venv/bin/activate.fish'
alias req 'pip freeze > requirements.txt'
alias reqlist 'cat requirements.txt'


# ---------------------------------------------------------------------
# DJANGO 
# ---------------------------------------------------------------------
alias djstart 'django-admin startproject'
alias djapp 'python manage.py startapp'
alias makemigrations 'python managu.py makemigrations'
alias migrate 'python manage.py migrate'
alias run 'python manage.py runserver'
alias djsuser 'python manage.py createsuperuser'
alias collectstatic 'python manage.py collectstatic'


# ---------------------------------------------------------------------
# just some aliases
# ---------------------------------------------------------------------
alias tarcz 'tar -czvf'
alias tarxz 'tar -xzvf'

alias c 'clear'
alias s 'pwd > ~/.savedir'
alias j 'cd "$(cat ~/.savedir)"'
alias q 'exit'

alias wcl 'wc -l'
alias ddoc 'rm ~/Downloads/document*.pdf'
alias vc 'vcard --vcf_size 1000 --dir_to_save'

alias myip 'curl ipinfo.io'


# ---------------------------------------------------------------------
# EXTENSION (FUNCTIONS)
# ---------------------------------------------------------------------
function csv_to_txt
    for file in *.csv
        mv -- "$file" (basename "$file" .csv).txt
    end
end


function txt_to_csv
    for file in *.txt
        mv -- "$file" (basename "$file" .txt).csv
    end
end


function add_extension
    if test -z $argv[1]
        echo "Usage: add_extension <extension>"
        return 1
    end

    set ext $argv[1]

    for file in *
        if test -f $file
            set filename (basename $file)
            set extension (string match -r '\.\w+' $filename)
            if test -z $extension
                set new_filename $filename.$ext
                mv $file $new_filename
            end
        end
    end
end


# ---------------------------------------------------------------------
# ZIPZIP
# ---------------------------------------------------------------------
function zip_dir
    # Check if the correct number of arguments is provided
    if test (count $argv) -ne 1
        echo "Usage: zip_dir <directory>"
        return 1
    end

    set directory $argv[1]

    # Check if the specified directory exists
    if not test -d $directory
        echo "Error: Directory '$directory' not found."
        return 1
    end

    set zip_file $directory".zip"

    # Check if the zip file already exists
    if test -e $zip_file
        echo "Error: Zip file '$zip_file' already exists. Please choose a different name."
        return 1
    end

    # Create the zip file
    zip -rq $zip_file $directory

    # Check if the zip operation was successful
    if test $status -eq 0
        echo "Successfully zipped '$directory' to '$zip_file'."
    else
        echo "Error: Failed to zip '$directory'."
        return 1
    end
end


# ---------------------------------------------------------------------
# SPLIT FILE INTO CHANKS
# ---------------------------------------------------------------------
function split_parts
    # Check if the correct number of arguments is provided
    if test (count $argv) -lt 2
        echo "Usage: split_parts <number_of_parts> <file>"
        return 1
    end

    set parts $argv[1]

    # Check if the number of parts is a positive integer
    if not test $parts -gt 0 2>/dev/null
        echo "Error: Number of parts must be a positive integer."
        return 1
    end

    # Loop through the remaining arguments (files) and split each one
    for file in $argv[2..-1]
        # Check if the file exists
        if not test -e $file
            echo "Error: File '$file' not found."
            return 1
        end
        
        set prefix (basename $file '.csv')
        # Create the split files with the specified number of parts
        split -n l/$parts --additional-suffix=.csv $file $file-
    end

    echo "File $file successfully splitted into $parts parts"
end


function split_lines
    # Check if the correct number of arguments is provided
    if test (count $argv) -lt 2
        echo "Usage: split_lines <lines_per_file> <file>"
        return 1
    end

    set lines $argv[1]

    # Check if the number of lines is a positive integer
    if not test $lines -gt 0 2>/dev/null
        echo "Error: Number of lines must be a positive integer."
        return 1
    end

    # Loop through the remaining arguments (files) and split each one
    for file in $argv[2..-1]
        # Check if the file exists
        if not test -e $file
            echo "Error: File '$file' not found."
            return 1
        end
        
        # Extract the filename without extension for use as a prefix
        set prefix (basename $file '.csv')
        # Create the split files with the specified number of lines
        split -l $lines --additional-suffix=.csv $file $file-
    end

    echo "File $file successfully splitted in $lines lines per file"
end

