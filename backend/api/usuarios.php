<?php
// Davi de Assis Fabricio
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(204); exit; }

require_once __DIR__ . '/../config/db.php';

$method = $_SERVER['REQUEST_METHOD'];
$pdo    = getConnection();

try {
    if ($method === 'GET') {
        $stmt = $pdo->query('SELECT * FROM usuarios ORDER BY nome ASC');
        echo json_encode(['success' => true, 'data' => $stmt->fetchAll()]);

    } elseif ($method === 'POST') {
        $body = json_decode(file_get_contents('php://input'), true);
        $required = ['nome','email','setor','cargo'];
        foreach ($required as $f) {
            if (empty($body[$f])) {
                http_response_code(422);
                echo json_encode(['success' => false, 'message' => "Campo '$f' obrigatório."]);
                exit;
            }
        }
        // Checar e-mail duplicado
        $chk = $pdo->prepare('SELECT id FROM usuarios WHERE email = ?');
        $chk->execute([$body['email']]);
        if ($chk->fetch()) {
            http_response_code(409);
            echo json_encode(['success' => false, 'message' => 'E-mail já cadastrado.']);
            exit;
        }
        $stmt = $pdo->prepare(
            'INSERT INTO usuarios (nome, email, setor, cargo) VALUES (?, ?, ?, ?)'
        );
        $stmt->execute([$body['nome'], $body['email'], $body['setor'], $body['cargo']]);
        echo json_encode(['success' => true, 'id' => $pdo->lastInsertId()]);

    } elseif ($method === 'DELETE') {
        $id = (int)($_GET['id'] ?? 0);
        if (!$id) { http_response_code(400); echo json_encode(['success'=>false,'message'=>'ID inválido']); exit; }
        $pdo->prepare('DELETE FROM usuarios WHERE id = ?')->execute([$id]);
        echo json_encode(['success' => true]);

    } else {
        http_response_code(405);
        echo json_encode(['success' => false, 'message' => 'Método não permitido.']);
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Erro no banco: ' . $e->getMessage()]);
}