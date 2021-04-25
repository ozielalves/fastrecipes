<img src="assets\images\logo-oziel.svg" width="30" alt="logo" align="right">

# FastRecipe &middot; [![Flutter version](https://img.shields.io/badge/flutter-v1.22.6-blue?logo=flutter)](https://flutter.dev/docs/get-started/install) [![GitHub license](https://img.shields.io/github/license/filipegmedeiros/gatinhos_ufrn?color=blue)](http://www.apache.org/licenses/)

<div align="center">
<img src="assets\images\ui_preview.svg" alt="logo" align="center">
</div>

<br>

O aplicativo FastRecipe é desenvolvido utilizando [Flutter](https://flutter.dev/docs/get-started/install), um kit de ferramentas de IU do Google para a criação de aplicativos compilados de forma nativa para dispositivos mobile, web e desktop a partir de uma única base de código.

Para executar o projeto, faz-se necessária a instalação e configuração de pacotes e ferramentas, como flutter SDK, Android Studio e um emulador ou dispositivo Android.

Flutter depende da instalação completa do Android Studio para sanar as dependências da plataforma Android; Entretanto, você pode desenvolver aplicativos em flutter a partir de editores;

# Instalação

## Flutter, Android Studio

Siga os passos abaixo para instalação do [Flutter](https://flutter.dev/docs/get-started/install) de acordo com o seu sistema operacional.

### **Linux**

Existem 2 maneiras de instalar o SDK do flutter:<br>

1. Utilizando o **snapd** (Caso não tenha o snapd na sua distribuição linux).<br>
2. executar o comando `sudo snap install flutter --classic`;
   Fazendo a instalação manual, como descrita [neste link](https://snapcraft.io/docs/installing-snapd).<br>
3. Atualize a variável $PATH (Variáveis de Ambiente);<br>
4. Execute o comando `flutter doctor` para verificar se tudo foi instalado corretamente.

**Instalando o Android Studio**<br>

1. Configure seu dispositivo Android ou configure uma AVD (emulador de Android) com a ajuda do Android Studio;<br>
2. Execute o comando `flutter doctor` novamente para verificar se as dependências foram sanadas.

### **Windows** 

1. Obtenha e instale o SDK do flutter;<br>
2. Atualize a variável $PATH (Variáveis de Ambiente).<br>

**Instalando o Android Studio**<br>

1. Instale o Android Studio;<br>
2. Configure seu dispositivo Android ou configure uma AVD (emulador de Android) com a ajuda do Android Studio;

## Editor/IDE

Siga os passos abaixo de acordo com a sua escolha de editor/IDE:

### **VSCode**

O [VSCode](https://flutter.dev/docs/get-started/editor?tab=vscode) geralmente é mais utilizado por ser fácil de integrar com flutter, além de ser mais leve e mais simples de personalizar que o Android Studio. Na documentação oficial do flutter, existe uma seção explicando como utilizar o VSCode para debugar, executar o aplicativo e utilizar o [Dart DevTools](https://dart.dev/tools/dart-devtools).

#### **Plugins Recomendados**

Instale os plugins do Flutter e Dart
Opcionalmente, é recomendável instalar os seguintes plugins:

1. **flutter_mobx**: que adiciona snippets para gerar as Stores, Observers e entre outras funções do mobx;
2. **Git Lens**: recomendado para quem usa git, é um pacote de plugins que adicionam funcionalidade como visualizar na linha do código o responsável pelo último commit que modificou a linha, a árvore de commits, entre outros;
3. **Error Lens**: destaca a linha com problemas acusados pelo lint/intellisense;
4. **Bracket Pair Colorizer**: Colore os parênteses, chaves e colchetes que compõe um escopo de cores diferentes;
   Ocultando arquivos .g.dart

Como o projeto possui bastante código gerado “automaticamente” via [build_runner](https://pub.dev/packages/build_runner), que são os arquivos com extensão .g.dart, para limpar na visualização dos arquivos no explorer, pode ser interessante ocultar os arquivos que possuem esta extensão; para isto, basta acessar File > Preferences > Settings > Text Editor > Files > Files:Exclude e adicionar o pattern `**/*.g.dart`.

### **Android Studio/IntelliJ**

Para programar seus aplicativos utilizando o Android Studio, basta instalar os plugins do Flutter e Dart; mais informações podem ser obtidas na [documentação oficial](https://flutter.dev/docs/development/tools/android-studio).

### **NVIM**

Também é possível programar para Fultter/Dart utilizando nvim. O plugin [dart-vim-plugin](https://github.com/dart-lang/dart-vim-plugin) dá suporte aos arquivos .dart; É sabido que o [coc.nvim](https://github.com/neoclide/coc.nvim) ja possui [extensão do flutter](https://github.com/iamcco/coc-flutter). Um tutorial pode ser encontrado [através deste link](https://dev.to/tavanarad/vim-as-a-flutter-ide-4p16).

## Verificando a instalação

Para verificar se sua instalação foi realizada com sucesso, ou para encontrar quaisquer erros na instalação, execute o seguinte comando no terminal da sua máquina:

```bash
$ flutter doctor
```

A saída deve ser semelhante a esta:

```bash
➜ flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 1.22.2, on Linux, locale en_US.UTF-8)
[✓] Android toolchain - develop for Android devices (Android SDK version 30.0.2)
[✓] Android Studio (version 4.0)
[✓] VS Code (version 1.50.1)
[✓] Connected device (1 available)

• No issues found!
```

# Rodando o projeto

Feita com sucesso a instalação completa do ambiente de desenvolvimento, abra um emulador ou conecte seu dispositivo android ao computador.

Para executar o projeto você pode utilizar a interface da sua IDE, de acordo com o editor/IDE utilizado (VSCode, Android Studio);

Ou pode utilizar a seguinte linha de comando na pasta raiz do projeto:

```bash
$ flutter run
```

# Desenvolvimento

## Design (Material UI)

No processo de criação de layout e design do projeto foram utilizados como base os princípios e componentes do Material Design.

Como segue no exemplo a seguir:

```bash
import 'package:flutter/material.dart';

class NoResultMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(Icons.error_outline),
          Text(
            'Nenhum resultado!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Não foram encontrados resultados para a busca.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
```

A documentação oficial do flutter também oferece informações e exemplos do [Material Design](https://flutter.dev/docs/development/ui/widgets/material)

## Figma

No projeto utilizamos o figma para a prototipagem e produção do layout para o aplicativo.

[Link para visualização do projeto no Figma](https://www.figma.com/file/7q83pbvuxPr8vpO5cpsUSC/FastRecipe?node-id=328%3A406)

## Packages

Todos os packages utilizados neste projetos se encontram no arquivo pubspec.yaml. Os pacotes do bloco dependencies são necessários durante o build do apk; os pacotes do bloco [dev_dependencies](https://dart.dev/tools/pub/dependencies#dev-dependencies) não são chamados durante o build (geralmente utilizados em testes e geração de código). Segue abaixo uma breve explicação e motivação de uso para alguns pacotes utilizados no projeto.

### **Client Http**

O pacote http responsável por fazer as requisições http para a API do Firebase.

### **Leitura de variáveis de ambiente**

flutter_dotenv é responsável pela leitura das variáveis de ambiente presente no arquivo .env do projeto.

### Customização de ícones

flutter_svg é responsável pela renderização de imagens `.svg` utilizadas em todo o projeto.

### **Autenticação**

Para realizar a autenticação de usuários no sistema foram utilizados os recursos do Firebase, para isso foi necessária a extensão firebase_auth.

### **Autenticação por conta Google**

Além da autenticação padrão também foi implementada a autenticação via conta Google. O package google_sign_in, junto ao provider são responsáveis por intermediarem essa comunicação com o firebase e atualizarem o status do sistema.

## Estrutura do projeto

```bash
├───android
├───assets
│   ├───fonts
│   ├───icons
│   └───images
├───build
├───ios
├───lib
│   ├───app
│   ├───core
│   │   └───theme
│   ├───helpers
│   ├───models
│   ├───providers
│   └───views
│       └───content
│           └───components
└───test
```

## Links Úteis

- [Figma](https://www.figma.com/file/7q83pbvuxPr8vpO5cpsUSC/FastRecipe?node-id=328%3A406)
