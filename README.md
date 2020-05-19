# Python project template

A python project template with creation script and basic dev packages.

## Usage

### Project creation

To create project run:

```shell
make create-project
```

It will run `poetry init` and add basic packages needed to develop typed python applications.

### Makefile

Makefile by default shows help from all makefiles in project (Makefile, makefiles/*.mk).
The template for help is below.

```makefile
[TASK NAME]: ## [HELP]
    [TASK COMMANDS]
```

If you want to view help, run:

```shell
make help
```
