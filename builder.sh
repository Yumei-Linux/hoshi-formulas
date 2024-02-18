#!/usr/bin/env bash

packagename="$1"

export dest="$(mktemp -d)"
export downloads="$(pwd)/downloads"
export dist="$(pwd)/dist"

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

echo "==> Done, cleaning up"

rm -rf ./downloads/*
rm -rf ./build

packagename="$(echo $packagename | sed 's/\// /g' | awk '{print $2}')"

echo "==> Building hoshi image ($packagename.hoshi)"

mv $dest ./$packagename
tar -cf $packagename{.tar.gz,}
mv $packagename{.tar.gz,.hoshi}
rm -rf ./$packagename

test -d $dist || mkdir -p $dist
mv ./$packagename.hoshi $dist
du -sh $dist/$packagename.hoshi

echo "==> Done"
