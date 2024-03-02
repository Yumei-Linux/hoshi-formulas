downloads() {
  tar xpf $downloads/slang-2.3.1.tar.bz2
}

build() {
  cd slang-2.3.1

  ./configure --prefix=$dest/usr \
    --sysconfdir=$dest/etc/ \
    --with-readline=gnu

  make -j1

  # installing the package
  make install_doc_dir=$dest/usr/share/doc/slang-2.3.1 \
    SLSH_DOC_DIR=$dest/usr/share/doc/slang-2.3.1/slsh \
    install-all

  # appropiate permissions
  chmod -v 755 $dest/usr/lib/libslang.so \
    $dest/usr/lib/slang/v2/modules/*.so
}

