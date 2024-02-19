downloads() {
  tar xpvf $downloads/which-2.21.tar.gz
}

build() {
  cd which-2.21
  ./configure --prefix=$dest/usr
  make -j`nproc` && make install
}

