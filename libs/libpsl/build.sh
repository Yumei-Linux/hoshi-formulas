downloads() {
  tar xpf $downloads/libpsl-0.21.5.tar.gz
}

build() {
  cd libpsl-0.21.5

  mkdir -pv build ; cd build

  meson setup --prefix=$dest/usr \
    --buildtype=release

  ninja -j`nproc` && \
    ninja install
}

