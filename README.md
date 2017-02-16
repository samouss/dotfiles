## Dotfiles

### Atom

```bash
# export packages
apm list --installed --bare > packages.list

# re-install packages from export
apm install --packages-file packages.list
```
