#!/usr/bin/env bash

cd $(dirname $0)

. .internal/logging.sh

dirname="$1"
flag="$2"

if [[ "$dirname" == "" ]] || ! test -d "$dirname"; then
  error "Invalid directory to register"
fi

register_copy() {
  info "Registering a local copy of ${COLOR_GREEN}${dirname}${COLOR_RESET} at the formulas dir"

  category=$(echo $1 | awk -F'/' '{print $(NF-1)}')
  package=$(echo $1 | awk -F'/' '{print $NF}')

  if [[ "$flag" == "-f" ]]; then
    rm -rf "/var/lib/hoshi/hoshi-formulas/$category/$package"
  fi

  if test -d "/var/lib/hoshi/hoshi-formulas/$category/$package"; then
    error "Package ${COLOR_GREEN}$category/$package${COLOR_RESET} already exists"
  fi

  cp -rf "$1" "/var/lib/hoshi/hoshi-formulas/$category/$package"

  if [[ "$(cat .gitignore | grep "$category/$package")" == "" ]]; then
    echo "$category/$package" >> .gitignore
  fi

  success "Package ${COLOR_GREEN}$category/$package${COLOR_RESET} registered"
}

unregister_copy () {
  info "Unregistering a local copy of ${COLOR_GREEN}${dirname}${COLOR_RESET} at the formulas dir"

  category=$(echo $1 | awk -F'/' '{print $(NF-1)}')
  package=$(echo $1 | awk -F'/' '{print $NF}')

  if ! test -d "/var/lib/hoshi/hoshi-formulas/$category/$package"; then
    error "Package ${COLOR_GREEN}$category/$package${COLOR_RESET} does not exists"
  fi

  rm -rf "/var/lib/hoshi/hoshi-formulas/$category/$package"

  if [[ "$(cat .gitignore | grep "$category/$package")" != "" ]]; then
    sed -i "/$category\/$package/d" .gitignore
  fi

  success "Package ${COLOR_GREEN}$category/$package${COLOR_RESET} unregistered"
}

if [[ "$flag" == "register" || "$flag" == "" ]]; then
  register_copy "$(echo "$dirname" | sed 's/\/$//g')"
elif [[ "$flag" == "unregister" ]]; then
  unregister_copy "$(echo "$dirname" | sed 's/\/$//g')"
else
  error "Invalid flag"
fi

