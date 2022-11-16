export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

if [ -d /usr/share/zsh-theme-powerlevel10k/ ]; then
    ZSH_THEME="powerlevel10k/powerlevel10k"
    source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
fi

plugins=(git
    zsh-autosuggestions
    zsh-syntax-highlighting
    asdf
    ssh-agent
)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

[[ -f ~/.alias ]] && source ~/.alias

if [ -d ~/.zfuncs ]; then
    for function in ~/.zfuncs/*; do
        source $function
    done
fi

# Inicia o daemon do Docker automaticamente ao efetuar login se não estiver em execução.
DOCKER_DISTRO="Arch"
DOCKER_DIR=/mnt/wsl/shared-docker
DOCKER_SOCK="$DOCKER_DIR/docker.sock"
export DOCKER_HOST="unix://$DOCKER_SOCK"

RUNNING_DOCKER=`ps aux | grep dockerd | grep -v grep`
if [ -z "$RUNNING_DOCKER" ]; then
    if [ ! -S "$DOCKER_SOCK" ]; then
        mkdir -pm o=,ug=rwx "$DOCKER_DIR"
        chgrp docker "$DOCKER_DIR"
        /mnt/c/Windows/System32/wsl.exe -d $DOCKER_DISTRO sh -c "nohup sudo -b dockerd < /dev/null > $DOCKER_DIR/dockerd.log 2>&1"
    fi
fi

[[ -d /opt/asdf-vm ]] && source /opt/asdf-vm/asdf.sh

eval `ssh-agent -s` > /dev/null
