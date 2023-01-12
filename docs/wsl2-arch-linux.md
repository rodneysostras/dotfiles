# Arch linux WSL2

## Download

- https://github.com/yuk7/ArchWSL

## Instalação

- https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/

## Instalação Docker

```
# Instalação do docker
sudo pacman -S docker docker-compose base-devel
# Adicionar o usuário no grupo docker
sudo usermod -aG docker $USER
# Conferir os groups
groups
```

- Configurando o dockerd
Crie o arquivo `/mnt/wsl/shared-docker/docker.sock` com seguinte conteudo
```
DOCKER_DIR=/mnt/wsl/shared-docker
mkdir -pm o=,ug=rwx "$DOCKER_DIR"
sudo chgrp docker "$DOCKER_DIR"
```

- Configurando o daemon
Crie o arquivo `/etc/docker/daemon.json` com seguinte conteudo
```
{
  "hosts": ["unix:///mnt/wsl/shared-docker/docker.sock"]
}
```

- Testando o funcionamento
Execute o comando `sudo dockerd` e verifique na linha `API listen on ....` se esta o caminho que foi configurado para dockerd

Para criar um container hello workd e testar seu funcionamento execute o comando abaixo
```
docker -H unix:///mnt/wsl/shared-docker/docker.sock run --rm hello-world
```

- Dando permissão ao dockerd para não precisar digitar a senha
Acesse o arquivo sudores com o seguinte comando `sudo visudo` caso falhe utilize assim `sudo EDITOR=vim visudo`

Adicione a seguinte linha
```
%docker ALL=(ALL)  NOPASSWD: /usr/bin/dockerd
```

## Configurando Windows

- Criando alias no Powershell para acessar o docker dentro do wsl
Execute o seguinte comando `echo $PROFILE` para encontrar o arquivo de perfil, crie ou edite esse arquivo adicionando seguinte conteudo
```
$DOCKER_DISTRO = "Arch"
function docker {
    wsl -d $DOCKER_DISTRO docker -H unix:///mnt/wsl/shared-docker/docker.sock @Args
}
```
> No powershell executado como administrador insira o seguinte comando para dar previlegios `Set-ExecutionPolicy RemoteSigned`

- Para criar alias para prompt de comando
Criei o seguinte arquivo em `%USERPROFILE%\tools` e adicione esse caminho no PATH da variaveis de usuário (variaveis de ambiente para sua cotna).
```
@echo off
set DOCKER_DISTRO=Arch

wsl -d %DOCKER_DISTRO% docker -H unix:///mnt/wsl/shared-docker/docker.sock %*
```

# tools
sudo pacman -Sy --noconfirm wget curl htop bat exa

# yay
pacman -S --needed git base-devel && cd /tmp && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# ZSH

sudo pacman -S zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

yay -Sy --noconfirm zsh-theme-powerlevel10k-git zsh-syntax-highlighting-git zsh-autosuggestions-git zsh-completions-git


# hd-vrtual
Set-ExecutionPolicy RemoteSigned

Mount-VHD -PATH "D:\WSL\disk\wsl-shared-disk.vhdx" -PassThru

wmic diskdrive list brief

wsl --mount \\.\PHYSICALDRIVE2

- verificar disk
lsblk
- formatar disco
sudo mkfs.ext4 /dev/{DISK_NAME}
sudo chown -R administrator:administrator /mnt/wsl/PHYSICALDRIVE2

- asdf
sudo pacman -Sy --noconfirm curl git && cd /tmp && git clone https://aur.archlinux.org/asdf-vm.git && cd asdf-vm && makepkg -si
source /opt/asdf-vm/asdf.sh
asdf plugin add nodejs
asdf plugin add python
asdf plugin add golang

asdf install nodejs 18.12.0
asd install python 3.11.0

asdf global nodejs latest


ip addr show eth0 | grep 'inet\b' | awk '{print $2}' | cut -d/ -f1
ip addr show eth0 | grep 'inet6\b' | awk '{print $2}' | cut -d/ -f1
