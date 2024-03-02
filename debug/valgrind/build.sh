downloads() {
  tar xpvf $downloads/valgrind-3.22.0.tar.bz2
}

build() {
  cd valgrind-3.22.0

  sed -i 's|/doc/valgrind||' docs/Makefile.in

  ./configure --prefix=$dest/usr \
    --datadir=$dest/usr/share/doc/valgrind-3.22.0

  make -j`nproc` && make install
}

