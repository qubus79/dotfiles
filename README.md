# Dotfiles

Fully automated development environment. Read the full documentation
[here](https://oponomarov.com).

[![macos](https://github.com/shmileee/dotfiles/actions/workflows/macos.yaml/badge.svg)](https://github.com/shmileee/dotfiles/actions/workflows/macos.yaml)
[![docker](https://github.com/shmileee/dotfiles/actions/workflows/docker.yaml/badge.svg)](https://github.com/shmileee/dotfiles/actions/workflows/docker.yaml)

## Installation

Install everything with single `git clone` command:

```shell
git clone https://github.com/qubus79/dotfiles.git ~/dotfiles && bash ~/dotfiles/scripts/setup.sh --all
```

You can remove existing ~/.dotfiles folder and `git clone` it from Github again with:

```shell
git clone https://github.com/qubus79/dotfiles
/dotfiles/scripts/setup.sh --all
```

```shell
TO NIE DZIAŁA - do zmiany 
curl -fsSL https://github.com/qubus79/dotfiles/scripts/setup.sh | sh -s -- --all
```

## Running Inside Docker

Run `docker run -it shmileee/dotfiles` to spawn a docker container which is
automatically [built and
pushed](https://github.com/shmileee/dotfiles/actions/workflows/docker.yaml) with
GitHub Actions or build your own:

```bash
# docker buildx build --platform linux/amd64 -t dotfiles --progress plain .
```

## Installation Flow

```
   ┌────────────────────────────────────────────┐
┌──┤curl -fsSL oponomarov.com/d | sh -s -- --all│
│  └────────────────────────────────────────────┘
│
│
│     ┌─────────────────────────────────────┐
├───► │git clone qubus79/dotfiles.git /tmp  │
│     └─────────────────────────────────────┘
│
│
│     ┌──────────────────┐
├───► │./install_brew.sh │
│     └──────────────────┘
│
│
│     ┌─────────────────────────┐     ┌──────────────────────────┐
├───► │./install_dependencies.sh├────►│ apt install <essentials> │
│     └─────────────────────────┘     └──────────────────────────┘
│
│
│     ┌──────────────────────┐
├───► │./add_repositories.sh │
│     └──────────────────────┘
│
│
│     ┌────────────┐
└───► │./ansible.sh│
      └─────┬──────┘
            │
   ┌────────┘
   │
   │  ┌─────────────────────────┐
   ├─►│install community.general│
   │  └─────────────────────────┘
   │
   │  ┌──────────────────────────┐
   │  │ prompt for password if   │
   ├─►│ sudo is not passwordless │
   │  └──────────────────────────┘
   │
   │  ┌───────────────────────────────┐
   └─►│ansible-playbook ... main.yaml │
      └───────────────┬───────────────┘
                      │
     ┌────────────────┘
     │                 ┌────────────────────────┐
     │  ┌──────┐       │ brew install <packages>│
     ├─►│common├──────►│ brew install <casks>   │
     │  └──────┘       │ apt install <packages> │
     │                 └────────────────────────┘
     │  ┌───────┐
     ├─►│ fonts │      ┌─────────────────────┐
     │  └───────┘      │change default shell │
     │              ┌─►│install .ohmyzsh     │
     │  ┌─────┐     │  │install powerlevel10k│
     ├─►│ zsh ├─────┘  │install zsh plugins  │
     │  └─────┘        └─────────────────────┘
     │                 
     │  ┌──────┐       ┌──────────────────────┐
     ├─►│neovim├─────┐ │ either:              │
     │  └──────┘     └►│  - build from source │
     │                 │  - install binary    │
     │  ┌──────┐       └──────────────────────┘
     ├─►│ tmux ├─────┐ 
     │  └──────┘     │ ┌──────────────────────┐
     │               └►│install plugin manager│  
     │  ┌──────────┐   │install plugins       │   
     ├─►│ dotfiles ├─┐ └──────────────────────┘
     │  └──────────┘ │ 
     │               │ ┌─────────────────────────┐
     │               │ │ prepare .dotfiles folder│
                     └►│ `stow`.dotfiles         │
    ...                └─────────────────────────┘
     
     │
     │  ┌─────────────────┐
     └─►│ system_defaults │
        └───────┬─────────┘
                │          ┌───────────────────────────────┐
                ├─────────►│ defaults write <apps settings>│
                │          └───────────────────────────────┘
                │
                │          ┌────────────────────┐
                ├─────────►│reorder apps in dock│
                │          └────────────────────┘
                │
                │          ┌──────────────────────┐
                ├─────────►│set custom keybindings│
                │          └──────────────────────┘
                │
                │          ┌───────────────────────┐
                └─────────►│defaults write <system>│
                           └───────────────────────┘
```

## Credits

This repository is hugely inspired by [shmileee dotfiles](https://github.com/shmileee/dotfiles) repository.

Many thanks to the [dotfiles community](https://dotfiles.github.io).
