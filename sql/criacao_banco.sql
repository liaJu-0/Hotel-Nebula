CREATE DATABASE hotel_nebula;
USE hotel_nebula;

CREATE TABLE hospedes (
    id_hospede INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    telefone VARCHAR(20),
    data_nascimento DATE,
    endereco VARCHAR(200)
);

CREATE TABLE quartos (
    id_quarto INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(10) UNIQUE NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    capacidade INT,
    preco_diaria DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Disponivel',
    descricao VARCHAR(200)
);

CREATE TABLE funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    telefone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_hospede INT NOT NULL,
    id_quarto INT NOT NULL,
    data_reserva DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_checkin DATE NOT NULL,
    data_checkout DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Confirmada',

    FOREIGN KEY (id_hospede)
    REFERENCES hospedes(id_hospede),

    FOREIGN KEY (id_quarto)
    REFERENCES quartos(id_quarto)
);

CREATE TABLE hospedagens (
    id_hospedagem INT AUTO_INCREMENT PRIMARY KEY,
    id_reserva INT UNIQUE,
    id_funcionario INT,
    checkin_real DATETIME,
    checkout_real DATETIME,

    FOREIGN KEY (id_reserva)
    REFERENCES reservas(id_reserva),

    FOREIGN KEY (id_funcionario)
    REFERENCES funcionarios(id_funcionario)
);

CREATE TABLE pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_hospedagem INT,
    valor DECIMAL(10,2) NOT NULL,
    metodo VARCHAR(30),
    data_pagamento DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20),

    FOREIGN KEY (id_hospedagem)
    REFERENCES hospedagens(id_hospedagem)
);

CREATE TABLE servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    descricao VARCHAR(200),
    preco DECIMAL(10,2)
);

CREATE TABLE consumo_servicos (
    id_consumo INT AUTO_INCREMENT PRIMARY KEY,
    id_hospedagem INT,
    id_servico INT,
    quantidade INT DEFAULT 1,
    valor_total DECIMAL(10,2),

    FOREIGN KEY (id_hospedagem)
    REFERENCES hospedagens(id_hospedagem),

    FOREIGN KEY (id_servico)
    REFERENCES servicos(id_servico)
);

CREATE TABLE feedbacks (
    id_feedback INT AUTO_INCREMENT PRIMARY KEY,
    id_hospede INT,
    id_quarto INT,
    nota INT CHECK (nota BETWEEN 1 AND 5),
    comentario TEXT,
    data_feedback DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_hospede)
    REFERENCES hospedes(id_hospede),

    FOREIGN KEY (id_quarto)
    REFERENCES quartos(id_quarto)
);

--Insere dados de exemplo

INSERT INTO hospedes
(nome,email,cpf,telefone)
VALUES
('Julia P','julia@email.com','11111111111','11999999999'),
('Caio C','caio@email.com','22222222222','11988888888');

INSERT INTO quartos
(numero,tipo,capacidade,preco_diaria,status)
VALUES
('101','Standard',2,200,'Disponivel'),
('102','Luxo',4,450,'Disponivel');

INSERT INTO funcionarios
(nome,cargo)
VALUES
('Ana Souza','Recepcionista'),
('Pedro Lima','Gerente');

INSERT INTO servicos
(nome,descricao,preco)
VALUES
('Cafe da Manha','Buffet completo',35),
('Lavanderia','Lavagem de roupas',50);