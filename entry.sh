#!/usr/bin/env bash

set -e

DIR=$(dirname "$0")

cd ${DIR}

test() {

    pytest --cov=modeldb --pep8 ## --cov-fail-under 80

}

coverage() {

    codecov

}

build() {

    python setup.py sdist bdist_wheel

}

install() {

    pip install -e .

}

publish() {

    twine upload --skip-existing dist/*

}

release(){

    bumpversion --tag --commit --message "[skip ci] Update version {current_version} --> {new_version}" patch modeldb/__init__.py
    export TAG_VERSION=$(git describe --tags `git rev-list --tags --max-count=1`)
    gitchangelog > CHANGELOG.md
    git add CHANGELOG.md && git commit -m "[skip ci] Generated CHANGELOG file" CHANGELOG.md
    git tag -f $TAG_VERSION
    sed -i.bak 's/changelog\.tpl/releasenotes\.tpl/g' .gitchangelog.rc
    export ENV_RELEASE_NOTES=`gitchangelog $TAG_VERSION_OLD..HEAD`
    export RELEASE_BODY=$(python -c "import json,os; print(json.dumps(os.environ['ENV_RELEASE_NOTES']).strip('\"'))")
    export RELEASE_TAG=$TAG_VERSION
    export RELEASE_DIR=$(pwd)/dist

}

help() # Show a list of functions
{
    echo "Type one of the following commands:"
    for command in $(declare -F -p | cut -d " " -f 3);do
      echo " - $command"
    done
}

if [ "_$1" = "_" ]; then
    help
else
    "$@"
fi