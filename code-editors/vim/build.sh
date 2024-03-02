downloads() {
  tar xpf $downloads/vim-9.1.0041.tar.gz
}

build() {
  cd vim-9.1.0041

  # define where the sys vimrc file will be located at
  echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h

  # configure
  ./configure --prefix=/usr \
    --with-features=huge \
    --enable-gui=no \
    --without-x

  # build and install
  make -j`nproc` && make DESTDIR=$dest install

  # make the documentation paths be consistent
  mkdir -pv $dest/usr/share/doc
  ln -svf ../vim/vim91/doc $dest/usr/share/doc/vim-9.1.0041

  # updating the runtime files
  echo "Updating the runtime files..."
  rsync -avzcP --exclude="/dos/" --exclude="/spell/" \
    ftp.nluug.nl::Vim/runtime/ ./runtime/

  # installing the runtime files
  make -C src installruntime DESTDIR=$dest

  # updating the help tags
  echo "Issue the command bellow to update the help tags:"
  echo "# vim -c ':helptags /usr/share/doc/vim-9.1.0041' -c ':q'"
}

