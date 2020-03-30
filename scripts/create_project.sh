#!bash -e

source scripts/utils.sh

if [[ -f pyproject.toml ]]; then
    echo "There is already project created. Remove pypoject.toml."
    if binary_prompt "Overwrite?"; then
        rm -rfv pyproject.toml
    else
        exit 0
    fi
fi

if ! check_exec poetry; then
    echo "Installing poetry"
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
fi

poetry init

if [[ -f requirements.dev.txt ]]; then
    echo "Installing developement dependencies"
    poetry add --dev --allow-prereleases $(cat requirements.dev.txt)
fi

if [[ -f requirements.txt ]]; then
    echo "Installing dependencies"
    poetry add --allow-prereleases $(cat requirements.txt)
fi

project_source_dir=${DIR_SRC:-src}/$(sed -nE 's/^name = "(.*)"$/\1/p' pyproject.toml)
if [[ ! -d ${project_source_dir} ]]; then
    echo "Creating project source dir in ${project_source_dir}"
    mkdir -p ${project_source_dir}
fi

poetry shell 