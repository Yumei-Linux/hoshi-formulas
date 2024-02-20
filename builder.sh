#!/usr/bin/env bash

cd $(dirname $0)

packagename="$1"

export dest="$(mktemp -d)"
export downloads="$(pwd)/downloads"
export dist="$(pwd)/dist"

. "./$packagename/build.sh"

# logging
COLOR_RED='\033[31m'
COLOR_BLUE='\033[34m'
COLOR_GREEN='\033[32m'
COLOR_YELLOW='\033[33m'
COLOR_MAGENTA='\033[35m'
COLOR_CYAN='\033[36m'
COLOR_RESET='\033[0m'

info() {
  echo -e "${COLOR_BLUE}info: ${COLOR_RESET}${@}"
}

success() {
  echo -e "${COLOR_GREEN}success: ${COLOR_RESET}${@}"
}

generate_files_registry() {
  printf "${COLOR_BLUE}info:${COLOR_RESET} Generating files registry..."

  find $dest | \
    sed "s~$dest~~g" | \
    grep -v files.txt | \
    grep -v metadata.json | \
    tee $dest/files.txt >/dev/null 2>&1

  printf "${COLOR_GREEN} Ok!${COLOR_RESET}\n"

  pushd /var/lib/hoshi/hoshi-formulas >/dev/null 2>&1
    printf "${COLOR_BLUE}info:${COLOR_RESET} Bundling package assets..."
    cp $packagename/metadata.json $dest
    printf "${COLOR_GREEN} Ok!${COLOR_RESET}\n"
  popd >/dev/null 2>&1
}

# building of the package
info "Starting the building process for ${COLOR_GREEN}${packagename}${COLOR_RESET}"

mkdir -pv build ; pushd build > /dev/null 2>&1
  downloads
  build
  generate_files_registry
popd > /dev/null 2>&1

test -d $rootfs || mkdir -p $rootfs

success "Done, cleaning up"

rm -rf ./downloads/*
rm -rf ./build

packagename="$(echo $packagename | sed 's/\// /g' | awk '{print $2}')"

info "Building hoshi image ${COLOR_CYAN}->${COLOR_GREEN} ($packagename.hoshi)${COLOR_RESET}"

mv $dest ./$packagename
tar -cf $packagename{.tar.gz,}
mv $packagename{.tar.gz,.hoshi}
rm -rf ./$packagename

test -d $dist || mkdir -p $dist
mv ./$packagename.hoshi $dist
du -sh $dist/$packagename.hoshi

