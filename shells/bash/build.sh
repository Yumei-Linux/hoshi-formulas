downloads() {
  tar xpvf $downloads/bash-5.2.tar.gz
}

build() {
  cd bash-5.2

  ./configure
    --prefix=/usr \
    --without-bash-malloc \
    --with-curses

  make -j`nproc` && \
    make DESTDIR=$dest install
}
