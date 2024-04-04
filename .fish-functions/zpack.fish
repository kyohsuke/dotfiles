function zpack -a dirName
    if command -v zpaq
        set -f baseName (basename $dirName)
        echo "$baseName"

        if test "." = "$baseName"
            echo "[Usage] zpack <DirName>"
            return 1
        end
        zpaq a "$baseName.zpaq" "$baseName" -m5 -not "*/.DS_Store"
        return $status
    else
        echo "[Error] zpaq not installed."
        return 1
    end
end
