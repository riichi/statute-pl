#!/bin/bash

awk -v sec=1 '/^§$/ { printf("### § %d\n\n", sec); sec += 1 }; !/^§$/ { print }' statut.md | pandoc -s -f markdown -t odt -o statut.odt -
