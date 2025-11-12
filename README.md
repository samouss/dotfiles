## Dotfiles

### brew

```
brew bundle
```

```
brew bundle dump
```

### git

Credentials are stored in `~/.gitconfig.local`

```bash
ln -s "$PWD/git/.gitconfig" ~/.gitconfig
```

```bash
touch ~/.gitconfig.local
```

```
[url "https://$TOKEN:x-oauth-basic@github.com/"]
	insteadOf = https://github.com/
```

### ZSH

```bash
ln -s "$PWD/zsh/.zshrc" ~/.zshrc
```

### VSCode

Turn on "Settings Sync".

### iTerm

Turn on the preferences from a custom folder:

```
Settings > General > Preferences
```

### Sketch

```
ln -s "$PWD/sketch/.sketch" ~/.sketch
chmod +x ~/.sketch
```

> https://www.sketch.com/updates/#version-53.2
