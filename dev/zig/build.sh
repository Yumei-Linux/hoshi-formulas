downloads() {
  tar xpvf $downloads/zig-linux-x86_64-0.11.0.tar.xz
}

build() {
  cd zig-linux-x86_64-0.11.0

  # Create the destination directory and copy the binary files
  mkdir -pv $dest/opt/zig
  cp -rvf ./* $dest/opt/zig

  # Create a symlink to the binary
  mkdir -pv $dest/usr/bin
  ln -svf ../../opt/zig/zig $dest/usr/bin/zig
}

