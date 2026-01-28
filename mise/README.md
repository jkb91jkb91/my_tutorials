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

Instalacja
```
mise install
```
