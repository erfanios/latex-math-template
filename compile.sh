#!/usr/bin/env bash
# SCRIPT: compile.sh 
# AUTHOR: ...
# DATE: 2026-11-20T12:51:46
# REV: 1.0
# ARGUMENTS: [1: filename  ][2:	path of garbadge, default is /tmp/<name of this dir>/ ][3: where the pdf should be put after compile, default is here][4:        ]
# 
# PURPOSE:  using lulalatex compile the main file. Do not use more than half of the cpu's.
#
# Also if the *CLEAN* variable is set, it will clear the folder in which latex log files are saved.
# e.g 
# CLEAN=1 ./compile.sh main.tex
#
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution
# set -e # Break on the first failure

mainfile=${1:?'Please provide name of the main latex file'}
file="${mainfile%.*}"
pdf="${file}.pdf"
# name of this dir
nod="$(basename $PWD)"
buildpath="${2:-"/tmp/latex_$nod"}"
# target path
tarpath="${3:-"$PWD"}"

mkdir -p "${buildpath}"

if [ -n "$CLEAN" ]; then
    rm -rf "$buildpath"/*
fi

# Just adding this to not get errors when the files are not there. It will be created by latexmk if needed.
needed_extentions=(
    .bbl
    .toc
    .lof
    .lot
    .lol
)

for extention in ${needed_extentions[@]}; do
    touch "${buildpath}/${file}${extention}"
done

# The actual compilation command.
latexmk -pdf -lualatex -shell-escape -interaction=nonstopmode -silent -f -file-line-error -outdir="$buildpath" "${mainfile}"

if [ -f "${buildpath}/${pdf}" ]; then
    cp "${buildpath}/${pdf}" . && echo "PDF built successfully: ${buildpath}/${pdf}"
else
    echo "Failed to build the PDF. Check the log files in ${buildpath} for errors."
fi