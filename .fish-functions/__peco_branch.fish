function __peco_branch
  commandline | read -l buffer
  git branch | peco --query "$buffer" | awk '{print $NF}' | read -l branch
  if test -n "$branch"
    commandline "git checkout $branch"
    commandline -f execute
  end
  commandline -f repaint
end
