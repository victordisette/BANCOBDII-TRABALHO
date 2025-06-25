ALTER TABLE Compositores ADD COLUMN nacionalidade VARCHAR(50);

ALTER TABLE Sinfonias MODIFY COLUMN duracao INT COMMENT 'Duração em minutos';

ALTER TABLE Musicos ADD COLUMN status ENUM('Ativo', 'Inativo', 'Aposentado') DEFAULT 'Ativo';

ALTER TABLE Musicos ADD CONSTRAINT uk_musico_email UNIQUE (email);

ALTER TABLE Orquestras ADD COLUMN dataFundacao DATE AFTER anoCriacao;

ALTER TABLE Musicos MODIFY COLUMN genero ENUM('Masculino', 'Feminino', 'Outro', 'Prefiro não informar');

ALTER TABLE Musicos ADD COLUMN foto VARCHAR(255) COMMENT 'URL da foto do músico';

ALTER TABLE Eventos ADD COLUMN classificacaoEtaria VARCHAR(20) DEFAULT 'Livre';

ALTER TABLE Orquestras ADD COLUMN cacheMedio DECIMAL(10,2) DEFAULT 0.00;

ALTER TABLE Musicos MODIFY telefone VARCHAR(20) NOT NULL DEFAULT '0000000000';

ALTER TABLE Repertorios
MODIFY ordemExecucao INT NOT NULL DEFAULT 1;

