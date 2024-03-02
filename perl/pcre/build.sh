downloads() {
  tar xpf $downloads/download
}

build() {
  cd pcre-8.45

  ./configure --prefix=$dest/usr \
    --docdir=$dest/usr/share/doc/pcre-8.45 \
    --enable-unicode-properties \
    --enable-pcre16 \
    --enable-pcre32 \
    --enable-pcregrep-libz \
    --enable-pcregrep-libbz2 \
    --enable-pcretest-libreadline \
    --disable-static

  make -j`nproc` && make install

  mv -v $dest/usr/lib/libpcre.so.* $dest/lib
  ln -svf ../../lib/$(readlink $dest/usr/lib/libpcre.so) $dest/usr/lib/libpcre.so
}

