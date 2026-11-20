#!/usr/bin/env bash
# SCRIPT: clear_the_dump.sh 
# AUTHOR: ...
# DATE: 2026-11-20T13:27:21
# REV: 1.0
# ARGUMENTS: [1:        ][2:		][3:		][4:        ]
#
# PURPOSE: clears the folder in which latex log files are saved 
#
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution
# set -e # Break on the first failure

nod="$(basename $PWD)"
buildpath="${2:-"/tmp/latex_$nod"}"

rm -rf "$buildpath"/*
