downloads() {
  tar xpvf $downloads/bash-5.2.tar.gz
}

build() {
  cd bash-5.2
  ./configure --prefix=$dest/usr
  make -j`nproc`
  make install
}
