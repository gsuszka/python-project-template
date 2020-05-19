#!bash -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

if [[ -z ${LOGLEVEL} ]]; then
    set LOGLEVEL=debug
fi

function color() {
    local color_name=${1}

    case ${color_name} in
    "black") echo 30 ;;
    "red") echo 31 ;;
    "green") echo 32 ;;
    "yellow") echo 33 ;;
    "blue") echo 34 ;;
    "magenta") echo 35 ;;
    "cyan") echo 36 ;;
    "light_gray") echo 37 ;;
    "dark_gray") echo 90 ;;
    "light_red") echo 91 ;;
    "light_green") echo 92 ;;
    "light_yellow") echo 93 ;;
    "light_blue") echo 94 ;;
    "light_magenta") echo 95 ;;
    "light_cyan") echo 96 ;;
    "white") echo 97 ;;
    "reset") echo 0 ;;
    *) echo 39 ;;
    esac
}

function cecho() {
    local _color=$(color ${1})
    local text=${2}
    local reset=$(color reset)

    echo -e "\e[${_color}m${text}\e[${reset}m"
}

function info() {
    local log_text=${1}

    case ${LOGLEVEL} in
    info | debug) cecho green "${log_text}" ;;
    *) ;;
    esac
}

function debug() {
    local log_text=${1}

    case ${LOGLEVEL} in
    debug) cecho dark_gray "${log_text}" ;;
    *) ;;
    esac
}

function error() {
    local log_text=${1}

    case ${LOGLEVEL} in
    error)
        cecho red "${log_text}"
        exit 1
        ;;
    *) ;;
    esac
}

function warning() {
    local log_text=${1}

    case ${LOGLEVEL} in
    error) ;;
    *) cecho yellow "${log_text}" ;;
    esac
}
