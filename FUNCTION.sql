DELIMITER //

CREATE FUNCTION fn_instrumento_info(p_idInstrumento INT)
RETURNS VARCHAR(255)
READS SQL DATA
BEGIN
    DECLARE v_nome VARCHAR(100);
    DECLARE v_tipo VARCHAR(50);
    DECLARE v_statusUso VARCHAR(20);
    DECLARE v_idOrquestra INT;
    DECLARE v_nomeOrquestra VARCHAR(100);
    DECLARE v_anoCriacao INT;
    DECLARE v_anoFim INT;
    DECLARE v_msg VARCHAR(255);

    IF p_idInstrumento IS NULL THEN
        RETURN 'Instrumento inválido.';
    END IF;

    -- Buscar dados do instrumento e seu status
    SELECT nome, tipo, 
           CASE WHEN statusUso = 1 THEN 'Em uso' ELSE 'Não em uso' END, 
           idOrquestra -- supondo que tenha essa FK indicando qual orquestra usa o instrumento
    INTO v_nome, v_tipo, v_statusUso, v_idOrquestra
    FROM Instrumentos
    WHERE idInstrumento = p_idInstrumento;

    IF v_nome IS NULL THEN
        RETURN 'Instrumento não encontrado.';
    END IF;

    IF v_idOrquestra IS NOT NULL THEN
        SELECT nome, anoCriacao, anoFim INTO v_nomeOrquestra, v_anoCriacao, v_anoFim
        FROM Orquestras
        WHERE idOrquestra = v_idOrquestra;
    ELSE
        SET v_nomeOrquestra = 'Nenhuma';
        SET v_anoCriacao = NULL;
        SET v_anoFim = NULL;
    END IF;

    SET v_msg = CONCAT(
        'Instrumento: ', v_nome, ' (', v_tipo, '), Status: ', v_statusUso, '. ',
        'Usado pela orquestra: ', v_nomeOrquestra, '. '
    );

    IF v_anoCriacao IS NOT NULL THEN
        SET v_msg = CONCAT(v_msg, 'Orquestra criada em ', v_anoCriacao);
        IF v_anoFim IS NOT NULL THEN
            SET v_msg = CONCAT(v_msg, ', finalizou em ', v_anoFim, '.');
        ELSE
            SET v_msg = CONCAT(v_msg, ', ainda ativa.');
        END IF;
    ELSE
        SET v_msg = CONCAT(v_msg, 'Sem informações da orquestra.');
    END IF;

    RETURN v_msg;
END //
DELIMITER ;


DELIMITER //

CREATE FUNCTION fn_orquestra_status(p_idOrquestra INT)
RETURNS VARCHAR(255)
READS SQL DATA
BEGIN
    DECLARE v_nome VARCHAR(100);
    DECLARE v_anoCriacao INT;
    DECLARE v_anoFim INT;
    DECLARE v_ativa VARCHAR(20);
    DECLARE v_qtdMusicos INT;
    DECLARE v_msg VARCHAR(255);

    IF p_idOrquestra IS NULL THEN
        RETURN 'Orquestra inválida.';
    END IF;

    SELECT nome, anoCriacao, anoFim
    INTO v_nome, v_anoCriacao, v_anoFim
    FROM Orquestras
    WHERE idOrquestra = p_idOrquestra;

    IF v_nome IS NULL THEN
        RETURN 'Orquestra não encontrada.';
    END IF;

    SET v_ativa = IF(v_anoFim IS NULL, 'Ativa', 'Encerrada');

    SELECT COUNT(*) INTO v_qtdMusicos
    FROM Musicos_Orquestras  -- tabela associativa músico-orquestra
    WHERE idOrquestra = p_idOrquestra;

    SET v_msg = CONCAT('Orquestra "', v_nome, '" criada em ', v_anoCriacao, '. Status: ', v_ativa, '. Músicos vinculados: ', v_qtdMusicos, '.');

    RETURN v_msg;
END //
DELIMITER ;


DELIMITER //

CREATE FUNCTION fn_musico_info(p_idMusico INT)
RETURNS VARCHAR(255)
READS SQL DATA
BEGIN
    DECLARE v_nome VARCHAR(100);
    DECLARE v_dataNasc DATE;
    DECLARE v_idade INT;
    DECLARE v_qtdOrquestrasAtivas INT;
    DECLARE v_msg VARCHAR(255);

    IF p_idMusico IS NULL THEN
        RETURN 'Músico inválido.';
    END IF;

    SELECT nome, dataNascimento INTO v_nome, v_dataNasc
    FROM Musicos
    WHERE idMusico = p_idMusico;

    IF v_nome IS NULL THEN
        RETURN 'Músico não encontrado.';
    END IF;

    IF v_dataNasc IS NULL OR v_dataNasc > CURDATE() THEN
        SET v_idade = NULL;
    ELSE
        SET v_idade = TIMESTAMPDIFF(YEAR, v_dataNasc, CURDATE());
    END IF;

    SELECT COUNT(*)
    INTO v_qtdOrquestrasAtivas
    FROM Musicos_Orquestras mo
    JOIN Orquestras o ON mo.idOrquestra = o.idOrquestra
    WHERE mo.idMusico = p_idMusico AND o.anoFim IS NULL;

    SET v_msg = CONCAT('Músico: ', v_nome, '. Idade: ', IFNULL(CAST(v_idade AS CHAR), 'Desconhecida'), '. Atualmente em orquestras ativas: ', v_qtdOrquestrasAtivas, '.');

    RETURN v_msg;
