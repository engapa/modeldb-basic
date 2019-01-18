.DEFAULT_GOAL := help

# Shell to use with Make
SHELL ?= /bin/bash

THRIFT_DOCKER_IMAGE = thrift:0.11.0

DOCKER_ORG       ?= engapa
DOCKER_IMAGE     ?= modeldb
DOCKER_USERNAME  ?= engapa
DOCKER_PASSWORD  ?= secretito
DOCKER_TAG       ?= latest
PY_ENVS          ?= 2.7 3.5 3.6 3.7
PY_ENV_DEF       ?= 3.7

.PHONY: help
help: ## Show this help
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: clean-docker
clean-docker: ## Remove docker containers and their images
	@$(foreach tag,\
	  $(DOCKER_TAGS),\
	  docker rm -f $$(docker ps -a -f "ancestor=$(DOCKER_ORG)/$(DOCKER_IMAGE):$(tag)" --format '{{.Names}}') > /dev/null 2>&1 || true;\
	  docker rmi -f $(DOCKER_ORG)/$(DOCKER_IMAGE):$(tag) > /dev/null 2>&1 ] || true;)
	@$(foreach py_env,\
	  $(PY_ENVS),\
	  docker rm -f $$(docker ps -a -f "ancestor=$(DOCKER_ORG)/$(DOCKER_IMAGE)-test:py$(py_env)" --format '{{.Names}}') > /dev/null 2>&1 || true;\
	  docker rmi -f $(DOCKER_ORG)/$(DOCKER_IMAGE)-test:py$(py_env) > /dev/null 2>&1 || true;)

.PHONY: clean
clean: ## Remove generated resources
	@rm -rf .cache .doc .coverage build dist .eggs docs/build .output tests/.output-test .venv *.thrift
	@find . -name '*.egg-info' -exec rm -fr {} +
	@find . -name '*.egg' -exec rm -f {} +
	@find . -name '*_cache' -exec rm -rf {} +
	@find . -name '*.pyc' -exec rm -f {} +
	@find . -name '*.pyo' -exec rm -f {} +
	@find . -name '*~' -exec rm -f {} +
	@find . -name '__pycache__' -exec rm -fr {} +

.PHONY: clean-all
clean-all: clean clean-docker ## Remove all built resources

.PHONY: thrift-gen
thrift-gen:  ## Generate client code for python lenguage y using Thrift
	@echo "Generating client code for python language by thrift ..."
	@docker pull $(THRIFT_DOCKER_IMAGE)
	@wget -q -O ModelDB.thrift https://raw.githubusercontent.com/mitdbg/modeldb/master/thrift/ModelDB.thrift
	@docker run -v $(shell pwd):/data $(THRIFT_DOCKER_IMAGE) \
        thrift -r -v -out /data/modeldb/thrift --gen py /data/ModelDB.thrift

.PHONY: build-test-images
build-test-images:
	@ $(foreach py_env,\
		$(PY_ENVS),\
		docker build --build-arg PY_VERSION=$(py_env) -t $(DOCKER_ORG)/modeldb-py$(py_env)-test -f Dockerfile.test .;)

.PHONY: test
test: build-test-images ## Run tests, based on docker
	@ $(foreach py_env,$(PY_ENVS),docker run -ti $(DOCKER_ORG)/modeldb-py$(py_env)-test ./entry.sh test;)

.PHONY: build
build:
	@ $(foreach py_env,$(PY_ENVS),docker run -ti $(DOCKER_ORG)/modeldb-py$(py_env)-test ./entry.sh build;)

.PHONY: docker-build
docker-build:
	@ $(foreach py_env,\
		$(PY_ENVS),\
		docker build --build-arg PY_VERSION=$(py_env) -t $(DOCKER_ORG)/modeldb-py$(py_env) -f Dockerfile .;)

.PHONY: docker-publish
docker-publish:
	@ $(foreach py_env,\
		$(PY_ENVS),\
		docker push $(DOCKER_ORG)/modeldb-py$(py_env);)

.PHONY: publish
publish:
	@docker run -d -ti --name modeldb-publisher $(DOCKER_ORG)/modeldb-py$(PY_ENV_DEF)-test
	@docker exec -it modeldb-publisher ./entry.sh build
	@docker exec -it modeldb-publisher ./entry.sh publish
	@docker rm modeldb-publisher

