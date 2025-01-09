function check_ssh_config
    set -f ostype (uname)

    switch $ostype
        case Darwin
            set -f CMD_CAT /bin/cat
            set -f CMD_HEAD /usr/bin/head
            set -f CMD_SED /usr/bin/sed
        case Linux
            set -f CMD_CAT /bin/cat
            set -f CMD_HEAD /usr/bin/head
            set -f CMD_SED /bin/sed
    end

    set -f CMECKSUM_HEADER_PREFIX "# md5sum:"

    if not test -d "$HOME/.ssh"
        echo "[INFO] .ssh directory does not found. create."
        mkdir "$HOME/.ssh"
        chmod 700 "$HOME/.ssh"
    end

    set -f CURRENT_CONFIG "$HOME/.ssh/config"
    set -f CURRENT_CONFIG_MD5
    if test -f "$CURRENT_CONFIG"
        set -f CURRENT_CONFIG_MD5 ($CMD_HEAD -1 $CURRENT_CONFIG | $CMD_SED "s/$CMECKSUM_HEADER_PREFIX //g")
    end

    set -f BEFORE_CONFIG "$HOME/.ssh_config.d/before_config"
    set -f LOCAL_CONFIG "$HOME/.ssh_config.local"
    set -f AFTER_CONFIG "$HOME/.ssh_config.d/after_config"

    if not test -d "$HOME/.ssh_config.d"
        echo "[INFO] migrate directory does not found. create its directory."
        mkdir "$HOME/.ssh_config.d"
        if test -f "$CURRENT_CONFIG"
            echo "[INFO] .ssh/config already exists. copy currnet config to .ssh_config.local"
            if test -f "$LOCAL_CONFIG"
                echo ".ssh_config.local already exists... append mode."
                $CMD_CAT "$CURRENT_CONFIG" >>"$LOCAL_CONFIG"
            else
                $CMD_CAT "$CURRENT_CONFIG" >"$LOCAL_CONFIG"
            end
        end
    end

    if not test -f "$BEFORE_CONFIG"
        echo "[INFO] before_config does not found. create it."
        echo "# write your settings without Host/Match" >"$BEFORE_CONFIG"
    end

    if not test -f "$AFTER_CONFIG"
        echo "[INFO] after_config does not found. create it."
        echo "# write your settings with Host/Match" >"$AFTER_CONFIG"
    end

    set -f NEXT_CONFIG_FILES
    if test -f "$LOCAL_CONFIG"
        set -f NEXT_CONFIG_FILES "$BEFORE_CONFIG" "$LOCAL_CONFIG" "$AFTER_CONFIG"
    else
        set -f NEXT_CONFIG_FILES "$BEFORE_CONFIG" "$AFTER_CONFIG"
    end

    set -f NEXT_CONFIG ($CMD_CAT $NEXT_CONFIG_FILES)
    set -f NEXT_CONFIG_MD5

    switch $ostype
        case Darwin
            set -f NEXT_CONFIG_MD5 ($CMD_CAT $NEXT_CONFIG_FILES | md5)
        case Linux
            set -f NEXT_CONFIG_MD5 ($CMD_CAT $NEXT_CONFIG_FILES | md5sum | awk '{print $1}')
    end

    alias sshconfig="$EDITOR -o $SSH_CONFIG_FILES"

    if test "$CURRENT_CONFIG_MD5" != "$NEXT_CONFIG_MD5"
        echo "ssh_config has been changed. rebuilding. $CURRENT_CONFIG_MD5 vs $NEXT_CONFIG_MD5"
        echo -n "" >"$CURRENT_CONFIG"
        echo "$CMECKSUM_HEADER_PREFIX $NEXT_CONFIG_MD5" >>"$CURRENT_CONFIG"
        set -f currentDate (date +'%Y-%m-%d %H:%M:%S')
        echo "# generate: ($currentDate) " >>"$CURRENT_CONFIG"
        for CONFIG_SOURCE in $NEXT_CONFIG_FILES
            echo "" >>"$CURRENT_CONFIG"
            set -f sourceName (basename $CONFIG_SOURCE)
            echo "# -- build from: $sourceName" >>"$CURRENT_CONFIG"
            $CMD_CAT $CONFIG_SOURCE >>"$CURRENT_CONFIG"
        end
        chmod 644 "$CURRENT_CONFIG"
    end
end

check_ssh_config
