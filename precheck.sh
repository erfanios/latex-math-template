#!/usr/bin/env bash
# SCRIPT: precheck.sh 
# AUTHOR: ...
# DATE: 2026-11-20T13:21:26
# REV: 1.0
# ARGUMENTS: [1:        ][2:		][3:		][4:        ]
#
# PURPOSE: In orther to keep input of all files the same this script will be run at the beggin of all .sh file to check if a parameter is set or to set it to default.
#       Also for it to work, it needs to be run with the source or dot.
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution
# set -e # Break on the first failure


mainfile=${1:?'Please provide name of the main latex file'}
# name of this dir
nod="$(basename $PWD)"
dumppath="${2:-"/tmp/latex_$nod"}"
# target path
tarpath="${3:-"$PWD"}"
