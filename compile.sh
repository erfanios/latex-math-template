#!/usr/bin/env bash
# SCRIPT: compile.sh 
# AUTHOR: ...
# DATE: 2026-11-20T12:51:46
# REV: 1.0
# ARGUMENTS: [1: path to main .tex file][2: target file name][3: build root, default is /tmp/latex_<current directory>][4: PDF output directory, default is current directory]
# 
# ARGUMENTS: [1: path to main .tex file][2: output file name with .pdf][3: PDF output directory, default is current directory][4: build root, default is /tmp/latex_<current directory>]
#
# Each source file gets a separate build directory under the build root.
# If *CLEAN* is set, only that source file's build directory is cleared.
# e.g 
# CLEAN=1 ./compile.sh main.tex
#
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution
# set -e # Break on the first failure

mainfile=${1:?'Please provide the path to the main LaTeX file'}
if [ ! -f "$mainfile" ]; then
    echo "LaTeX source file not found: ${mainfile}" >&2
    exit 1
fi


target_file_name="${2:-"$(basename "$mainfile" .tex).pdf"}"
tarpath="${3:-"$PWD/output"}"


buildpath="${4:-"/tmp/latex_$(basename "$PWD")"}"
# create a unique build directory for each source file based on its checksum
source_id="$(printf '%s' "$mainfile" | cksum | cut -d ' ' -f 1)"
builddir="${buildpath}/${source_id}-${basename%.*}"

# ---

basename="${mainfile##*/}"
pdf="${basename%.*}.pdf"

# ---
if [ -n "$CLEAN" ]; then
    rm -rf "$builddir"
fi

mkdir -p "${builddir}" "${tarpath}"

# Just adding this to not get errors when the files are not there. It will be created by latexmk if needed.
needed_extentions=(
    .bbl
    .toc
    .lof
    .lot
    .lol
)

for extention in "${needed_extentions[@]}"; do
    touch "${builddir}/${basename%.*}${extention}"
done

# The actual compilation command.
if ! latexmk -pdf -lualatex -shell-escape -interaction=nonstopmode -silent -f -file-line-error -outdir="$builddir" "${mainfile}"; then
    echo "LaTeX compilation failed. Check the log files in ${builddir} for errors." >&2
    exit 1
fi

if [ -f "${builddir}/${pdf}" ]; then
    if ! cp "${builddir}/${pdf}" "${tarpath}/${target_file_name}"; then
        echo "Failed to copy the PDF to ${tarpath}." >&2
        exit 1
    fi
    echo "PDF built successfully: ${tarpath}/${target_file_name}"
else
    echo "Failed to build the PDF. Check the log files in ${builddir} for errors." >&2
    exit 1
fi
