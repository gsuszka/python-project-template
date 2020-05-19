SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

source "${SCRIPT_DIR}/log.sh"

function show_help() {
    local help_arg=${1}
    local help_text=${2}

    debug "${@}"
    if [[ ${help_arg} =~ ^-(h|-help) ]]; then
        info "${help_text}"
        exit 0
    fi
}

function binary_prompt() {
    local arg=${1}
    
    show_help ${arg} "binary_prompt PROMPT_TEXT"
    read -p "$arg [Y/n] " -n 1 -r
    echo

    case $REPLY in
    N | n) return 1 ;;
    *) return 0 ;;
    esac
}

function check_exec() {
    local help_or_exec_name=${1}

    show_help "${help_or_exec_name}" "check_exec EXEC_NAME"
    debug "Checking if ${help_or_exec_name} is installed"
    return $(hash ${help_or_exec_name})
}

function lpushed()  {
    local path="${1}"
    debug "Entering: ${path}"
    pushd "$path"
}