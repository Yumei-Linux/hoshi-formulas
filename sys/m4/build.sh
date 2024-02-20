downloads() {
  tar xpvf $downloads/m4-latest.tar.xz
}

build() {
  cd m4-1.4.19

  sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c
  echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h

  ./configure --prefix=$dest/usr

  make -j`nproc` && make install
}
