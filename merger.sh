#!/usr/bin/env bash

filename="$1"
original_filename="$(echo "$(basename $filename)" | sed 's/.hoshi//g')"

# TODO: replace this to / in production
export rootfs=/var/lib/hoshi/debug-rootfs

echo "==> Reading $filename"

cp $filename /var/lib/hoshi/packages

tmp="$(mktemp -d)"

pushd "$tmp" > /dev/null 2>&1
  tar xpf /var/lib/hoshi/packages/$original_filename.hoshi
  pushd $original_filename > /dev/null 2>&1
    echo "==> Merging into rootfs ($rootfs) the package $original_filename.hoshi"
    cat files.txt | while read -r file; do
      if [[ "$file" != "" ]]; then
        dir="$(dirname $file)"
        echo "  ++ $file"
        test -d $rootfs/$dir || mkdir -p $rootfs/$dir > /dev/null 2>&1
        install -Dm755 $file $rootfs/$file > /dev/null 2>&1
      fi
    done
  popd > /dev/null 2>&1
popd > /dev/null 2>&1

echo "==> Cleaning up"
rm -rf "$tmp"
echo "==> Done!"
