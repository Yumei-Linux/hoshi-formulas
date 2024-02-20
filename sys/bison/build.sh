downloads() {
  tar xpvf $downloads/bison-3.8.tar.xz
}

build() {
  cd bison-3.8

  ./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/bison-3.8

  make -j`nproc`
  make DESTDIR=$dest install
}

