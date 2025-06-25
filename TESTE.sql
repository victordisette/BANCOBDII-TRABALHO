CALL sp_cadastrar_musico(
    'Ana Lúcia', '1990-07-12', '81999990000', 'ana.lucia@email.com',
    'Feminino', 2, @resultado
);
SELECT @resultado;
#2
CALL sp_cadastrar_orquestra_com_endereco(
    'Orquestra Harmonia',
    1998,
    'www.harmonia.com.br',
    'Rua Central',
    '200',
    'Centro',
    '50710-000',
    1
);

-- Verifica se a orquestra foi criada
SELECT * FROM Orquestras WHERE nome = 'Orquestra Harmonia';

-- Verifica o endereço associado
SELECT * FROM Enderecos WHERE rua = 'Rua Central' AND numero = '200';

#3
CALL sp_adicionar_sinfonia_evento(1, 3);

SELECT * FROM Repertorios WHERE idEvento = 1;


#4
CALL sp_criar_evento_com_orquestras(
    'Concerto das Estrelas', '2025-12-10', '19:30:00',
    75.00, 500, 3, '1,2'
);

SELECT 
    e.idEvento,
    e.nome AS Evento,
    e.data,
    e.horario,
    e.precoIngresso,
    e.capacidade,
    o.idOrquestra,
    o.nome AS Orquestra
FROM Eventos e
JOIN Eventos_Orquestras eo ON e.idEvento = eo.idEvento
JOIN Orquestras o ON eo.idOrquestra = o.idOrquestra
WHERE e.nome = 'Concerto das Estrelas';


#5

CALL sp_atualizar_compositor(1, 'Ludwig van Beethoven', '1770-12-17', '1827-03-26', 'Alemão');

SELECT *
FROM Compositores
WHERE idCompositor = 1;


#6

CALL sp_registrar_multiplos_instrumentos(2, '3,4,6');

SELECT mi.idMusico, mi.idInstrumento, i.nome AS nomeInstrumento, mi.nivelProficiencia, mi.instrumentoPrincipal
FROM Musicos_Instrumentos mi
JOIN Instrumentos i ON mi.idInstrumento = i.idInstrumento
WHERE mi.idMusico = 2;




-- Function



#TRIGGER 

#1
-- Ver status atual do músico e da tabela Musicos_Orquestras
SELECT idMusico, nome, status FROM Musicos WHERE idMusico = 2;
SELECT * FROM Musicos_Orquestras WHERE idMusico = 2 AND dataSaida IS NULL;

-- Atualizar status para Inativo (dispara trigger que atualiza dataSaida)
UPDATE Musicos SET status = 'Inativo' WHERE idMusico = 2;

-- Verificar novamente as tabelas após update
SELECT idMusico, nome, status FROM Musicos WHERE idMusico = 2;
SELECT * FROM Musicos_Orquestras WHERE idMusico = 2;

#2

-- Tentar inserir com salário abaixo do mínimo (deve dar erro)
INSERT INTO Musicos_Orquestras (idMusico, idOrquestra, dataEntrada, salario)
VALUES (3, 1, CURDATE(), 1000.00);

-- Inserir com salário válido (deve funcionar)
INSERT INTO Musicos_Orquestras (idMusico, idOrquestra, dataEntrada, salario)
VALUES (3, 1, CURDATE(), 1500.00);

-- Verificar dados inseridos
SELECT * FROM Musicos_Orquestras WHERE idMusico = 3 AND idOrquestra = 1;

#3

-- Atualizar salário para valor inválido (deve dar erro)
UPDATE Musicos_Orquestras SET salario = 1100.00 WHERE idMusico = 3 AND idOrquestra = 1;

-- Atualizar para valor válido (deve funcionar)
UPDATE Musicos_Orquestras SET salario = 1800.00 WHERE idMusico = 3 AND idOrquestra = 1;

-- Verificar dados atualizados
SELECT * FROM Musicos_Orquestras WHERE idMusico = 3 AND idOrquestra = 1;


#4

-- Ver status atual da orquestra
SELECT idOrquestra, nome, ativo FROM Orquestras WHERE idOrquestra = 1;

-- Ver todos os músicos ativos na orquestra 1
SELECT * FROM Musicos_Orquestras WHERE idOrquestra = 1 AND dataSaida IS NULL;

-- Deletar todos os músicos ativos da orquestra 1 (dispara trigger que pode atualizar ativo)
DELETE FROM Musicos_Orquestras WHERE idOrquestra = 1 AND dataSaida IS NULL;

-- Verificar se orquestra foi desativada
SELECT idOrquestra, nome, ativo FROM Orquestras WHERE idOrquestra = 1;


#5

-- Verificar se sinfonia 2 tem repertório (deve retornar linhas)
SELECT * FROM Repertorios WHERE idSinfonia = 2;

-- Verificar se sinfonia 10 tem repertório (deve retornar vazio)
SELECT * FROM Repertorios WHERE idSinfonia = 10;

-- Tentar deletar sinfonia 2 (deve falhar por trigger)
DELETE FROM Sinfonias WHERE idSinfonia = 2;

-- Se sinfonia 10 não tem repertório, deletar com sucesso
DELETE FROM Sinfonias WHERE idSinfonia = 10;

-- Verificar sinfonias após deletar
SELECT * FROM Sinfonias WHERE idSinfonia IN (2, 10);



#6

-- Ver cache médio atual da orquestra 2
SELECT idOrquestra, nome, cacheMedio FROM Orquestras WHERE idOrquestra = 2;

-- Inserir um novo evento_orquestra (dispara trigger que atualiza cacheMedio)
INSERT INTO Eventos_Orquestras (idEvento, idOrquestra, cache)
VALUES (5, 2, 800.00);

-- Ver cache médio atualizado da orquestra 2
SELECT idOrquestra, nome, cacheMedio FROM Orquestras WHERE idOrquestra = 2;

-- Atualizar cache de evento_orquestra (dispara trigger que atualiza cacheMedio)
UPDATE Eventos_Orquestras SET cache = 900.00 WHERE idEvento = 5 AND idOrquestra = 2;

-- Ver cache médio atualizado da orquestra 2 novamente
SELECT idOrquestra, nome, cacheMedio FROM Orquestras WHERE idOrquestra = 2;

