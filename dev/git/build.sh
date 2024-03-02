downloads() {
  unzip $downloads/master.zip
}

build() {
  cd git-master

  make configure

  ./configure --prefix=/usr \
    --docdir=/usr/share/doc/git

  make -j`nproc` all && \
    make DESTDIR=$dest install
}

