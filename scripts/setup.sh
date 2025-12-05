# Skrypt do konfiguracji środowiska użytkownika.
# Główne kroki:
# 1. Klonowanie repozytorium dotfiles do ~/Developer/dotfiles_ansible
# 2. Instalacja Homebrew (potrzebne do dalszych instalacji)
# 3. Instalacja Ansible na macOS
# 4. Uruchomienie playbooka Ansible poprzez scripts/common/ansible.sh --all
#!/usr/bin/env bash

set -euoE pipefail
# zatrzymaj skrypt przy błędach, nieużytych zmiennych i błędach w potokach

# Definicje zmiennych określających źródło repozytorium (GitHub + branch),
# miejsce rozpakowania (/tmp/.dotfiles) oraz sposób rozpakowania tarballa.
# shellcheck disable=SC2086
cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source="https://github.com/qubus79/dotfiles"
branch="${branch:-main}"
tarball="$source/tarball/$branch"
# Docelowy katalog, w którym tymczasowo umieszczane jest repo ansible/dotfiles.
# Dzięki przeniesieniu go do ~/Developer można go łatwo usunąć po zakończeniu instalacji.
target="$HOME/Developer/dotfiles_ansible"
tar_cmd="tar -xzv -C $target --strip-components=1 --exclude='{.gitignore}'"


# Wyświetla pomoc i opis dostępnych argumentów skryptu.
display_help() {
  echo "Usage: ./setup.sh [arguments]..."
  echo
  echo "  --deps              install deps for linux"
  echo "  --brew              install brew for linux/macos"
  echo "  --ansible           execute ansible for linux/macos"
  echo "  --all               setup everything"
  echo "  -h, --help          display this help message"
  echo
}

# Wyświetla pomoc i kończy działanie skryptu z komunikatem błędu.
exit_help() {
  display_help
  echo "Error: $1"
  exit 1
}

# Pomocnicze funkcje do wykrywania systemu (macOS / Linux).
macos() { test "$(uname -s)" == "Darwin"  && return 0; }
linux() { test "$(uname -s)" == "Linux"  && return 0; }

# Sprawdza, czy dany program jest dostępny w PATH.
is_executable() { type "$1" > /dev/null 2>&1; }

# Pobiera repozytorium dotfiles do katalogu docelowego, używając git/curl/wget.
download_repository() {
  # git jest preferowaną metodą klonowania
  if is_executable "git"; then
    cmd="git clone -b $branch $source $target"
  # curl i wget to metody awaryjne, pobierające tarball i rozpakowujące go
  elif is_executable "curl"; then
    cmd="curl -#L $tarball | $tar_cmd"
  elif is_executable "wget"; then
    cmd="wget --no-check-certificate -O - $tarball | $tar_cmd"
  fi

  # brak git/curl/wget - brak możliwości pobrania repo, skrypt przerywa działanie
  if test -z "$cmd"; then
    exit_help "No git, curl or wget available. Aborting."
  else
    mkdir -p "$target"
    eval "$cmd"
  fi
}

# Główna ścieżka instalacji: pobranie repo, instalacja Homebrew, zależności i uruchomienie Ansible.
setup_all() {
  # Repozytorium jest pobierane do /tmp/.dotfiles tylko jeśli jeszcze go nie ma
  test -d "$target" || download_repository
  # Homebrew musi być zainstalowany jako pierwszy, bo jest potrzebny do dalszych instalacji (w tym Ansible)
  echo "🚀 [homebrew] install"
  "${target}/scripts/common/install_brew.sh" # moved up beacuse homebrew needed to install ansible on linux
  if linux; then
    # Instalacja podstawowych pakietów systemowych potrzebnych do Ansible i dalszych narzędzi na Linuxie
    echo "🚀 [ansible] install with essential dependencies"
    "${target}/scripts/linux/install_dependencies.sh"
    # Dodanie dodatkowych repozytoriów pakietów (PPA / źródła zewnętrzne) na Linuxie
    echo "🚀 Additional software install"
    "${target}/scripts/linux/add_repositories.sh"
  fi
  if macos; then
    # Na macOS Ansible jest instalowany przez Homebrew, po uprzednim zainstalowaniu Homebrew
    echo "🚀 [ansible] installing..."
    brew install ansible
    echo "✅ [ansible] installed"
  fi
  # W tym momencie uruchamiamy playbook Ansible, który instaluje resztę pakietów (brew, caski, fonty, Zsh, Neovim, Tmux itd.)
  echo "🚀 [ansilbe] playbook run"
  "${target}/scripts/common/ansible.sh" --all
}

# Obsługuje opcje linii poleceń (np. tylko deps, tylko brew, tylko ansible, lub pełne --all)
while [[ $# -gt 0 ]]; do
  arg=$1
  case $arg in
    -h | --help)
      display_help
      exit 0
      ;;
    --deps)
      # uruchamia tylko instalację zależności na Linuxie (bez pełnego setupu)
      "${cwd}/linux/install_dependencies.sh"
      ;;
    --brew)
      # uruchamia tylko instalację Homebrew na Linuxie/macOS
      "${cwd}/common/install_brew.sh"
      ;;
    --ansible)
      # uruchamia tylko playbook Ansible
      "${cwd}/common/ansible.sh"
      ;;
    --all)
      # uruchamia pełny proces setupu (pobranie repo, brew, deps, ansible)
      setup_all
      ;;
    *)
      exit_help "Unknown argument: $arg"
      ;;
  esac
  shift
done
