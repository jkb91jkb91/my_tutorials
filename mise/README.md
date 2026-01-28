MAC
```
brew install mise
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
```

LINUX
```
echo 'eval "$(mise activate bash)"' >> ~/.bashrc
```


Create .mise.toml file
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
```

Installation
```
mise install
```

Example of usecase 

```
jkb91@MacBook-Air-Klaudia mise_config % mise ls
Tool       Version  Source                    Requested 
awscli     2.15.10  ~/mise_config/.mise.toml  2.15.10
go         1.22.12  ~/mise_config/.mise.toml  1.22
python     3.12.12  ~/mise_config/.mise.toml  3.12
terraform  1.6.6    ~/mise_config/.mise.toml  1.6.6
```

```
mise which terraform
```
