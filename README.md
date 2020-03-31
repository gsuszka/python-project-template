# Sample python project

Python project template with create script with basic dev packages.

## Usage

### Project creation

To create project run:

```shell
make create-project
```

It will run `poetry init` and add basic packages needed to develop typed python applications.

### Makefile

Makefile by default shows help, which is read by comments in all included makefiles.
The format for help is shown below.

```makefile
[TASK NAME]: ## [HELP]
    [TASK COMMANDS]
```

If you want to get help, run:

```shell
make help
```
