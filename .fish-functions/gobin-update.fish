# See Also: https://zenn.dev/kyoh86/articles/291618538dcf0d
function gobin-update
    set -f gobin "$(go env GOBIN)"
    set -f currentVersion "$(go version | awk '{print $3}')"
    echo "[INFO] current golang version is $currentVersion"
    echo "[INFO] check for build versions..."

    for fname in "$gobin"/*
        set -f temp "$(go version -m "$fname" 2> /dev/null)"
        set -f pkg "$(echo "$temp" | head -n2 | tail -n1 | awk '{print $2}')"
        set -f binVersion "$(echo "$temp" | head -n1 | awk '{print $2}')"
        set -f binName "$(basename $pkg)"

        if test -n "$pkg" && test "$currentVersion" != "$binVersion"
            echo "[INFO] rebuild $binName from $binVersion to $currentVersion."
            go install "$pkg@latest"
        else
            echo "[INFO] $binName is up to date."
        end
    end

    echo "[INFO] finished."
end
