downloads() {
  tar xpf $downloads/libunistring-1.1.tar.xz
}

build() {
  cd libunistring-1.1

  ./configure --prefix=$dest/usr \
    --disable-static \
    --docdir=$dest/usr/share/doc/libunistring-1.1

  make -j`nproc` && \
    make install
}

