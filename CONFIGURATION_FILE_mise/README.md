# INSTALLATION MAC
```
brew install mise
eecho 'eval "$(mise activate zsh)"' >> ~/.zshrc
source ~/.zshrc
```

# INSTALLATION LINUX
```
curl https://mise.jdx.dev/install.sh | sh
echo 'eval "$(mise activate bash)"' >> ~/.bashrc
source ~/.bashrc
```

# COPY CONFIGURATION
1) Prerequisuite: You should have locally mise.toml file  
```
[tools]
terraform = "1.6.6"
kubectl = "1.29.2"
helm = "3.14.2"
awscli = "2.15.10"
k9s = "0.32.4"
node = "20"
python = "3.12"
go = "1.22"
flux2 = "2.4.0"
argocd = "2.12.5"
istioctl = "1.28.4"
neovim = "0.11.5"
```

2) Copy config
```
mkdir -p ~/.config/mise
cp mise.toml ~/.config/mise/config.toml
```

3) Install globally
```
cd ..  # To not stay in the same directory from which you copied mise.toml
mise install
```

Check if packages are installed  
jkb91@MacBook-Air-Klaudia mise_config % mise ls

```
jkb91@MacBook-Air-Klaudia mise_config % mise ls
Tool       Version  Source                    Requested 
awscli     2.15.10  ~/mise_config/.mise.toml  2.15.10
go         1.22.12  ~/mise_config/.mise.toml  1.22
python     3.12.12  ~/mise_config/.mise.toml  3.12
terraform  1.6.6    ~/mise_config/.mise.toml  1.6.6
```

Activation GLOBALLY 
```
mise use -g terraform@1.6.6 awscli@2.15.10 python@3.12.12 go@1.22.12

```
