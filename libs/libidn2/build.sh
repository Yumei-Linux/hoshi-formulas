downloads() {
  tar xpvf $downloads/libidn2-2.3.7.tar.gz
}

build() {
  cd libidn2-2.3.7

  ./configure --prefix=$dest/usr \
    --disable-static

  make -j`nproc` && \
    make install
}

