append_envvar() {
    eval "val=\"\$$1\""
    delim="${3:-:}"
    case "$delim$val$delim" in
        *"$delim$2$delim"*)
            ;;
        *)
            eval "$1=\"\${$1:+\$$1$delim}$2\""
            ;;
    esac
}

prepend_envvar() {
    eval "val=\"\$$1\""
    delim="${3:-:}"
    case "$delim$val$delim" in
        *"$delim$2$delim"*)
            ;;
        *)
            eval "$1=\"$2\${$1:+$delim\$$1}\""
            ;;
    esac
}


import_env() {
    if hash dbus-update-activation-environment 2>/dev/null
    then
        dbus-update-activation-environment --systemd "$@"
    else
        systemctl --user import-environment "$@"
    fi
}
