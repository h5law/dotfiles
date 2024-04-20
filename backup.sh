#!/bin/bash

## Description ##############################################
# This file copies a list of files to the destination path  #
# which is either the final argument or ~/personal/dotfiles #
# which should be a github repo. It will then make a commit #
# stating which files it copied.                            #
#############################################################

# Check if the number of arguments is at least 1
if [ $# -lt 1 ]; then
	echo "Usage: $0 <file1> <file2> ... <fileN> <destination>"
fi

# Get the destination path, default is ~/personal/dotfiles
if [ $# -eq 1 ]; then
	DESTINATION="${HOME}/personal/dotfiles"
else
	DESTINATION="${*: -1}"
fi

if ! command -v cd &>/dev/null; then
	echo "'cd' command not found"
	exit 1
fi

if ! command -v git &>/dev/null; then
	echo "'git' command not found"
	exit 1
fi

# Check if the destination path exists and is a git repo
if [ ! -d "${DESTINATION}" ]; then
	echo "Destination path '${DESTINATION}' does not exist."
	exit 1
fi

if [ ! -d "${DESTINATION}/.git" ]; then
	echo "'${DESTINATION}' is not a Git repository."
	exit 1
fi

# Get the list of files to copy

# Get the list of files to copy
declare -a FILES
if [ $# -eq 1 ]; then
	FILES=("$1")
else
	FILES=("${@:0:$#-1}")
fi
echo "${FILES[*]}"

# Copy the files and make a commit stating which ones were copied
for file in "${FILES[@]}"; do
	echo "Copying '${file}' to '${DESTINATION}'..."
	cp -vr "${file}" "${DESTINATION}/"
done
echo "Files copied to '${DESTINATION}'."

CWD=$(pwd)
cd "${DESTINATION}" || (echo "Failed to cd to '${DESTINATION}'." && exit 1)
git add .
git commit -m "Copied files: ${FILES[*]}"
cd "${CWD}" || (echo "Failed to cd back to '${CWD}'." && exit 1)

echo "Done!"
exit 0
