downloads() {
  tar xpvf $downloads/hello-2.12.tar.gz
}

build() {
  cd hello-2.12
  ./configure --prefix=$dest/usr
  make -j`nproc`
  make install
}

