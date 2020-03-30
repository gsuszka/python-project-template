function show_help() {
    if [[ $1 =~ ^-(h|-help) ]]; then
        echo $2
        exit 0
    fi
}

function binary_prompt() {
    show_help $1 "binary_prompt PROMPT_TEXT"

    read -p "$1 [Y/n] " -n 1 -r
    echo

    case $REPLY in
    N | n) return 1 ;;
    y | Y | t | T | *) return 0 ;;
    esac
}

function check_exec() {
    show_help $1 "check_exec EXEC_NAME"
    return $(hash $1)
}
