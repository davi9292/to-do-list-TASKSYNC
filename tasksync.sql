-- =========================================
-- BANCO DE DADOS TASKSYNC - correto
-- =========================================

CREATE DATABASE IF NOT EXISTS `tasksync`
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE `tasksync`;

-- =========================================
-- TABELA USUARIOS
-- =========================================

CREATE TABLE `usuarios` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `setor` VARCHAR(80) NOT NULL,
  `cargo` VARCHAR(80) NOT NULL,
  `criado_em` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_email` (`email`)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

-- =========================================
-- TABELA TAREFAS
-- =========================================

CREATE TABLE `tarefas` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuario_id` INT(10) UNSIGNED NOT NULL,
  `descricao` TEXT NOT NULL,
  `setor` VARCHAR(80) NOT NULL,

  `prioridade` ENUM('baixa','media','alta')
  NOT NULL DEFAULT 'baixa',

  `status` ENUM('a_fazer','fazendo','concluido')
  NOT NULL DEFAULT 'a_fazer',

  `criado_em` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

  `atualizado_em` DATETIME NOT NULL
  DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),

  KEY `fk_tarefa_usuario` (`usuario_id`),

  CONSTRAINT `fk_tarefa_usuario`
  FOREIGN KEY (`usuario_id`)
  REFERENCES `usuarios` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE

) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

-- =========================================
-- INSERTS USUARIOS
-- =========================================

INSERT INTO `usuarios`
(`nome`, `email`, `setor`, `cargo`)
VALUES
('Admin TaskSync', 'admin@tasksync.com', 'Tecnologia', 'Administrador'),

('Ana Lima', 'ana@tasksync.com', 'Marketing', 'Analista'),

('Bruno Costa', 'bruno@tasksync.com', 'Financeiro', 'Coordenador'),

('Davi Mouse', 'davi@gmail.com', 'Financeiro', 'Analista');

-- =========================================
-- INSERTS TAREFAS
-- =========================================

INSERT INTO `tarefas`
(`usuario_id`, `descricao`, `setor`, `prioridade`, `status`)
VALUES

(1,
'Configurar servidor de produção',
'Tecnologia',
'alta',
'concluido'),

(1,
'Revisar documentação do sistema',
'Tecnologia',
'media',
'a_fazer'),

(2,
'Criar campanha de e-mail marketing',
'Marketing',
'alta',
'a_fazer'),

(2,
'Analisar métricas de redes sociais',
'Marketing',
'baixa',
'fazendo'),

(3,
'Fechamento financeiro do mês',
'Financeiro',
'alta',
'fazendo'),

(3,
'Gerar relatório de despesas trimestrais',
'Financeiro',
'media',
'a_fazer'),

(4,
'Criar campanha de ratos',
'Marketing',
'baixa',
'a_fazer');

-- =========================================
-- CONSULTA TESTE
-- =========================================

SELECT
    t.id,
    t.descricao,
    t.setor,
    t.prioridade,
    t.status,
    u.nome AS usuario
FROM tarefas t
INNER JOIN usuarios u
ON t.usuario_id = u.id;