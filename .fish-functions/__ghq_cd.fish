function __ghq_cd
    commandline | read -l buffer
    ghq list --full-path | peco --query "$buffer" | read -l next_path
    if test -n "$next_path"
        commandline "cd $next_path"
        commandline -f execute
    end
    commandline -f repaint
end
