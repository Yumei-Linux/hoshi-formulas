downloads() {
  unzip $downloads/master.zip
}

build() {
  cd git-master

  make configure

  ./configure --prefix=$dest/usr \
    --docdir=$dest/usr/share/doc/git

  make -j`nproc` all && \
    make install
}

