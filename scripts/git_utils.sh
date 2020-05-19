SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

source "${SCRIPT_DIR}/utils.sh"

function git_clone() {
    local help_or_repo_url=${1}
    local repo_dir=${2}

    show_help "${help_or_repo_url}" "git_clone REPO_URL REPO_DIR"

    if [[ -d ${repo_dir} && $(binary_prompt "Overwrite?") ]]; then
        info "Cloning ${help_or_repo_url} -> ${repo_dir}"
        git clone --recursive "${help_or_repo_url}" "${repo_dir}"
    fi
}

function git_update() {
    local repo_dir="${1}"

    show_help ${repo_dir} "git_update REPO_DIR"

    if [[ -d ${repo_dir} && -d ${repo_dir}/.git ]]; then
        lpushd ${repo_dir}
        info "Pulling repo"
        git pull
        info "Updating submodules"
        git submodule update
        popd
    else
        error "Path ${repo_dir} isn't a directory or isn't a repository"
    fi
}

function git_clone_or_update() {
    local help_or_repo_url=${1}
    local repo_dir=${2}

    show_help ${help_or_repo_url} "git_clone_or_update REPO_URL REPO_DIR"

    if [[ ! -d ${repo_dir} ]]; then
        info "There is no repo in ${repo_dir}. Cloning..."
        git_clone ${help_or_repo_url} ${repo_dir}
    else
        info "Repository already exists in ${repo_dir}. Updating..."
        git_update ${repo_dir}
    fi
}
