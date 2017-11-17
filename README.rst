=============
modeldb-basic
=============
.. image:: https://img.shields.io/travis/engapa/modeldb-basic/master.svg
   :target: http://travis-ci.org/engapa/modeldb-basic
   :alt: Build Status

A basic python client for working with `ModelDB machine learning management system <http://modeldb.csail.mit.edu>`_.

Visit the original project at :  https://github.com/mitdbg/modeldb

This project goal is to try isolate a basic client to operate within model database, where main features will be:

- Sync projects/models from file (json, yaml)
- Sync projects/models by using basic mechanism (without sklearn dependencies)
- Python 2.7 and 3.{5,6} compatibility.


Quick start
===========

Develop
-------

All phases of development are managed from a centric makefile. Please type ``make`` for more details.

Install
-------

Since this project is a develop fork of original project we encourage to use git URL as source.

Add this line in your requirement.txt file::

    -e git+https://github.com/engapa/modeldb-basic#egg=modeldb-basic


Or install directly by ``pip``::

    pip install -e git+https://github.com/engapa/modeldb-basic#egg=modeldb-basic


