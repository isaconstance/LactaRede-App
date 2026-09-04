# 🍼 LactaRede

## 📱 Sobre o projeto

O LactaRede é um aplicativo mobile desenvolvido em Flutter para auxiliar no processo de doação de leite materno, permitindo que as usuárias consultem pontos de coleta, realizem agendamentos e acessem informações sobre a doação.

---

## 🛠️ Tecnologias

* Flutter
* Dart
* API REST
* SharedPreferences
* Git/GitHub

**Versão do Flutter:** 3.47.1

---

## 📲 Telas e navegação

### Splash

Tela inicial de apresentação do aplicativo.

<img width="495" height="820" alt="Screenshot 2026-09-04 183003" src="https://github.com/user-attachments/assets/ec910a06-7cc5-4d60-ae4a-a5123902b3d4" />


### Login

Permite que a usuária realize o acesso à aplicação.

<img width="497" height="822" alt="Screenshot 2026-09-04 183035" src="https://github.com/user-attachments/assets/0961f4f9-e97b-4466-b396-3e33d5dbb197" />


### Cadastro

Permite o cadastro de uma nova usuária.

<img width="493" height="735" alt="Screenshot 2026-09-04 183056" src="https://github.com/user-attachments/assets/fc99f7a2-018b-4981-8064-74c666dfcd66" />
<img width="497" height="739" alt="Screenshot 2026-09-04 183106" src="https://github.com/user-attachments/assets/31839f58-8762-4c24-a6d0-62d930369fb6" />


### Home

Tela principal com acesso às funcionalidades do aplicativo.

<img width="501" height="744" alt="Screenshot 2026-09-04 183248" src="https://github.com/user-attachments/assets/7c2f2a11-69bd-4db5-8b15-e9899ffc250c" />
<img width="496" height="740" alt="Screenshot 2026-09-04 183320" src="https://github.com/user-attachments/assets/1a4a7dcc-97bc-43ab-a9db-8ee8d3152b95" />

### Doação

Tela destinada ao fluxo de doação.

<img width="496" height="736" alt="Screenshot 2026-09-04 183437" src="https://github.com/user-attachments/assets/ef0a730a-034e-4ac7-bbe1-afa4f69a6cb8" />
<img width="499" height="739" alt="Screenshot 2026-09-04 183411" src="https://github.com/user-attachments/assets/65d20fa4-930b-412f-b9f1-72b129f4fcd2" />
<img width="501" height="735" alt="Screenshot 2026-09-04 183627" src="https://github.com/user-attachments/assets/c21c58eb-d638-4f5a-9aa1-19c1f1b9a743" />
<img width="497" height="733" alt="Screenshot 2026-09-04 183551" src="https://github.com/user-attachments/assets/74929fff-8155-44c3-8f5b-913daf18afa8" />
<img width="500" height="738" alt="Screenshot 2026-09-04 183537" src="https://github.com/user-attachments/assets/9f21a055-7f30-4bd9-a967-18e3e2231318" />
<img width="499" height="733" alt="Screenshot 2026-09-04 183522" src="https://github.com/user-attachments/assets/3ac13f4c-0445-4ace-89ff-0ff57e3ee2ac" />
<img width="500" height="736" alt="Screenshot 2026-09-04 183458" src="https://github.com/user-attachments/assets/7bbb612c-2068-4a1c-9e85-003ee121ceaa" />


### Pontos de Coleta

Exibe os pontos de coleta disponíveis.

<img width="496" height="735" alt="Screenshot 2026-09-04 183726" src="https://github.com/user-attachments/assets/3b6b1ecf-9c33-4793-9cbd-35ab52efb773" />


### Meus Agendamentos

Exibe os agendamentos realizados pela usuária.

<img width="499" height="736" alt="Screenshot 2026-09-04 183756" src="https://github.com/user-attachments/assets/30e467ee-67b7-4edb-baea-87d2514bcc2f" />


### Informações

Apresenta informações relacionadas à doação de leite materno.

<img width="497" height="736" alt="Screenshot 2026-09-04 183820" src="https://github.com/user-attachments/assets/f5d5330d-995d-4b73-9adc-bd495fc709b3" />


### Ajuda

Apresenta informações para auxiliar a usuária na utilização do aplicativo.

<img width="496" height="734" alt="Screenshot 2026-09-04 183902" src="https://github.com/user-attachments/assets/8435191b-a696-45e0-88cb-f4c5e91b6bc5" />


### Notificações

A tela de Notificações apresenta avisos e atualizações importantes para a usuária, como informações sobre agendamentos e outras atividades do aplicativo.

<img width="497" height="732" alt="Screenshot 2026-09-04 184319" src="https://github.com/user-attachments/assets/d50597e0-474f-471a-bd85-ead9af14a9d0" />



### Minha Conta

A tela de Minha Conta apresenta os dados da usuária e permite acessar as opções relacionadas ao seu perfil.

<img width="496" height="735" alt="Screenshot 2026-09-04 184146" src="https://github.com/user-attachments/assets/325c49f3-f296-4d7a-a250-22a288086cde" />


### Alteração de Dados

A tela de Alteração de Dados permite que a usuária edite e atualize suas informações cadastradas.

<img width="502" height="737" alt="Screenshot 2026-09-04 184447" src="https://github.com/user-attachments/assets/b3492434-c76e-4527-b369-be4535573f9e" />


---

### Fluxo de navegação

Splash
  ↓
Login ←→ Cadastro
  ↓
Home
  ├── Doação
  ├── Pontos de Coleta
  ├── Meus Agendamentos
  ├── Informações
  └── Ajuda

---

## 📥 Instruções para instalação

### Pré-requisitos

* Flutter SDK instalado;
* Dart SDK compatível;
* Android Studio ou VS Code;
* Emulador Android ou dispositivo físico.

### Instalação

1. Clone o repositório:

git clone link_do_repositório

2. Acesse a pasta do projeto:

cd LactaRede-App

3. Instale as dependências:

flutter pub get

---

## 🌐 Configuração da URL da API

O projeto utiliza a API ViaCEP para consultar endereços a partir do CEP.
A URL da API está configurada no arquivo:

lib/services/cep_service.dart

Atualmente, a aplicação utiliza: https://viacep.com.br/ws

Não é necessário realizar nenhuma configuração adicional da URL para executar o projeto. 
O aplicativo também utiliza a Stadia Maps para exibição dos mapas e localização dos pontos de coleta.

---

## ▶️ Como executar o projeto

Após instalar as dependências, conecte um dispositivo Android ou inicie um emulador.
Execute o projeto com: flutter run
