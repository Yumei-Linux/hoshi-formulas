downloads() {
  unzip $downloads/main.zip
}

build() {
  cd cutefetch-main
  make DESTDIR=$dest/usr/bin
  make DESTDIR=$dest/usr/bin install
}
