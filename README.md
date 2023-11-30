psqlparse
=========

> [!WARNING]
> **This project is a fork from the no-longer maintained https://github.com/alculquicondor/psqlparse**.
>
> This is an experiment in upgrading the `libpg_query` library to the latest PostgreSQL 15 compatible version.
>
> Unfortunately the structure of the returned parse tree is different from the 9.x version that was supported in the
> upstream project, so many parts of the `parse` function in this Python wrapper are still broken.
> You can still use the `parse_dict` method which returns the raw parse tree out of `libpg_query` as a big dictionary though.

This Python module  uses the [libpg\_query](https://github.com/lfittl/libpg_query) to parse SQL
queries and return the internal PostgreSQL parsetree.

Installation
------------

```shell
pip install psqlparse
```

Usage
-----

```python
import psqlparse
statements = psqlparse.parse('SELECT * from mytable')
used_tables = statements[0].tables()  # ['my_table']
```

`tables` is only available from version 1.0rc1

Development
-----------

0. Update dependencies

```shell
git submodule update --init
```

1. Install requirements:

```shell
pip install -r requirements.txt
```

2. Build Cython extension

```shell
USE_CYTHON=1 python setup.py build_ext --inplace
```

3. Perform changes

4. Run tests

```shell
pytest
```

Maintainers
------------

- [Aldo Culquicondor](https://github.com/alculquicondor/)
- [Kevin Zúñiga](https://github.com/kevinzg/)
