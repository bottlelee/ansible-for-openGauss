#!/bin/bash
set -e

vagrant destroy -f
vagrant up --provision
vagrant reload
vagrant snapshot save init
