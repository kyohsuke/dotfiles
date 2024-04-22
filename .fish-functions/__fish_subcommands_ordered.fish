function __fish_subcommands_ordered
    set -l subs (string split " " "$argv")
    set -l argc (count $subs)
    set -l words (commandline -pco)
    set -l cword (count $words)

    if test $cword -lt 2
        return 1
    end

    if test (math -s 0 $argc + 1) -ne $cword
        return 1
    end

    for i in (seq 2 $cword)
        set -l j (math -s 0 $i - 1)
        if test "$subs[$j]" = "*"
            continue
        end

        if test "$words[$i]" != "$subs[$j]"
            return 1
        end
    end

    return 0
end
