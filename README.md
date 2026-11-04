# 🍔 Cantina UNIP App — Mobile Delivery

Aplicativo móvel de delivery para a cantina da faculdade, desenvolvido em **Flutter** como parte da avaliação da **NP2** na disciplina de **Desenvolvimento Mobile** (Curso: Análise e Desenvolvimento de Sistemas — UNIP).

---

## 📌 Apresentação do Projeto

O **Cantina UNIP App** é uma solução enxuta e moderna de autoatendimento e delivery universitário. O aplicativo permite aos alunos visualizar o catálogo de produtos da cantina, montar seus pedidos personalizando tamanhos e acompanhamentos, validar o endereço de entrega via CEP e acompanhar todas as solicitações em tempo real.

---

## 👥 Equipe e Divisão de Papéis (Grupo de 2 Integrantes)

Conforme a adequação para grupos menores (Seção 2.1 da Proposta NP2):

* **Integrante 1 (Guilherme):** *Lógica, Dados e Integração*
  * Configuração do Firebase Console e `cloud_firestore`.
  * Integração com a API REST do ViaCEP (`http`).
  * Formulário dinâmico (`TextField`, `Checkbox`, `Radio` e `StatefulWidget`).
  * Gravador e visualizador em tempo real (`add()` e `StreamBuilder`).
* **Integrante 2:** *Interface, Layout e Navegação*
  * Estruturação inicial da interface (`Scaffold`, `AppBar`, `TextStyle`).
  * Organização visual com imagens (`BoxFit`), ícones e assets.
  * Construção de layouts complexos (`Column`, `Row`, `SingleChildScrollView`, `Stack`, `Positioned`).
  * Arquitetura em 3 páginas separadas e rotas com `Navigator` (passagem de parâmetros).

---

## 🚀 Funcionalidades & Mapeamento de Aulas

O aplicativo foi projetado para cobrir 100% do conteúdo trabalhado nas **Aulas 01 a 09**:

| Aula | Conteúdo Exigido | Aplicação no Cantina UNIP App |
| :--- | :--- | :--- |
| **01 & 02** | Estrutura base e textos | `Scaffold`, `AppBar` customizada e textos com `TextStyle` em todas as telas. |
| **03** | Imagens e Ícones | Exibição de imagens de lanches com `BoxFit` ajustado e ícones de navegação. |
| **04** | Layouts e Posições | Organização visual com `Column`, `Row`, rolagens com `SingleChildScrollView` e banners com `Stack` / `Positioned`. |
| **05** | Navegação | Três arquivos `.dart` independentes (`home_screen`, `pedido_screen`, `lista_screen`) integrados por `Navigator`. |
| **06** | Gerenciamento de Estado | Uso de `StatefulWidget` com `setState` para atualização imediata do formulário. |
| **07** | TextFields | Campos de entrada para Nome, CEP, Rua, Bairro e Cidade controlados por `TextEditingController`. |
| **08** | Seletores (Checkbox/Radio) | Seleção de tamanho do lanche (grupos de `Radio` com `enum`) e opcionais adicionais (`Checkbox`). |
| **09** | Cloud Firestore | Armazenamento de pedidos na nuvem (`add()`) e listagem em tempo real via `StreamBuilder`. |

---

## 🔎 Recurso Adicional Pesquisado (Seção 5.1)

* **Tecnologia:** Consumo de API REST com o pacote [`http`](https://pub.dev/packages/http).
* **Serviço Integrado:** API Gratuita [ViaCEP](https://viacep.com.br/).
* **Justificativa:** Proporcionar agilidade no preenchimento do formulário da cantina. Ao digitar os 8 dígitos do CEP no campo correspondente, o aplicativo consulta a API em background, decodifica o retorno JSON e preenche automaticamente os campos de Rua, Bairro e Cidade, reduzindo a chance de erros de digitação pelo usuário.

---

## 🛠️ Tecnologias e Pacotes

* **Flutter / Dart**
* **`firebase_core`** (Inicialização do Firebase)
* **`cloud_firestore`** (Banco de dados em tempo real)
* **`http`** (Requisições assíncronas para o ViaCEP)

---

## 📱 Estrutura das Páginas

1. **`home_screen.dart` (Tela 1 — Catálogo):** Apresentação visual da cantina, destaques da semana e botão para iniciar o pedido.
2. **`pedido_screen.dart` (Tela 2 — Formulário):** Escolha de itens, seleção de tamanho, adicionais, consulta de CEP automatizada e envio do pedido.
3. **`lista_screen.dart` (Tela 3 — Acompanhamento):** Painel de pedidos cadastrados sincronizado ao vivo com o Firestore.

---

## 🗂️ Como Executar o Projeto

1. Clone o repositório:
   ```bash

   git clone [https://github.com/gmhernani-tech/cantina-unip-app.git](https://github.com/gmhernani-tech/cantina-unip-app.git)
