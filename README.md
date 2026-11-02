# ClickUp &bull; Painel de tarefas no Rainmeter

O **ClickUp para Rainmeter** é um skin para [Rainmeter](https://www.rainmeter.net/)
que exibe, diretamente na área de trabalho, as tarefas concluídas e pendentes do
ClickUp.

![Rainmeter](https://img.shields.io/badge/Rainmeter-skin-6c5ce7)
![ClickUp API](https://img.shields.io/badge/ClickUp-API%20v2-7b68ee)

---

## Funcionalidades

- **Resumo de tarefas:**
  - Lista até 3 tarefas concluídas.
  - Lista até 6 tarefas pendentes.
  - Exibe nome, data de vencimento e prioridade.
- **Atualização contínua:**
  - Consulta a API do ClickUp automaticamente a cada 20 segundos.
  - Permite atualização manual pelo botão `[R]`.
- **Integração com o ClickUp:**
  - Abre o ClickUp pelo botão `+ Adicionar Tarefa`.
  - Usa a API v2 por meio do PowerShell nativo do Windows.
- **Interface personalizável:**
  - Três tamanhos: pequeno (`P`), médio (`M`) e grande (`G`).
  - Prioridades altas e urgentes destacadas com cores diferentes.

## Requisitos

- Windows.
- [Rainmeter](https://www.rainmeter.net/) instalado.
- Uma conta do ClickUp.
- Um token pessoal da API do ClickUp.
- Acesso à internet para consultar a API.

## Como instalar

### Pré-requisitos

- Windows.
- [Rainmeter](https://www.rainmeter.net/) instalado.
- Uma conta do ClickUp.
- Um token pessoal da API do ClickUp.
- Acesso à internet para consultar a API.

### 1. Baixar o projeto

Baixe ou clone este repositório:

```powershell
git clone https://github.com/VaporubDev/clickup-rainmeter.git
cd clickup-rainmeter
```

### 2. Copiar para o Rainmeter

Copie a pasta `ClickUp` para:

   ```text
   %USERPROFILE%\Documents\Rainmeter\Skins\
   ```

   Abra o arquivo `ClickUp.ini` e configure os valores da seção
   `[Variables]`, conforme explicado abaixo.

   ### 3. Carregar no Rainmeter

No Rainmeter, abra **Gerenciar**, localize `ClickUp`, selecione `ClickUp.ini` e
clique em **Carregar**.

## Como configurar o ClickUp

### 1. Criar um token da API

No ClickUp:

1. Abra as configurações do seu perfil.
2. Acesse **Apps** ou **API**.
3. Gere um token pessoal.
4. Copie o token e informe-o em `APIToken`.

Nunca compartilhe esse token nem o publique no GitHub. Se um token real for
exposto, revogue-o imediatamente no ClickUp e gere outro.

### 2. Encontrar o `TeamID`

O `TeamID` é o identificador numérico do seu workspace/equipe no ClickUp.
Ele pode ser obtido pela API do ClickUp ou pela documentação da conta.

### 3. Editar as variáveis

Abra `ClickUp.ini` e substitua os valores de exemplo:

```ini
APIToken=SEU_TOKEN_PESSOAL_DO_CLICKUP
TeamID=SEU_TEAM_ID
ClickUpAppUrl=clickup://SEU_TEAM_ID/v/l/SEU_LINK_DO_CLICKUP
```

O arquivo distribuído neste repositório contém apenas marcadores de posição
para evitar o vazamento de credenciais.

`ClickUpAppUrl` é opcional para a consulta das tarefas, mas é usado pelo botão
`+ Adicionar Tarefa`. Para abrir uma página específica, substitua o valor pelo
link profundo (`clickup://...`) correspondente ao seu workspace ou lista.

## Como executar

- Clique em `P`, `M` ou `G` para alterar o tamanho do painel.
- Clique em `[R]` para buscar as tarefas novamente.
- Clique em `+ Adicionar Tarefa` para abrir o ClickUp.
- A atualização automática acontece a cada 20 segundos.

As tarefas são buscadas no endpoint de tarefas do workspace, incluindo tarefas
fechadas e subtarefas. O skin considera como concluídas as tarefas com status
`closed`, `done`, `complete` ou cujo nome do status contenha `conclu`. Todas as
outras são exibidas como pendentes.

## Solução de problemas

### Aparece `Erro ao carregar`

Confira:

- se o token está correto e ainda ativo;
- se o `TeamID` pertence ao workspace correto;
- se o computador tem acesso à internet;
- se o PowerShell está disponível no Windows;
- se o Rainmeter foi atualizado depois da alteração do arquivo.

### O painel não aparece no Rainmeter

Verifique se a pasta está exatamente em:

```text
%USERPROFILE%\Documents\Rainmeter\Skins\ClickUp\
```

Depois, abra **Gerenciar**, clique em **Atualizar tudo**, selecione
`ClickUp.ini` e clique em **Carregar**.

### O botão não abre o ClickUp

Verifique o valor de `ClickUpAppUrl`. O protocolo `clickup://` precisa estar
associado ao aplicativo ClickUp Desktop. Como alternativa, use um link web do
ClickUp no lugar do link profundo.

## Estrutura do projeto

```text
ClickUp/
├── ClickUp.ini  # Configuração, consultas à API e interface do skin
├── CHANGELOG.md # Histórico de evolução do projeto
└── README.md    # Documentação
```

Os arquivos `done.txt` e `todo.txt`, quando presentes, são saídas locais de
testes e não são necessários para o funcionamento do skin.

## Segurança

- Não faça commit de tokens, senhas ou links privados.
- Antes de publicar, confirme que `APIToken` contém apenas o marcador de
  posição.
- Se o repositório for público, revise o histórico do Git. Remover o token
  apenas do arquivo atual não remove o segredo de commits anteriores.
- Se um segredo já tiver sido publicado, revogue-o antes de tornar o
  repositório público.

## Publicar no GitHub

Depois de revisar os arquivos e criar um repositório vazio no GitHub:

```powershell
git init
git add ClickUp.ini README.md CHANGELOG.md
git commit -m "Adiciona skin ClickUp para Rainmeter"
git branch -M main
git remote add origin https://github.com/VaporubDev/clickup-rainmeter.git
git push -u origin main
```

Não marque a opção de adicionar outro README, pois este projeto já possui um.

## Licença

Nenhuma licença foi definida ainda. Escolha uma licença antes de publicar o
projeto se quiser permitir reutilização e distribuição por outras pessoas.
