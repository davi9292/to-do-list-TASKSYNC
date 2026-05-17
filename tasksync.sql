-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 18/05/2026 às 00:41
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `tasksync`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `tarefas`
--

CREATE TABLE `tarefas` (
  `id` int(10) UNSIGNED NOT NULL,
  `usuario_id` int(10) UNSIGNED NOT NULL,
  `descricao` text NOT NULL,
  `setor` varchar(80) NOT NULL,
  `prioridade` enum('baixa','media','alta') NOT NULL DEFAULT 'baixa',
  `status` enum('a_fazer','fazendo','concluido') NOT NULL DEFAULT 'a_fazer',
  `criado_em` datetime NOT NULL DEFAULT current_timestamp(),
  `atualizado_em` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `tarefas`
--

INSERT INTO `tarefas` (`id`, `usuario_id`, `descricao`, `setor`, `prioridade`, `status`, `criado_em`, `atualizado_em`) VALUES
(1, 1, 'Configurar servidor de produção', 'Tecnologia', 'alta', 'concluido', '2026-05-16 00:11:37', '2026-05-16 00:38:48'),
(2, 1, 'Revisar documentação do sistema', 'Tecnologia', 'media', 'a_fazer', '2026-05-16 00:11:37', '2026-05-16 00:11:37'),
(3, 2, 'Criar campanha de e-mail marketing', 'Marketing', 'alta', 'a_fazer', '2026-05-16 00:11:37', '2026-05-16 00:11:37'),
(4, 2, 'Analisar métricas de redes sociais', 'Marketing', 'baixa', 'fazendo', '2026-05-16 00:11:37', '2026-05-16 00:38:53'),
(5, 3, 'Fechamento financeiro do mês', 'Financeiro', 'alta', 'fazendo', '2026-05-16 00:11:37', '2026-05-16 00:11:37'),
(6, 3, 'Gerar relatório de despesas trimestrais', 'Financeiro', 'media', 'a_fazer', '2026-05-16 00:11:37', '2026-05-16 00:11:37'),
(7, 7, 'Criar campanha de ratos', 'Marketing', 'baixa', 'a_fazer', '2026-05-16 00:40:03', '2026-05-16 00:40:03');

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `setor` varchar(80) NOT NULL,
  `cargo` varchar(80) NOT NULL,
  `criado_em` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `setor`, `cargo`, `criado_em`) VALUES
(1, 'Admin TaskSync', 'admin@tasksync.com', 'Tecnologia', 'Administrador', '2026-05-16 00:11:37'),
(2, 'Ana Lima', 'ana@tasksync.com', 'Marketing', 'Analista', '2026-05-16 00:11:37'),
(3, 'Bruno Costa', 'bruno@tasksync.com', 'Financeiro', 'Coordenador', '2026-05-16 00:11:37'),
(7, 'deivi mouse', 'davi@gmail.com', 'Financeiro', 'Analista', '2026-05-16 00:38:26');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `tarefas`
--
ALTER TABLE `tarefas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tarefa_usuario` (`usuario_id`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `tarefas`
--
ALTER TABLE `tarefas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `tarefas`
--
ALTER TABLE `tarefas`
  ADD CONSTRAINT `fk_tarefa_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
