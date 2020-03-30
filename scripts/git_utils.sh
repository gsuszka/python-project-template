source scripts/utils.sh

function git_clone() {
    show_help $1 "git_clone REPO_URL REPO_DIR"

    clone_cmd="git clone --recursive $1 $2"

    if [[ -d $2 && $(binary_prompt "Overwrite?") ]]; then
        $(clone_cmd)
    fi
}

function git_update() {
    show_help $1 "git_update REPO_DIR"

    if [[ -d $1 && -d $1/.git ]]; then
        cd $1
        git pull
        git submodule update
        cd -
    else
        echo "Path $1 isn't a directory or isn't a repository"
        exit 1
    fi
}

function git_clone_or_update() {
    show_help $1 "git_clone_or_update REPO_URL REPO_DIR"
    
    if [[ ! -d $2 ]]; then
        git_clone $1 $2
    else
        git_update $2
    fi
}
