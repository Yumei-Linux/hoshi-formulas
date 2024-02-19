downloads() {
  tar xpvf $downloads/htop-3.3.0.tar.xz
}

build() {
  cd htop-3.3.0
  ./autogen.sh
  ./configure --prefix=$dest/usr
  make -j`nproc` && make install
}

