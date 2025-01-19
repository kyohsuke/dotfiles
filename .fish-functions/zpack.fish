function zpack -a dirName
    function _usage
        echo "[Usage] zpack <DirName>"
        exit 1
    end

    if command -vq zpaq
        if test "" = "$dirName"
            _usage
        end

        set -f baseName (basename $dirName)
        echo "$baseName"

        if test "." = "$baseName"
            _usage
        end

        zpaq a "$baseName.zpaq" "$baseName" -m5 -not "*/.DS_Store"
        return $status
    else
        echo "[Error] zpaq not installed"
        echo "[Info] if you installed homebrew, use `brew install zpaq`"
        exit 1
    end
end

