
DELIMITER $$

-- 1. Cadastrar músico com verificação de email e telefone únicos
CREATE PROCEDURE sp_cadastrar_musico(
    IN p_nome VARCHAR(100),
    IN p_data_nascimento DATE,
    IN p_telefone VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_genero ENUM('Masculino', 'Feminino', 'Outro', 'Prefiro não informar'),
    IN p_id_endereco INT,
    OUT p_resultado VARCHAR(200)
)
BEGIN
    DECLARE v_existente INT;

    SELECT COUNT(*) INTO v_existente FROM Musicos WHERE email = p_email OR telefone = p_telefone;

    IF v_existente > 0 THEN
        SET p_resultado = 'Erro: Email ou telefone já cadastrado';
    ELSE
        INSERT INTO Musicos (nome, dataNascimento, telefone, email, genero, idEndereco, status)
        VALUES (p_nome, p_data_nascimento, p_telefone, p_email, p_genero, p_id_endereco, 'Ativo');

        SET p_resultado = CONCAT('Músico cadastrado com sucesso - ID: ', LAST_INSERT_ID());
    END IF;

    SELECT * FROM Musicos WHERE email = p_email;
END$$

-- 2. Cadastrar orquestra com endereço completo
CREATE PROCEDURE sp_cadastrar_orquestra_com_endereco(
    IN p_nome VARCHAR(100),
    IN p_anoCriacao INT,
    IN p_website VARCHAR(100),
    IN p_rua VARCHAR(100),
    IN p_numero VARCHAR(10),
    IN p_bairro VARCHAR(50),
    IN p_cep VARCHAR(20),
    IN p_idCidade INT
)
BEGIN
    DECLARE v_idEndereco INT;

    INSERT INTO Enderecos (rua, numero, bairro, cep, idCidade)
    VALUES (p_rua, p_numero, p_bairro, p_cep, p_idCidade);

    SET v_idEndereco = LAST_INSERT_ID();

    INSERT INTO Orquestras (nome, anoCriacao, website, idEndereco, ativo)
    VALUES (p_nome, p_anoCriacao, p_website, v_idEndereco, TRUE);

    SELECT * FROM Orquestras WHERE idEndereco = v_idEndereco;
END$$

-- 3. Adicionar sinfonia a evento (verifica se não está repetida)
CREATE PROCEDURE sp_adicionar_sinfonia_evento(
    IN p_idEvento INT,
    IN p_idSinfonia INT
)
BEGIN
    DECLARE v_existe INT;

    SELECT COUNT(*) INTO v_existe FROM Repertorios 
    WHERE idEvento = p_idEvento AND idSinfonia = p_idSinfonia;

    IF v_existe = 0 THEN
        INSERT INTO Repertorios (idEvento, idSinfonia)
        VALUES (p_idEvento, p_idSinfonia);
    END IF;

    SELECT r.*, s.nome AS sinfonia
    FROM Repertorios r
    JOIN Sinfonias s ON r.idSinfonia = s.idSinfonia
    WHERE r.idEvento = p_idEvento;
END$$

-- 4. Criar evento e vincular multiplas orquestras
CREATE PROCEDURE sp_criar_evento_com_orquestras(
    IN p_nome VARCHAR(100),
    IN p_data DATE,
    IN p_horario TIME,
    IN p_preco DECIMAL(10,2),
    IN p_capacidade INT,
    IN p_idEndereco INT,
    IN p_orquestras TEXT -- Ex: '1,3,5'
)
BEGIN
    DECLARE v_idEvento INT;

    INSERT INTO Eventos (nome, data, horario, precoIngresso, capacidade, idEndereco)
    VALUES (p_nome, p_data, p_horario, p_preco, p_capacidade, p_idEndereco);

    SET v_idEvento = LAST_INSERT_ID();

    WHILE LOCATE(',', p_orquestras) > 0 DO
        INSERT INTO Eventos_Orquestras (idEvento, idOrquestra, cache)
        VALUES (v_idEvento, SUBSTRING_INDEX(p_orquestras, ',', 1), 10000);
        SET p_orquestras = SUBSTRING(p_orquestras, LOCATE(',', p_orquestras)+1);
    END WHILE;

    INSERT INTO Eventos_Orquestras (idEvento, idOrquestra, cache)
    VALUES (v_idEvento, p_orquestras, 10000);

    SELECT * FROM Eventos WHERE idEvento = v_idEvento;
END$$

-- 5. Atualizar dados do compositor
CREATE PROCEDURE sp_atualizar_compositor(
    IN p_idCompositor INT,
    IN p_nome VARCHAR(100),
    IN p_dataNasc DATE,
    IN p_dataFalecimento DATE,
    IN p_nacionalidade VARCHAR(100)
)
BEGIN
    UPDATE Compositores 
    SET nome = p_nome, 
        dataNascimento = p_dataNasc, 
        dataFalecimento = p_dataFalecimento, 
        nacionalidade = p_nacionalidade
    WHERE idCompositor = p_idCompositor;

    SELECT * FROM Compositores WHERE idCompositor = p_idCompositor;
END$$

-- 6. Registrar vários instrumentos para um músico
CREATE PROCEDURE sp_registrar_multiplos_instrumentos(
    IN p_idMusico INT,
    IN p_instrumentos TEXT -- Ex: '2,4,5'
)
BEGIN
    WHILE LOCATE(',', p_instrumentos) > 0 DO
        INSERT INTO Musicos_Instrumentos (idMusico, idInstrumento, nivelProficiencia, instrumentoPrincipal)
        VALUES (p_idMusico, SUBSTRING_INDEX(p_instrumentos, ',', 1), 'Básico', FALSE);
        SET p_instrumentos = SUBSTRING(p_instrumentos, LOCATE(',', p_instrumentos)+1);
    END WHILE;

    INSERT INTO Musicos_Instrumentos (idMusico, idInstrumento, nivelProficiencia, instrumentoPrincipal)
    VALUES (p_idMusico, p_instrumentos, 'Básico', FALSE);

    SELECT * FROM Musicos_Instrumentos WHERE idMusico = p_idMusico;
END$$

DELIMITER ;
