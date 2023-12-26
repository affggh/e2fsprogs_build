#!/usr/bin/bash
set -e

CURRENT_DIR="$(readlink -f $(dirname $0))"
TARGET_SRC_DIR="$(readlink -f $1)"
PATCH_DIR="${CURRENT_DIR}/patches"

LIST_TO_PATCH=$(ls ${PATCH_DIR}/)

# apply patch
gitapply() {
    patchdir="$1"
    shift 1
    cd $patchdir
    for i in $@; do
        git reset --hard > /dev/null
        printf "\x1b[93m- Apply Patch [%s] -> [%s] ... " "$(basename $i)" "$(basename $patchdir)"
        git apply "$@" >/dev/null 2>&1 && printf "\x1b[92mDone\x1b[0m\n" || printf "\x1b[91mFailed\x1b[0m\n"
    done
    cd $CURRENT_DIR
}

# get patch abs path
find_patches() {
    echo -e "$(find $1 -name \*.patch 2>&1)"
}

# Patch
for i in $(ls $PATCH_DIR/); do
    basedir="$i"
    for j in $(ls $PATCH_DIR/$basedir/*.patch); do
        gitapply "$TARGET_SRC_DIR/$basedir" "$j"
    done  
done

# Exit anyway
true