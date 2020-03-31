#!bash -e

source scripts/utils.sh
source scripts/installers.sh

if [[ -f pyproject.toml ]]; then
    echo "There is already project created. Remove pypoject.toml."
    if binary_prompt "Overwrite?"; then
        rm -rfv pyproject.toml
    else
        exit 0
    fi
fi

if ! check_exec poetry; then
    install_poetry
fi

poetry init

echo "Installing developement dependencies"
poetry add --dev --allow-prereleases $(echo mypy mypy-extensions black autoflake pylint $(cat ${FILE_DEV_REQS:-requirements.dev.txt}) | tr ' ' '\n' | sort | uniq)

if [[ -f requirements.txt ]]; then
    echo "Installing dependencies"
    poetry add --allow-prereleases $(echo $(cat ${FILE_REQS:-requirements.txt}) | tr ' ' '\n' | sort | uniq)
fi

project_source_dir=${DIR_SRC:-src}/$(sed -nE 's/^name = "(.*)"$/\1/p' pyproject.toml)
if [[ ! -d ${project_source_dir} ]]; then
    echo "Creating project source dir in ${project_source_dir}"
    mkdir -p ${project_source_dir}
fi

echo -e "Now you can run: \npoetry shell\n\tand then\nsource .env"
