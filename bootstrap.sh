#!/bin/sh
# supposed to run with pyenv
# before running this, ensure to bind this to a virtualenv with python 2.7.15+
# hint:
# pyenv install 2.7.15
# pyenv virtualenv 2.7.15 collective.immediatecreate-2.7.15
# pyenv local collective.immediatecreate-2.7.15
pip install -U pip 
pip install -r requirements.txt 
buildout 
