// frontend/js/utils.js

const API = {
  usuarios: '../backend/api/usuarios.php',
  tarefas:  '../backend/api/tarefas.php',
};

// ── Toast ──────────────────────────────────────
function toast(msg, type = 'success') {
  let container = document.getElementById('toast-container');
  if (!container) {
    container = document.createElement('div');
    container.id = 'toast-container';
    container.className = 'toast-container';
    document.body.appendChild(container);
  }
  const el = document.createElement('div');
  el.className = `toast toast-${type}`;
  el.textContent = msg;
  container.appendChild(el);
  setTimeout(() => {
    el.style.animation = 'fadeOut .4s ease forwards';
    setTimeout(() => el.remove(), 400);
  }, 3200);
}

// ── API helpers ────────────────────────────────
async function apiFetch(url, options = {}) {
  const res  = await fetch(url, { headers: { 'Content-Type': 'application/json' }, ...options });
  const data = await res.json();
  return data;
}

function formatDate(str) {
  if (!str) return '—';
  const d = new Date(str);
  return d.toLocaleDateString('pt-BR', { day:'2-digit', month:'2-digit', year:'numeric' });
}

function prioLabel(p) {
  return { alta: 'Alta', media: 'Média', baixa: 'Baixa' }[p] ?? p;
}

function statusLabel(s) {
  return { a_fazer: 'A Fazer', fazendo: 'Fazendo', concluido: 'Concluído' }[s] ?? s;
}

// ── Highlight active nav link ──────────────────
document.addEventListener('DOMContentLoaded', () => {
  const links = document.querySelectorAll('.nav-links a');
  links.forEach(a => {
    if (window.location.href.includes(a.getAttribute('href'))) a.classList.add('active');
  });
});