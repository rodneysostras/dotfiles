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
export DOCKER_SOCKET="$DOCKER_DIR/docker.sock"
export DOCKER_HOST="unix://$DOCKER_SOCKET"

RUNNING_DOCKER=`ps aux | grep dockerd | grep -v grep`
if [ -z "$RUNNING_DOCKER" ]; then
    if [ ! -S "$DOCKER_HOST" ]; then
        mkdir -pm o=,ug=rwx "$DOCKER_DIR"
        chgrp docker "$DOCKER_DIR"
        /mnt/c/Windows/System32/wsl.exe -d $DOCKER_DISTRO sh -c "nohup sudo -b dockerd --dns 1.1.1.1 < /dev/null > $DOCKER_DIR/dockerd.log 2>&1"
    fi
fi

# export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
export WSL_HOST=172.19.64.1

export PATH="$PATH:/mnt/c/Users/Rodney/AppData/Local/Programs/Microsoft VS Code/bin"

[[ $(command -v direnv) ]] && eval "direnv hook zsh" > /dev/null

[[ -d /opt/asdf-vm ]] && source /opt/asdf-vm/asdf.sh

[[ -d ~/bin/Sencha ]] && export PATH=$PATH:$HOME/bin/Sencha/Cmd/4.0.5.87/sencha

[[ -d ~/go ]] && export PATH=$PATH:$HOME/go/bin

[[ -d ~/.dotnet ]] && export PATH="$PATH:$HOME/.dotnet/tools"
[[ -d ~/.dotnet ]] && export PATH="$PATH:$HOME/.dotnet"
[[ -d ~/.dotnet ]] && export DOTNET_ROOT="$HOME/.dotnet"  

[[ -d /var/lib/snapd/snap/bin ]] && export PATH=$PATH:/var/lib/snapd/snap/bin

[[ -d ~/.local/bin ]] && export PATH=$PATH:$HOME/.local/bin

if [[ -d /usr/lib/jvm/java-17-openjdk ]]; then
    export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
    export PATH="$PATH:$JAVA_HOME/bin"
fi

if [[ -d ~/android-sdk-tools  ]]; then
    export PATH="$PATH:$HOME/android-sdk-tools:$HOME/android-sdk-tools/bin"
    export PATH="$PATH:$HOME/.android/platform-tools"
    export ANDROID_HOME="$HOME/.android"
    export ANDROID_SDK_ROOT="$HOME/.android"
    export REPO_OS_OVERRIDE="linux"

#    adb kill-server 2> /dev/null
    export ADB_SERVER_SOCKET=tcp:$WSL_HOST:5037
fi

eval `ssh-agent -s` > /dev/null

