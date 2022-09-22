function __peco_history
  commandline | read -l buffer
  history | tail -r  | awk '!a[$0]++' | peco --query "$buffer" | read -l cmd
  if test -n "$cmd"
    commandline "$cmd"
  end
  commandline -f repaint
end
