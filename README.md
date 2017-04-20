## Dotfiles

### git

```bash
ln -s "$PWD/git/.gitconfig" ~/.gitconfig
```

### oh-my-zsh

```bash
cp zsh/.zshrc ~/.zshrc
```

### Atom

```bash
# export packages
apm list --installed --bare > packages.list

# re-install packages from export
apm install --packages-file packages.list
```
