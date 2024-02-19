downloads() {
  tar xpvf $downloads/lm-sensors-3-6-0.tar.gz
}

build() {
  cd lm-sensors-3-6-0

  make -j`nproc` PREFIX=$dest/usr \
    BUILD_STATIC_LIB=0 \
    MANDIR=$dest/usr/share/man

  make PREFIX=$dest/usr \
    BUILD_STATIC_LIB=0 \
    MANDIR=$dest/usr/share/man install

  install -v -m755 -d /usr/share/doc/lm_sensors-3-6-0

  cp -rvf README INSTALL doc/* \
    /usr/share/doc/lm_sensors-3-6-0
}

