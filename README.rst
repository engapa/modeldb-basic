=============
modeldb-basic
=============
.. image:: https://img.shields.io/travis/engapa/modeldb-basic/master.svg?style=flat-square
   :target: http://travis-ci.org/engapa/modeldb-basic
   :alt: Build Status
.. image:: https://img.shields.io/pypi/v/modeldb-basic.svg?style=flat-square
   :target: https://pypi.org/project/modeldb-basic
   :alt: Version
.. image:: https://img.shields.io/pypi/pyversions/modeldb-basic.svg?style=flat-square
   :target: https://pypi.org/project/modeldb-basic
   :alt: Python versions

A basic python client for working with `ModelDB machine learning management system <http://modeldb.csail.mit.edu>`_.

Visit the original project at :  https://github.com/mitdbg/modeldb

This project goal is to try isolate a basic client to operate within model database, where main features will be:

- Sync projects/models from file (json, yaml)
- Sync projects/models by using basic mechanism (without sklearn dependencies)
- Python 2.7 and 3.{5,6} compatibility.


Quick start
===========

Install
-------

In order to use the basic modeldb client in your python code (in notebooks as well) you should install
the package by one of well known methods:

- Installing directly by ``pip``::

    pip install <package_url>

Where *package_url* would be one of:

    * **modeldb-basic**, from pypi package repository (specify a version for no latest)
    * **git+https://github.com/engapa/modeldb-basic#egg=modeldb-basic**, from remote sources of github (specify a branch or tag if you don't want to use master default branch)
    * or a github released downloadable file url at https://github.com/engapa/modeldb-basic/releases

- From sources previously downloaded in your host::

    pip install .

or::

    python setup.py install

