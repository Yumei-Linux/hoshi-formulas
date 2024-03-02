downloads() {
  tar xpf $downloads/wget-1.21.4.tar.gz
}

build() {
  cd wget-1.21.4

  ./configure --prefix=$dest/usr \
    --sysconfdir=$dest/etc \
    --with-ssl=openssl

  make -j`nproc` && \
    make install
}

