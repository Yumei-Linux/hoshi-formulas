#!/usr/bin/env bash

packagename="$1"

# TODO: Replace rootfs with / on production
export rootfs=$HOME/rootfs
export dest="$(mktemp -d)"
export downloads="$(pwd)/downloads"

. "./$packagename/build.sh"

generate_files_registry() {
  echo "==> Generating files registry"
  find $dest | \
    sed "s~$dest~~g" | \
    grep -v files.txt | \
    tee $dest/files.txt >/dev/null 2>&1
}

# building of the package
echo "==> Building the package"

mkdir -pv build ; pushd build
  downloads
  build
  generate_files_registry
popd

test -d $rootfs || mkdir -pv $rootfs

# merging files into rootfs according to files.txt
echo "==> !!MERGING INTO ROOTFS"
cat $dest/files.txt | \
  while read -r file; do \
    dir=$(dirname $file); \
    test -d $rootfs/$dir || mkdir -pv $rootfs/$dir; \
    install -Dvm755 $dest/$file $rootfs/$dir; \
  done

echo "==> Done, cleaning up"

rm -rf $dest
rm -rf ./downloads/*
rm -rf ./build
