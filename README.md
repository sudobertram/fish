# Fish Terminal Setup

## Install Fish

Debian/Ubuntu:
```bash
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install fish
```

Fedora:
```bash
sudo dnf install fish
```

Arch:
```bash
sudo pacman -S fish
```

### Set Fish as default

```bash
chsh -s $(which fish)
```

### Config file

```bash
cd ~/.config/fish
git clone https://github.com/sudobertram/config.fish.git .
source ~/.config/fish/config.fish
```

### Fish Customization

```bash
fish_config
```

### Install OMF

```bash
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
```

Set theme
```bash
omf install bobthefish
omf theme bobthefish
```

#### if the omf theme is not displayed in the terminal after installing it

```bash
omf remove bobthefish
omf destroy
```
This will uninstall all plugins? YES
If it asks something about a copy, select no

```bash
cd .config/fish/functions/
```

Delete all files in that directory. There may be a copy, and there is likely a fish_prompt.fish
deleting everything here I think was key

Install omf again
```bash
curl -L https://get.oh-my.fish | fish
omf install bobthefish
omf theme bobthefish
```

