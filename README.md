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
ln -s "$PWD/atom/config.cson" ~/.atom
ln -s "$PWD/atom/init.coffee" ~/.atom
ln -s "$PWD/atom/keymap.cson" ~/.atom
ln -s "$PWD/atom/snippets.cson" ~/.atom
ln -s "$PWD/atom/styles.less" ~/.atom
```

```bash
# export packages
apm list --installed --bare > packages.list

# re-install packages from export
apm install --packages-file packages.list
```
