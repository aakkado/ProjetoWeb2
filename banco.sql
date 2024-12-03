-- Criação da tabela de usuários
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE, 
    password VARCHAR(255) NOT NULL,      
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

-- Criação da tabela de espaços
CREATE TABLE espacos (
    espaco_id INT PRIMARY KEY AUTO_INCREMENT,
    nome_espaco VARCHAR(100) NOT NULL UNIQUE,
    valor_aluguel DECIMAL(10, 2) NOT NULL,
    local VARCHAR(150),
    tamanho VARCHAR(50)
);

-- Criação da tabela de aluguéis (tabela intermediária entre usuários e espaços)
CREATE TABLE alugueis (
    aluguel_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    espaco_id INT NOT NULL,
    valor_final DECIMAL(10, 2),
    metodo_pagamento VARCHAR(50),
    periodo_inicio DATETIME NOT NULL,
    periodo_fim DATETIME NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id),
    FOREIGN KEY (espaco_id) REFERENCES espacos(espaco_id)
);
