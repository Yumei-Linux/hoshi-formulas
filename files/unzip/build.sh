downloads() {
  tar xpvf $downloads/unzip60.tar.gz
  mv $downloads/unzip-6.0-consolidated_fixes-1.patch $build_dir/unzip60
}

build() {
  cd unzip60
  patch -Np1 -i ./unzip-6.0-consolidated_fixes-1.patch

  make -f unix/Makefile generic -j`nproc`

  make prefix=$dest/usr MANDIR=$dest/usr/share/man/man1 \
    -f unix/Makefile install
}

