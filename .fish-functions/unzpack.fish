function unzpack -a fileName
    if command -vq zpaq
        if not test -f "$fileName"
            echo "[Usage] unzpack <FileName>"
            return 1
        end
        zpaq x "$fileName"
        return $status
    else
        echo "[Error] zpaq not installed."
        return 1
    end
end
