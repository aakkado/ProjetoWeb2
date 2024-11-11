-- Criação da tabela de usuários
CREATE TABLE usuarios (
    usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    senha VARCHAR(255) NOT NULL
);

-- Criação da tabela de espaços
CREATE TABLE espacos (
    espaco_id INT PRIMARY KEY AUTO_INCREMENT,
    nome_espaco VARCHAR(100) NOT NULL,
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
