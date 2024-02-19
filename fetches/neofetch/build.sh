downloads() {
  unzip $downloads/master.zip
}

build() {
  cd neofetch-master
  make PREFIX=$dest/usr install
}
