define envvars
$(shell grep -Ev '^#' .env | xargs -d '\n')
endef