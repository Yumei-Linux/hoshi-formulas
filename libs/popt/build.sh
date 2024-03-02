downloads() {
  tar xpf $downloads/popt-1.19.tar.gz
}

build() {
  cd popt-1.19

  ./configure --prefix=$dest/usr \
    --disable-static

  make -j`nproc` && make install
}

