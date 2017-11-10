#!/bin/bash

#DIR = This script pwd (Print Working Directory) folder
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

git clone git@github.com:ipburger/git-common.git $DIR/git-common
bash $DIR/git-common/setup.sh