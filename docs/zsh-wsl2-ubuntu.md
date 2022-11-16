# 📄 ZSH com Ubuntu no WSL2

Oh My Zsh é uma alternativa ao shell padrão ele facilita o uso do shell com configurações e scripts personalizados para automatizar operações, com isso melhorando a produtividade.

> Veja este [tutorial](./wsl2-ubuntu.md) para saber como utilizar uma distribuição linux no WSL2.

Com este comando abaixo iremos instalar o pré-requisito.

```bash
sudo apt-get install curl zsh
```

> O comando abaixo e um utilitário oficial da ZSH para ajudar na ativação e configuração.
> ```bash
> sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
> ```
>> Note que esse recurso renomeia o arquivo existente `.zshrc` para `.zshrc.pre-oh-my-zsh`

Para ativar

## Plugins ZSH

<details>
<summary><b>zsh-autosuggestions</b></summary>
Este Plugin possui recurso de sugestões automáticas de comandos.

Para instalar execute o comando abaixo.

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

</details>

<details>
<summary><b>zsh-syntax-highlighting</b></summary>
Este Plugin possui recurso para destacar os comandos enquanto eles são digitados.

Para instalar execute o comando abaixo.

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

</details>

## Temas ZSH

<details>
<summary><b>powerlevel10k</b></summary>
Modifica o tema do Oh My Zsh.

Para instalar execute o comando abaixo.

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Agora com este comando altera a configuração para utilizar este tema.

```bash
sed -i 's/_THEME=\"robbyrussell\"/_THEME=\"powerlevel10k\/powerlevel10k\"/g' ~/.zshrc
```

Reinicie o Zsh com `exec zsh` e `p10k configure` para iniciar o assistente de configuração.

E necessário instalar pacote de fonte da [powerline font](https://github.com/powerline/fonts).

</details>



Execute este comando para recarregar o shell e aplicar as mudanças.
```bash
source ~/.zshrc
```

## Utilitários

<details>
<summary><b>batcat</b></summary>
Tem a mesma função do `cat` de mostra conteúdo de um arquivo sendo de uma forma mais elegante.

Execute este comando para realizar instalação.

```bash
sudo apt install bat
```

> Você pode utiliza-lo pelo comando `batcat` ou criar um alias para modificar o cat.
</details>

<details>
<summary><b>exa</b></summary>
Tem a mesma funcionalidade do `ls` de mostrar informações sobre o diretório ou arquivos sendo de uma forma mais elegante.

### Pré-requisitos

Executando este comando irá instalar os requisitos necessário para instalação do exa
```bash
sudo apt install unzip
```

```bash
EXA_VERSION=$(curl -s "https://api.github.com/repos/ogham/exa/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -Lo /tmp/exa.zip "https://github.com/ogham/exa/releases/latest/download/exa-linux-x86_64-v${EXA_VERSION}.zip"
sudo unzip -q /tmp/exa.zip bin/exa -d /usr/local
rm -rf /tmp/exa.zip
```

> Você pode utiliza-lo pelo comando `exa` ou criar um alias para modificar o ls.
</details>

<br />

## 🦸 Autor

<table align="left">
  <tr>
    <td align="center">
      <a href="#">
        <img src="https://github.com/rodneysostras.png" width="150px;" alt="Foto do Rodney Sostras no GitHub"/><br>
        <sub>
          <b>Rodney Sostras</b>
        </sub>
      </a>
    </td>
  </tr>
</table>
<p>
    &nbsp;&nbsp;
    <a href="https://github.com/rodneysostras">
        <img src="https://img.shields.io/badge/rodneysostras-000000?style=for-the-badge&logo=GitHub&logoColor=FFF" />
    </a>
</p>
<p>
    &nbsp;&nbsp;
    <a href="https://linkedin.com/in/rodney-sostras" alt="Linkedin do Rodney Sostras">
        <img src="https://img.shields.io/badge/-rodney--sostras-0077B5?style=for-the-badge&logo=Linkedin&logoColor=FFF"/>
    </a>
</p>
<p>&nbsp;&nbsp;
    <a href="mailto:rodney.sostras@gmail.com" alt="Email do Rodney Sostras">
        <img src="https://img.shields.io/badge/-rodney.sostras@gmail.com-D14836?style=for-the-badge&logo=Gmail&logoColor=FFF" />
    </a>
</p>
<p>&nbsp;&nbsp;
    <a href="https://rodneysostras.me/" alt="Web Site do Rodney Sostras">
        <img src="https://img.shields.io/badge/%F0%9F%8C%8E%20RODNEYSOSTRAS.ME%20-191919?style=for-the-badge" />
    </a>
</p>

<br />


## 📝 Licença

Este projeto esta sobe a licença [MIT](https://raw.githubusercontent.com/git/git-scm.com/main/MIT-LICENSE.txt).

Feito com ❤️ por Rodney Sostras 👋🏽 [Entre em contato!](https://www.linkedin.com/in/rodney-sostras/)

<br />

<div align="right"><a href="#">Voltar ao topo ⬆</a></div>