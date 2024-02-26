COLOR_RED='\033[31m'
COLOR_BLUE='\033[34m'
COLOR_GREEN='\033[32m'
COLOR_YELLOW='\033[33m'
COLOR_MAGENTA='\033[35m'
COLOR_CYAN='\033[36m'
COLOR_RESET='\033[0m'

error() {
  echo -e "${COLOR_RED}error: ${COLOR_RESET}${@}"
  exit 1
}

info() {
  echo -e "${COLOR_BLUE}info: ${COLOR_RESET}${@}"
}

success() {
  echo -e "${COLOR_GREEN}success: ${COLOR_RESET}${@}"
}
