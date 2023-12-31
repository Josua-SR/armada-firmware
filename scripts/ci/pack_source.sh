#!/bin/bash
# SPDX-License-Identifier:           BSD-3-Clause
# https://spdx.org/licenses
# Copyright (C) 2018 Marvell.
#
###############################################################################
## This is the source packing script for optee_os                            ##
## This script is called by CI automated builds                              ##
###############################################################################
## WARNING: Do NOT MODIFY the CI wrapper code segments.                      ##
## You can only modify the config and compile commands                       ##
###############################################################################
## Prerequisites:       DESTDIR is the path to the destination directory
## Usage:               pack_source RELEASE_VER END_TAG
## Output:              packname

## =v=v=v=v=v=v=v=v=v=v=v CI WRAPPER - Do not Modify! v=v=v=v=v=v=v=v=v=v=v= ##
set -exuo pipefail
shopt -s extglob

release_ver=$1
end_tag=$2
echo "running pack_source.sh ${release_ver} ${end_tag}"
## =^=^=^=^=^=^=^=^=^=^=^=^  End of CI WRAPPER code -=^=^=^=^=^=^=^=^=^=^=^= ##

packname="armada-firmware-${release_ver}"
base_tag=`cat scripts/ci/baseline.txt | \
	perl -nae 'next if /^#/; print \$F[0]; exit'`
ref_to_ref="${base_tag}..${end_tag}"
srcpkg="sources-${packname}"
gitpkg="git-${packname}"

mkdir -p ${DESTDIR}/$srcpkg
cp -R ./* ${DESTDIR}/$srcpkg/ || true

mkdir ${DESTDIR}/$gitpkg
git format-patch -o ${DESTDIR}/$gitpkg $ref_to_ref


## =v=v=v=v=v=v=v=v=v=v=v CI WRAPPER - Do not Modify! v=v=v=v=v=v=v=v=v=v=v= ##
echo "packname:$packname"
## =^=^=^=^=^=^=^=^=^=^=^=^  End of CI WRAPPER code -=^=^=^=^=^=^=^=^=^=^=^= ##
