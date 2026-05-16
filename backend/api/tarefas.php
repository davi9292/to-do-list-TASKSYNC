<?php
// Davi de Assis Fabricio
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(204); exit; }

require_once __DIR__ . '/../config/db.php';

$method = $_SERVER['REQUEST_METHOD'];
$pdo    = getConnection();

try {
    // GET /tarefas → lista todas; GET /tarefas?id=N → uma só
    if ($method === 'GET') {
        if (!empty($_GET['id'])) {
            $stmt = $pdo->prepare(
                'SELECT t.*, u.nome AS usuario_nome
                   FROM tarefas t JOIN usuarios u ON u.id = t.usuario_id
                  WHERE t.id = ?'
            );
            $stmt->execute([(int)$_GET['id']]);
            $row = $stmt->fetch();
            echo json_encode(['success' => (bool)$row, 'data' => $row ?: null]);
        } else {
            $stmt = $pdo->query(
                'SELECT t.*, u.nome AS usuario_nome
                   FROM tarefas t JOIN usuarios u ON u.id = t.usuario_id
                  ORDER BY FIELD(t.prioridade,"alta","media","baixa"), t.criado_em DESC'
            );
            echo json_encode(['success' => true, 'data' => $stmt->fetchAll()]);
        }

    } elseif ($method === 'POST') {
        $body = json_decode(file_get_contents('php://input'), true);
        $required = ['usuario_id','descricao','setor','prioridade'];
        foreach ($required as $f) {
            if (empty($body[$f])) {
                http_response_code(422);
                echo json_encode(['success' => false, 'message' => "Campo '$f' obrigatório."]);
                exit;
            }
        }
        $stmt = $pdo->prepare(
            'INSERT INTO tarefas (usuario_id, descricao, setor, prioridade, status)
             VALUES (?, ?, ?, ?, "a_fazer")'
        );
        $stmt->execute([$body['usuario_id'], $body['descricao'], $body['setor'], $body['prioridade']]);
        echo json_encode(['success' => true, 'id' => $pdo->lastInsertId()]);

    } elseif ($method === 'PUT') {
        $id   = (int)($_GET['id'] ?? 0);
        $body = json_decode(file_get_contents('php://input'), true);
        if (!$id) { http_response_code(400); echo json_encode(['success'=>false,'message'=>'ID inválido']); exit; }

        // Atualização parcial (status) ou completa
        if (isset($body['status'])) {
            $allowed = ['a_fazer','fazendo','concluido'];
            if (!in_array($body['status'], $allowed)) {
                http_response_code(422); echo json_encode(['success'=>false,'message'=>'Status inválido']); exit;
            }
            $pdo->prepare('UPDATE tarefas SET status = ? WHERE id = ?')->execute([$body['status'], $id]);
        } else {
            $required = ['usuario_id','descricao','setor','prioridade'];
            foreach ($required as $f) {
                if (empty($body[$f])) {
                    http_response_code(422);
                    echo json_encode(['success' => false, 'message' => "Campo '$f' obrigatório."]);
                    exit;
                }
            }
            $pdo->prepare(
                'UPDATE tarefas SET usuario_id=?, descricao=?, setor=?, prioridade=? WHERE id=?'
            )->execute([$body['usuario_id'], $body['descricao'], $body['setor'], $body['prioridade'], $id]);
        }
        echo json_encode(['success' => true]);

    } elseif ($method === 'DELETE') {
        $id = (int)($_GET['id'] ?? 0);
        if (!$id) { http_response_code(400); echo json_encode(['success'=>false,'message'=>'ID inválido']); exit; }
        $pdo->prepare('DELETE FROM tarefas WHERE id = ?')->execute([$id]);
        echo json_encode(['success' => true]);

    } else {
        http_response_code(405);
        echo json_encode(['success' => false, 'message' => 'Método não permitido.']);
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Erro no banco: ' . $e->getMessage()]);
}