# See Also: https://zenn.dev/kyoh86/articles/291618538dcf0d
function gobin-update
    set -l gobin (go env GOBIN)
    if test -z "$gobin"
        set gobin (go env GOPATH)/bin
    end

    set -l currentVersion "$(go version | awk '{print $3}')"
    echo "[INFO] current golang version is $currentVersion"
    echo "[INFO] checking build version..."

    for fname in "$gobin"/*
        set -l pkg (go version -m "$fname" 2> /dev/null | grep path  | head -n1 | awk '{print $2}')
        set -l binVersion (go version -m "$fname" 2> /dev/null | head -n1 | awk '{print $2}')
        set -l binName (basename $fname)

        if test -z "$binVersion"
            echo "[INFO] $binName is not a go binary"
            continue
        end

        if test -n "$pkg" && test "$currentVersion" != "$binVersion"
            echo "[INFO] rebuild $binName from $binVersion to $currentVersion."
            echo "[INFO] go install $pkg@latest"
            go install "$pkg@latest"
        else
            echo "[INFO] $binName is up to date."
        end
    end

    echo "[INFO] finished."
end
