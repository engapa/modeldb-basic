.PHONY: help

# Shell to use with Make
SHELL := /bin/bash

THRIFT_DOCKER_IMAGE = thrift:0.10

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  clean         to clean all generated resources"
	@echo "  gen           to launch integration tests, included in local-tests and docker-tests"
	@echo "  test          to launch all tests in local host"

clean:
	@rm -rf *.egg .cache .doc .coverage build dist docs/build *.out *.output .tox *.thrift
	@find . -name '*.pyc' -exec rm -f {} +
	@find . -name '*.pyo' -exec rm -f {} +
	@find . -name '__pycache__' -exec rm -rf {} +
	@find . -name '*~' -exec rm -f {} +

docker-pull:
	@docker pull $(THRIFT_DOCKER_IMAGE)

gen: docker-pull
	@echo "Generating client code for python language by thrift ..."
	@wget -q -O ModelDB.thrift https://raw.githubusercontent.com/mitdbg/modeldb/master/thrift/ModelDB.thrift
	@docker run -v $(shell pwd):/data $(THRIFT_DOCKER_IMAGE) \
        thrift -r -v -out /data/modeldb/thrift --gen py /data/ModelDB.thrift

test: clean gen
	@tox

