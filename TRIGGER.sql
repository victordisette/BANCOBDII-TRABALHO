DELIMITER //

CREATE TRIGGER trg_update_dataSaida_on_musico_inativo
AFTER UPDATE ON Musicos
FOR EACH ROW
BEGIN
    IF NEW.status = 'Inativo' AND OLD.status <> 'Inativo' THEN
        UPDATE Musicos_Orquestras
        SET dataSaida = CURDATE()
        WHERE idMusico = NEW.idMusico AND dataSaida IS NULL;
    END IF;
END;
//

DELIMITER ;


DELIMITER //

CREATE TRIGGER trg_check_salario_minimo
BEFORE INSERT ON Musicos_Orquestras
FOR EACH ROW
BEGIN
    IF NEW.salario < 1200 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salario inferior ao minimo permitido!';
    END IF;
END;
//

CREATE TRIGGER trg_check_salario_minimo_update
BEFORE UPDATE ON Musicos_Orquestras
FOR EACH ROW
BEGIN
    IF NEW.salario < 1200 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salario inferior ao minimo permitido!';
    END IF;
END;
//

DELIMITER ;


DELIMITER //

CREATE TRIGGER trg_update_orquestra_ativo_on_delete_musico
AFTER DELETE ON Musicos_Orquestras
FOR EACH ROW
BEGIN
    DECLARE total_ativos INT;
    SELECT COUNT(*) INTO total_ativos FROM Musicos_Orquestras
    WHERE idOrquestra = OLD.idOrquestra AND dataSaida IS NULL;
    
    IF total_ativos = 0 THEN
        UPDATE Orquestras SET ativo = FALSE WHERE idOrquestra = OLD.idOrquestra;
    END IF;
END;
//

DELIMITER ;



DELIMITER //

CREATE TRIGGER trg_prevent_delete_sinfonia_with_repertorio
BEFORE DELETE ON Sinfonias
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM Repertorios WHERE idSinfonia = OLD.idSinfonia) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nao e possivel deletar sinfonia com repertorio associado.';
    END IF;
END;
//

DELIMITER ;


DELIMITER //

CREATE TRIGGER trg_update_cache_medio_after_insert
AFTER INSERT ON Eventos_Orquestras
FOR EACH ROW
BEGIN
    UPDATE Orquestras o
    SET cacheMedio = (
        SELECT AVG(cache) FROM Eventos_Orquestras WHERE idOrquestra = NEW.idOrquestra
    )
    WHERE o.idOrquestra = NEW.idOrquestra;
END;
//

CREATE TRIGGER trg_update_cache_medio_after_update
AFTER UPDATE ON Eventos_Orquestras
FOR EACH ROW
BEGIN
    UPDATE Orquestras o
    SET cacheMedio = (
        SELECT AVG(cache) FROM Eventos_Orquestras WHERE idOrquestra = NEW.idOrquestra
    )
    WHERE o.idOrquestra = NEW.idOrquestra;
END;
//

DELIMITER ;


DELIMITER //

CREATE TRIGGER trg_check_evento_data_passada
BEFORE INSERT ON Eventos
FOR EACH ROW
BEGIN
    IF NEW.data < CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data do evento nao pode ser anterior a hoje.';
    END IF;
END;
//

DELIMITER ;

