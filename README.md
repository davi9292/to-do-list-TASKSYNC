# TaskSync — Sistema de Gerenciamento de Tarefas

**TaskSync Solutions** é uma aplicação web de gestão de tarefas no modelo Kanban, desenvolvida com HTML, CSS, JavaScript (frontend) e PHP + MySQL (backend).

---

## 👥 Feito por:

> Davi de Assis Fabricio

---

## 🚀 Como executar

### Pré-requisitos

- [XAMPP](https://www.apachefriends.org/) (Apache + MySQL + PHP 8+)
- Nenhuma biblioteca adicional necessária

### Passo a passo

1. **Clone / copie** a pasta `tasksync` inteira para dentro de `htdocs` do XAMPP:
   ```
   C:\xampp\htdocs\tasksync\
   ```

2. **Importe o banco de dados**:
   - Inicie o XAMPP (Apache + MySQL)
   - Acesse `http://localhost/phpmyadmin`
   - Crie o banco ou deixe o script criar automaticamente
   - Vá em **Importar** e selecione o arquivo:
     ```
     backend/tasksync.sql
     ```

3. **Configure a conexão** (se necessário):  
   Edite `backend/config/db.php` e ajuste as credenciais:
   ```php
   define('DB_HOST', 'localhost');
   define('DB_NAME', 'tasksync');
   define('DB_USER', 'root');
   define('DB_PASS', '');   // padrão XAMPP sem senha
   ```

4. **Acesse no navegador**:
   ```
   http://localhost/tasksync/
   ```

---

## 📁 Estrutura de Pastas

```
tasksync/
├── index.html                  ← Dashboard principal
├── frontend/
│   ├── usuarios.html           ← Tela de cadastro de usuários
│   ├── tarefas.html            ← Tela de cadastro/edição de tarefas
│   ├── kanban.html             ← Gerenciamento visual Kanban
│   ├── css/
│   │   └── style.css
│   └── js/
│       └── utils.js
├── backend/
│   ├── tasksync.sql            ← Script do banco de dados
│   ├── config/
│   │   └── db.php              ← Configuração PDO
│   └── api/
│       ├── usuarios.php        ← API REST usuários
│       └── tarefas.php         ← API REST tarefas
└── docs/
    ├── DER_TaskSync.svg        ← Diagrama Entidade-Relacionamento
    └── CasoDeUso_TaskSync.svg  ← Diagrama de Caso de Uso
```

---

## 🧪 Dados de Exemplo

O script SQL já insere 3 usuários e 6 tarefas de exemplo:

| Nome           | E-mail                | Setor      | Cargo        |
|----------------|-----------------------|------------|--------------|
| Admin TaskSync | admin@tasksync.com    | Tecnologia | Administrador|
| Ana Lima       | ana@tasksync.com      | Marketing  | Analista     |
| Bruno Costa    | bruno@tasksync.com    | Financeiro | Coordenador  |

> **Não há sistema de login.** O acesso é direto, conforme especificação.

---

## 🗺️ Funcionalidades

| Tela | Funcionalidades |
|------|----------------|
| **Dashboard** | Estatísticas gerais e acesso rápido às telas |
| **Usuários** | Cadastro, listagem e exclusão de usuários |
| **Tarefas** | Cadastro, edição, exclusão e filtro de tarefas |
| **Kanban** | Visualização por status, alteração de status, edição, exclusão e filtros |

---

## 🎨 Identidade Visual

- **Fonte**: Syne (títulos) + DM Sans (corpo) — Google Fonts
- **Tema**: Dark mode com paleta azul/roxo + acentos coloridos por prioridade
- **Cores principais**:  
  `#0d0f14` (fundo) · `#4f8ef7` (azul) · `#7c5cfc` (roxo) · `#3dd68c` (verde) · `#f7ac4f` (laranja)

---

## 📋 Regras de Negócio implementadas

- Todos os campos obrigatórios com validação no frontend e backend
- Status inicial das tarefas: **A Fazer**
- Visualização Kanban dividida em 3 colunas: A Fazer / Fazendo / Concluído
- Prioridade: Baixa / Média / Alta (com destaque visual)
- Exclusão de usuário exclui tarefas vinculadas (CASCADE)
- E-mail de usuário único (constraint UNIQUE + validação na API)

---

## 📌 Observações

- As APIs seguem o padrão REST com métodos GET, POST, PUT, DELETE
- O sistema usa PDO com prepared statements para segurança contra SQL Injection
- Layout responsivo (mobile-first para telas menores que 900px)
