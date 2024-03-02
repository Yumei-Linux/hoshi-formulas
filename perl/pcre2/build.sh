downloads() {
  tar xpf $downloads/pcre2-10.42.tar.bz2
}

build() {
  cd pcre2-10.42

  ./configure --prefix=/usr \
    --docdir=/usr/share/doc/pcre2-10.42 \
    --enable-unicode \
    --enable-jit \
    --enable-pcre2-16 \
    --enable-pcre2-32 \
    --enable-pcre2grep-libz \
    --enable-pcre2grep-libbz2 \
    --enable-pcre2test-libreadline \
    --disable-static

  make -j`nproc` && \
    make DESTDIR=$dest install
}

