downloads() {
  tar xpf $downloads/libpng-1.6.28.tar.xz
  mv $downloads/libpng-1.6.28-apng.patch.gz $build_dir/libpng-1.6.28
}

build() {
  cd libpng-1.6.28

  gzip -cd ./libpng-1.6.28-apng.patch.gz | patch -p0

  LIBS=-lpthread ./configure \
    --prefix=$dest/usr \
    --disable-static

  make -j`nproc` && make install

  # installing documentation
  mkdir -pv $dest/usr/share/doc/libpng-1.6.28
  cp -v README libpng-manual.txt $dest/usr/share/doc/libpng-1.6.28
}

