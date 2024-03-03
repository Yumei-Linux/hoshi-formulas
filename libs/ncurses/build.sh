downloads() {
  tar xpf $downloads/ncurses-6.4.tar.gz
}

build() {
  cd ncurses-6.4

  ./configure --prefix=/usr \
    --mandir=/usr/share/man/ \
    --with-shared \
    --without-debug \
    --without-normal \
    --with-cxx-shared \
    --enable-pc-files \
    --enable-widec \
    --with-pkg-config-libdir=/usr/lib/pkgconfig

  local temp_dest=${PWD}/dest

  make -j`nproc` && \
    make DESTDIR=$temp_dest install

  install -vm755 $temp_dest/usr/lib/libncursesw.so.6.4 $dest/usr/lib

  rm -v $temp_dest/usr/lib/libncursesw.so.6.4

  sed -e 's/^#if.*XOPEN.*$/#if 1/' \
      -i $temp_dest/usr/include/curses.h

  cp -av $temp_dest/* $dest

  for lib in ncurses form panel menu; do
    ln -svf lib${lib}w.so $dest/usr/lib/lib${lib}.so
    ln -svf ${lib}w.pc $dest/usr/lib/pkgconfig/${lib}.pc
  done

  ln -svf libncursesw.so $dest/usr/lib/libcurses.so

  test -d $dest/usr/share/doc/ncurses-6.4 || \
    mkdir -p $dest/usr/share/doc/ncurses-6.4

  cp -v -R doc -T $dest/usr/share/doc/ncurses-6.4
}

