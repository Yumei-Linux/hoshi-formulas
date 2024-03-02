downloads() {
  tar xpf $downloads/rsync-3.2.7.tar.gz
}

build() {
  cd rsync-3.2.7

  ./configure --prefix=$dest/usr \
    --disable-lz4 \
    --disable-xxhash \
    --without-included-zlib

  make -j`nproc` && make install
}

