abbr myip 'curl ipinfo.io'

# Basic
function sudo!!
    eval sudo $history[1]
end


function md --wraps mkdir -d "Create a directory and cd into it"
  command mkdir -p $argv
  if test $status = 0
    switch $argv[(count $argv)]
      case '-*'
      case '*'
        cd $argv[(count $argv)]
        return
    end
  end
end


function cd --description "auto ls for each cd"
    if [ -n $argv[1] ]
        builtin cd $argv[1]
        and ls -AF
    else
        builtin cd ~
        and ls -AF
    end
end


function extract --description "Expand or extract bundled & compressed files"
    set --local ext (echo $argv[1] | awk -F. '{print $NF}')
    switch $ext
        case tar # non-compressed, just bundled
            tar -xvf $argv[1]
        case gz
            if test (echo $argv[1] | awk -F. '{print $(NF-1)}') = tar # tar bundle compressed with gzip
                tar -zxvf $argv[1]
            else # single gzip
                gunzip $argv[1]
            end
        case tgz # same as tar.gz
            tar -zxvf $argv[1]
        case bz2 # tar compressed with bzip2
            tar -jxvf $argv[1]
        case rar
            unrar x $argv[1]
        case zip
            unzip $argv[1]
        case '*'
            echo "unknown extension"
    end
end


function beep --description "make two beeps"
  echo -e '\a'; sleep 0.1; echo -e '\a';
end