END //
DELIMITER ;


DELIMITER //

CREATE FUNCTION fn_instrumento_em_uso(p_idInstrumento INT)
RETURNS VARCHAR(255)
READS SQL DATA
BEGIN
    DECLARE v_nomeInstrumento VARCHAR(100);
    DECLARE v_idMusico INT;
    DECLARE v_nomeMusico VARCHAR(100);
    DECLARE v_msg VARCHAR(255);

    IF p_idInstrumento IS NULL THEN
        RETURN 'Instrumento inválido.';
    END IF;

    SELECT nome INTO v_nomeInstrumento
    FROM Instrumentos
    WHERE idInstrumento = p_idInstrumento;

    IF v_nomeInstrumento IS NULL THEN
        RETURN 'Instrumento não encontrado.';
    END IF;

    -- Aqui, assumo que há uma tabela Musicos_Instrumentos com idMusico, idInstrumento e dataFim (nulo se em uso)
    SELECT mi.idMusico, m.nome
    INTO v_idMusico, v_nomeMusico
    FROM Musicos_Instrumentos mi
    JOIN Musicos m ON mi.idMusico = m.idMusico
    WHERE mi.idInstrumento = p_idInstrumento AND mi.dataFim IS NULL
    LIMIT 1;

    IF v_idMusico IS NULL THEN
        SET v_msg = CONCAT('O instrumento "', v_nomeInstrumento, '" não está em uso atualmente.');
    ELSE
        SET v_msg = CONCAT('O instrumento "', v_nomeInstrumento, '" está sendo usado pelo músico ', v_nomeMusico, '.');
    END IF;

    RETURN v_msg;
END //
DELIMITER ;



DELIMITER //

CREATE FUNCTION fn_orquestra_resumo(p_idOrquestra INT)
RETURNS VARCHAR(255)
READS SQL DATA
BEGIN
    DECLARE v_nomeOrquestra VARCHAR(100);
    DECLARE v_anoCriacao INT;
    DECLARE v_anoFim INT;
    DECLARE v_qtdInstrumentos INT DEFAULT 0;
    DECLARE v_qtdMusicos INT DEFAULT 0;
    DECLARE v_status VARCHAR(20);
    DECLARE v_msg VARCHAR(255);

    IF p_idOrquestra IS NULL THEN
        RETURN 'Orquestra inválida.';
    END IF;

    SELECT nome, anoCriacao, anoFim INTO v_nomeOrquestra, v_anoCriacao, v_anoFim
    FROM Orquestras
    WHERE idOrquestra = p_idOrquestra;

    IF v_nomeOrquestra IS NULL THEN
        RETURN 'Orquestra não encontrada.';
    END IF;

    SET v_status = IF(v_anoFim IS NULL, 'Ativa', 'Encerrada');

    -- Quantidade instrumentos vinculados (assumindo Instrumentos tem idOrquestra FK)
    SELECT COUNT(*) INTO v_qtdInstrumentos
    FROM Instrumentos
    WHERE idOrquestra = p_idOrquestra;

    -- Quantidade músicos ativos (ligados à orquestra e sem data fim)
    SELECT COUNT(*) INTO v_qtdMusicos
    FROM Musicos_Orquestras mo
    JOIN Orquestras o ON mo.idOrquestra = o.idOrquestra
    WHERE mo.idOrquestra = p_idOrquestra AND o.anoFim IS NULL;

    SET v_msg = CONCAT(
        'Orquestra "', v_nomeOrquestra, '" criada em ', v_anoCriacao,
        ', Status: ', v_status,
        ', Instrumentos vinculados: ', v_qtdInstrumentos,
        ', Músicos ativos: ', v_qtdMusicos, '.'
    );

    RETURN v_msg;
END //
DELIMITER ;


DELIMITER //

CREATE FUNCTION fn_tempo_total_orquestras(p_idMusico INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_tempoTotal INT DEFAULT 0;

    IF p_idMusico IS NULL THEN
        RETURN NULL;
    END IF;

    /*
    Assumindo tabela Musicos_Orquestras com idMusico, idOrquestra, dataInicio, dataFim (dataFim pode ser NULL para ativo)
    */

    SELECT SUM(
        TIMESTAMPDIFF(YEAR,
            dataInicio,
            COALESCE(dataFim, CURDATE())
        )
    ) INTO v_tempoTotal
    FROM Musicos_Orquestras
    WHERE idMusico = p_idMusico;

    RETURN IFNULL(v_tempoTotal, 0);
END //
DELIMITER ;



