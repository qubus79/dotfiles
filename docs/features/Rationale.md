# Rationale
---

## Goal

Provide fully automated development environment that is easy to setup and
maintain.

## Why Ansible?

In my experience Ansible has the easiest learning curve. It has its own caveats
and gotchas, but overall it's pretty straightforward to read YAML configuration
for a person that knows very little about how Ansible works. It's almost like
reading plain English with very rare exceptions. Additionally, Ansible is a
Swiss army knife orchestration tool. You can use it and abuse it in many
different ways which might or might not be supported via other popular
solution like [NixOS Home Manager](https://nixos.wiki/wiki/Home_Manager)
otherwise. One of the biggest advantages of Ansible is that (if properly
described) tasks follow
[idempotency](https://docs.ansible.com/ansible/latest/reference_appendices/glossary.html#term-Idempotency)
principle, which means playbook can be run over and over again without having to
worry about your precious files accidentally being removed.

All in all - there are many automation solutions out there - I happen to enjoy
using Ansible.

## Why Chezmoi?

Chezmoi is another tool for managing dotfiles. It seems to be [the most
popular](https://dotfiles.github.io/utilities) choice these days with over 6k+
stars. Prior to switch, I've used GNU Stow which had it's job done but
unfortunately lacked a couple of features chezmoi tends to resolve. The most
important features of chezmoi:

- **Flexible**: dotfiles can be templates (using text/template syntax). While this
  can be achieved using Ansible builtin Jinja templates, - chezmoi provides a
  set of variables that can be used inside the template for simple assertions
  like the platform you're currently running on, architecture, hostname,
  environmental variables lookup and many more. Additionally, testing Jinja
  templates in Ansible is very cumbersome. With chezmoi this is as simple as
  running `chezmoi execute-template < file.tmpl`.
- **Portable**: chezmoi's configuration uses only visible, regular files and
  directories and so is portable across version control systems and operating
  systems.
- **Transparent**: chezmoi includes verbose and dry run modes so you can review
  exactly what changes it will make to your home directory before making them.
- **Practical**: chezmoi manages hidden files (dot files), directories, private, and
  executable files.
- **Fast, easy to use, and familiar**: chezmoi runs in fractions of a second and
  includes commands to make most operations trivial.

The biggest driver for choosing chezmoi was my intention to follow single
responsibility principle: dotfiles should be managed separately.