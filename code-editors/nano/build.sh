downloads() {
  tar xpf $downloads/nano-7.2.tar.xz
}

build() {
  cd nano-7.2

  ./configure --prefix=/usr \
              --sysconfdir=/etc \
              --enable-utf8 \
              --docdir=/usr/share/doc/nano-7.2 \
              --enable-nanorc

  make -j`nproc` && \
    make DESTDIR=$dest install

  install -Dvm644 doc/sample.nanorc $dest/etc/nanorc
}

