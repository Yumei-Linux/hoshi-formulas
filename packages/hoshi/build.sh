downloads() {
  git clone https://github.com/Yumei-Linux/hoshi.git \
    --depth=1 \
    --recurse-submodules \
    $build_dir/hoshi
}

build() {
  cd hoshi

  # build the package
  zig build -Doptimize=ReleaseSafe

  # install hoshi at the rootfs
  install -Dvm755 zig-out/bin/hoshi \
    $dest/usr/bin/hoshi
}

