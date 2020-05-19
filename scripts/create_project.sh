#!bash -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

source ${SCRIPT_DIR}/utils.sh
source ${SCRIPT_DIR}/log.sh
source ${SCRIPT_DIR}/installers.sh
source ${SCRIPT_DIR}/log.sh

function check_pyproject() {
    local project_root=${1:-"${SCRIPT_DIR}/.."}
        
    if [[ -f ${project_root}/pyproject.toml ]]; then
        warning "There is already project created. Remove ${project_root}/pyproject.toml."
        if binary_prompt "Overwrite?"; then
            info "Removing ${project_root}/pyproject.toml and ${project_root}/poetry.lock"
            rm -rfv ${project_root}/pyproject.toml ${project_root}/poetry.lock
        else
            exit 0
        fi
    fi
}

function init_poetry() {
    if ! check_exec poetry; then
        install_poetry
    fi

    info "Initializing poetry project"
    poetry init
}

function install_deps() {
    local reqs_path=${1}
    local packages_type=${2}
    local packages="${3}"

    if [[ ${packages_type} == 'dev' ]]; then
        info "Installing dependencies for developement"
        dev_flag='--dev'
    else
        info "Installing dependencies"
    fi

    if [[ -f ${reqs_path} ]]; then
        info "Reading requirements from ${reqs_path}"
        other_packages=$(cat ${reqs_path})
    fi

    local packages=$(echo ${packages} ${other_packages} | tr ' ' '\n' | sort | uniq)
    if [[ ! -z ${packages} ]]; then
        info "Installing ${packages}"
        poetry add ${dev_flag} ${packages}
    else
        warning "No packages to install"
    fi
}

function create_source_dir() {
    local project_dir=${1:-"${SCRIPT_DIR}/.."}
    local source_dir=${2:-"src/$(sed -nE 's/^name = "(.*)"$/\1/p' ${project_dir}/pyproject.toml)"}

    if [[ ! -d ${source_dir} ]]; then
        info "Creating source dir in ${source_dir}"
        mkdir -p ${source_dir}
        touch "${source_dir}/__init__.py"
    fi
}

function create_project() {
    check_pyproject
    init_poetry
    install_deps ${SCRIPT_DIR}/../requirements.dev.txt dev
    install_deps ${SCRIPT_DIR}/../requirements.txt
    create_source_dir 
}

create_project
