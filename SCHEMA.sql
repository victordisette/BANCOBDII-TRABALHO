-- Script de criação do banco de dados MINI_Escola
DROP DATABASE IF EXISTS MINI_Escola;
CREATE DATABASE MINI_Escola;
USE MINI_Escola;

-- 1. Tabela Estados
CREATE TABLE Estados (
    idEstado INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    sigla CHAR(2) NOT NULL,
    pais VARCHAR(50) DEFAULT 'Brasil'
);

-- 2. Tabela Cidades
CREATE TABLE Cidades (
    idCidade INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    idEstado INT NOT NULL,
    FOREIGN KEY (idEstado) REFERENCES Estados(idEstado) ON DELETE CASCADE
);

-- 3. Tabela Enderecos
CREATE TABLE Enderecos (
    idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(45),
    bairro VARCHAR(45) NOT NULL,
    cep CHAR(9) NOT NULL,
    idCidade INT NOT NULL,
    FOREIGN KEY (idCidade) REFERENCES Cidades(idCidade) ON DELETE CASCADE
);

-- 4. Tabela Compositores
CREATE TABLE Compositores (
    idCompositor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    dataNascimento DATE,
    dataFalecimento DATE,
    biografia TEXT
);

-- 5. Tabela Instrumentos
CREATE TABLE Instrumentos (
    idInstrumento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    tipo VARCHAR(45),
    descricao TEXT,
    dataCriacao DATE
);

-- 6. Tabela Musicos
CREATE TABLE Musicos (
    idMusico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    dataNascimento DATE,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(100),
    idEndereco INT,
    genero VARCHAR(20),
    dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idEndereco) REFERENCES Enderecos(idEndereco) ON DELETE SET NULL
);

-- 7. Tabela Orquestras
CREATE TABLE Orquestras (
    idOrquestra INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    anoCriacao YEAR,
    idEndereco INT,
    email VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE,
    website VARCHAR(100),
    FOREIGN KEY (idEndereco) REFERENCES Enderecos(idEndereco) ON DELETE SET NULL
);

-- 8. Tabela Musicos_Instrumentos
CREATE TABLE Musicos_Instrumentos (
    idMusico INT,
    idInstrumento INT,
    instrumentoPrincipal BOOLEAN DEFAULT FALSE,
    dataInicio DATE,
    nivelProficiencia VARCHAR(30),
    PRIMARY KEY (idMusico, idInstrumento),
    FOREIGN KEY (idMusico) REFERENCES Musicos(idMusico) ON DELETE CASCADE,
    FOREIGN KEY (idInstrumento) REFERENCES Instrumentos(idInstrumento) ON DELETE CASCADE
);





-- 9. Tabela Musicos_Orquestras
CREATE TABLE Musicos_Orquestras (
    idMusico INT,
    idOrquestra INT,
    dataEntrada DATE,
    dataSaida DATE,
    cargo VARCHAR(50),
    salario DECIMAL(10,2),
    PRIMARY KEY (idMusico, idOrquestra, dataEntrada),
    FOREIGN KEY (idMusico) REFERENCES Musicos(idMusico) ON DELETE CASCADE,
    FOREIGN KEY (idOrquestra) REFERENCES Orquestras(idOrquestra) ON DELETE CASCADE
);

-- 10. Tabela Sinfonias
CREATE TABLE Sinfonias (
    idSinfonia INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    anoComposicao INT,
    duracao TIME,
    idCompositor INT,
    dificuldade VARCHAR(30),
    FOREIGN KEY (idCompositor) REFERENCES Compositores(idCompositor) ON DELETE CASCADE
);

-- 11. Tabela Eventos
CREATE TABLE Eventos (
    idEvento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    data DATE NOT NULL,
    horario TIME,
    idEndereco INT NOT NULL,
    descricao TEXT,
    precoIngresso DECIMAL(8,2),
    capacidade INT,
    FOREIGN KEY (idEndereco) REFERENCES Enderecos(idEndereco) ON DELETE CASCADE
);

-- 12. Tabela Eventos_Compositores (N:N)
CREATE TABLE Eventos_Compositores (
    idEvento INT,
    idCompositor INT,
    PRIMARY KEY (idEvento, idCompositor),
    FOREIGN KEY (idEvento) REFERENCES Eventos(idEvento) ON DELETE CASCADE,
    FOREIGN KEY (idCompositor) REFERENCES Compositores(idCompositor) ON DELETE CASCADE
);

-- 13. Tabela Eventos_Orquestras
CREATE TABLE Eventos_Orquestras (
    idEvento INT,
    idOrquestra INT,
    cache DECIMAL(10,2),
    PRIMARY KEY (idEvento, idOrquestra),
    FOREIGN KEY (idEvento) REFERENCES Eventos(idEvento) ON DELETE CASCADE,
    FOREIGN KEY (idOrquestra) REFERENCES Orquestras(idOrquestra) ON DELETE CASCADE
);

-- 14. Tabela Repertorios
CREATE TABLE Repertorios (
    idRepertorio INT PRIMARY KEY AUTO_INCREMENT,
    idEvento INT NOT NULL,
    idSinfonia INT NOT NULL,
    ordemExecucao INT NOT NULL,
    maestro VARCHAR(100),
    FOREIGN KEY (idEvento) REFERENCES Eventos(idEvento) ON DELETE CASCADE,
    FOREIGN KEY (idSinfonia) REFERENCES Sinfonias(idSinfonia) ON DELETE CASCADE
);

-- 15. Tabela LogOrquestras
CREATE TABLE LogOrquestras (
    idLog INT PRIMARY KEY AUTO_INCREMENT,
    idOrquestra INT NOT NULL,
    acao VARCHAR(100),
    dataAcao DATETIME DEFAULT CURRENT_TIMESTAMP,
    detalhes TEXT,
    usuario VARCHAR(50),
    FOREIGN KEY (idOrquestra) REFERENCES Orquestras(idOrquestra) ON DELETE CASCADE
);

CREATE TABLE Patrocinadores (
    idPatrocinador INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    valorPatrocinio DECIMAL(12,2),
    idOrquestra INT,
    dataInicio DATE,
    dataFim DATE,
    FOREIGN KEY (idOrquestra) REFERENCES Orquestras(idOrquestra) ON DELETE CASCADE
);

CREATE TABLE Premios (
    idPremio INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    ano INT,
    idCompositor INT,
    descricao TEXT,
    FOREIGN KEY (idCompositor) REFERENCES Compositores(idCompositor) ON DELETE CASCADE
);


CREATE TABLE HistoricoSalarios (
    idHistorico INT PRIMARY KEY AUTO_INCREMENT,
    idMusico INT NOT NULL,
    idOrquestra INT NOT NULL,
    salarioAnterior DECIMAL(10,2) NOT NULL,
    salarioNovo DECIMAL(10,2) NOT NULL,
    dataAlteracao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idMusico) REFERENCES Musicos(idMusico),
    FOREIGN KEY (idOrquestra) REFERENCES Orquestras(idOrquestra)
);




-- Índices adicionais
CREATE INDEX idx_nome_compositor ON Compositores(nome);
CREATE INDEX idx_evento_data ON Eventos(data);
CREATE INDEX idx_musico_nome ON Musicos(nome);
CREATE INDEX idx_sinfonia_compositor ON Sinfonias(idCompositor);


