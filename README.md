# Sample python project

Python project template with create script with basic dev packages.

## Usage

### Project creation

To create project run:

```shell
make create-project
```

It will run `poetry init` and add basic packages needed to develop typed python applications.

### Adding package

If you want to add additional packages add it to requirements or just by running:

```shell
poetry add [PACKAGE_NAME]
```

### Updating packages

To search for packages' updates run `poetry update`.

### Makefile

Makefile by default shows help, which is read by comments in all included makefiles.
The format for help is shown below.

```makefile
[TASK NAME]: ## [HELP]
    [TASK COMMANDS]
```
