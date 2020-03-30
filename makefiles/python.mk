python-mypy: $(PYPROJECT) $(DIR_SRC) ## Uses mypy for type checking
	@mypy --config-file $(PYPROJECT) $(DIR_SRC)

python-pytype: ${DIR_SRC} ## Uses pytype for type checking [NOT WORKING]
	@echo TODO

python-pyre: ${DIR_SRC} ## Uses pyre for type checking [NOT WORKING]
	@echo TODO

python-isort: $(DIR_SRC) ## Uses isort to sort python includes
	@isort -rc --atomic $(DIR_SRC)

python-autoflake: $(DIR_SRC) ## Uses autoflake to remove unused stuff
	@autoflake -i -r $(DIR_SRC) \
		--ignore-init-module-imports \
		--remove-unused-variables \
		--remove-duplicate-keys \
		--remove-all-unused-imports

python-yapf: $(DIR_SRC) ## Uses yapf to format python code
	@yapf -p -r -i $(DIR_SRC)

python-black: $(DIR_SRC) $(PYPROJECT) ## Uses black to format python code
	@black --config $(PYPROJECT) $(DIR_SRC)

python-autopep8: $(DIR_SRC) $(PYPROJECT) ## Uses autopep8 to format python code
	@autopep8 --global-config $(PYPROJECT) $(DIR_SRC)

python-format: python-black python-isort python-autoflake ## Cleans up code
python-check-types: python-mypy ## Checks types
