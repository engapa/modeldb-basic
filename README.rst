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

Remotely
""""""""

The most widely known way to install a python package is by **pip** command.
The python package is available at [pypi repository](https://pypi.org/project/modeldb-basic/) (legacy repo [here](https://pypi.python.org/pypi/modeldb-basic)).

Just type this ``pip`` command to install it from pypi package repository::

 pip install modeldb-basic


Alternatively it's possible to install it by using any of these URLs:

* ``pip install git+https://github.com/engapa/modeldb-basic[@<git_ref>]#egg=modeldb-basic``
* ``pip install <release_file>``

Where [@<git_ref>] is an optional reference to a git reference (i.e: @master, @v0.1.6) and
<release_file> is the URL of one release file at https://github.com/engapa/modeldb-basic/releases

Locally
"""""""

Previously downloaded in your host, somebody may install the package by typing::

 pip install .

or::

 python setup.py install

