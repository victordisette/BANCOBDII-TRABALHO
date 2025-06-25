										#Procedure1
-- Cenário 1: Cadastro bem-sucedido
SET @resultado = '';
CALL sp_cadastrar_musico('Carlos Eduardo', '1985-07-22', '(21)98765-4321', 'carlos.eduardo@email.com', 'Masculino', 1, @resultado);
SELECT @resultado;

-- Cenário 2: E-mail duplicado (deve falhar)
SET @resultado = '';
CALL sp_cadastrar_musico('Victor sette', '1990-01-15', '(21)91234-5678', 'carlos.eduardo@email.com', 'Masculino', 1, @resultado);
SELECT @resultado;

SET @resultado = '';
CALL sp_cadastrar_musico('Victor sette', '1990-01-15', '(21)91234-5678', 'victor.sette@email.com', 'Masculino', 1, @resultado);
SELECT @resultado;

									#Procedure2
-- Cenário 1: Cadastro bem-sucedido
SET @resultado = '';
CALL sp_cadastrar_orquestra_com_endereco('Orquestra Sinfônica Carioca', 2018, 'www.osc.com.br', 
'Av. Rio Branco', '156', '3º andar', 'Centro', '20040-002', 3, @resultado);
SELECT @resultado;

-- Cenário 2: Cidade inexistente (deve falhar)
SET @resultado = '';
CALL sp_cadastrar_orquestra_com_endereco('Orquestra Teste', 2023, 'www.teste.com', 
'Rua Inexistente', '123', NULL, 'Bairro', '00000-000', 999, @resultado);
SELECT @resultado;

										#Procedure 3 
								
-- Agora execute os testes
-- Cenário 1: Agendamento bem-sucedido
CALL sp_agendar_ensaio(1, '2023-12-18 10:00:00', 90, 'Sala de Ensaios A', 'Maestro Roberto');
-- Cenário 2: Conflito de horário
CALL sp_agendar_ensaio(1, '2023-12-20 09:00:00', 120, 'Sala B', 'Maestro Carlos');
CALL sp_agendar_ensaio(1, '2023-12-20 10:30:00', 60, 'Sala C', 'Maestro Pedro'); -- Deve falhar  

SELECT * FROM Ensaios
WHERE idOrquestra = 1 AND data_ensaio = '2023-12-18 10:00:00'; 

SELECT * FROM Ensaios
WHERE idOrquestra = 1 AND data_ensaio = '2023-12-20 09:00:00';  

										#Procedure 4 
                                        
-- Registra festival
CALL sp_registrar_festival(1, 'Festival Internacional de Música', 'São Paulo', '2024-07-10', '2024-07-15', 
12000.00, 'Melhor performance orquestral');

-- Verifica registro
SELECT * FROM Festivais WHERE idOrquestra = 1 ORDER BY data_inicio DESC LIMIT 1;   


											#procedure 5                      
CALL sp_atualizar_compositor(1, 'Ludwig van Beethoven', '1770-12-17', '1827-03-26', 'Alemão');

SELECT *
FROM Compositores
WHERE idCompositor = 1;

											#procedure 6 
CALL sp_registrar_multiplos_instrumentos(2, '3,4,6');

SELECT mi.idMusico, mi.idInstrumento, i.nome AS nomeInstrumento, mi.nivelProficiencia, mi.instrumentoPrincipal
FROM Musicos_Instrumentos mi
JOIN Instrumentos i ON mi.idInstrumento = i.idInstrumento
WHERE mi.idMusico = 2;                          



											-- Function

-- 1. Testar função fn_calcularIdade
SELECT fn_calcularIdade('1990-05-20') AS idade; 
-- Esperado: idade atual de uma pessoa nascida em 20/05/1990 (exemplo)

-- 2. Testar função fn_tempoTotalOrquestra  TESTE
SELECT fn_tempoTotalOrquestra(1, 2) AS meses_totais;
-- Exemplo: total de meses que o músico com id 1 ficou na orquestra 1

-- 3. Testar função fn_qtdMusicosInstrumento
SELECT fn_qtdMusicosInstrumento(4) AS qtd_musicos;
-- Exemplo: quantidade de músicos que tocam o instrumento com id 2

-- 4. Testar fn_qtdEventosOrquestra
SELECT fn_qtdEventosOrquestra(1) AS qtd_eventos;
-- Quantidade de eventos que orquestra 3 participou

SELECT 
    eo.idEvento,
    m.idMusico,
    m.nome AS nomeMusico,
    eo.idOrquestra
FROM Eventos_Orquestras eo
JOIN Musicos_Orquestras mo ON eo.idOrquestra = mo.idOrquestra
JOIN Musicos m ON mo.idMusico = m.idMusico
WHERE mo.dataSaida IS NULL
ORDER BY eo.idEvento, m.nome;


-- 5. Testar função fn_tempoOrquestra
SELECT fn_tempoOrquestra(1, 1) AS meses_ultimo_periodo;
-- Exemplo: meses desde a última entrada do músico 2 na orquestra 1

-- 6. Testar função fn_mediaSalarioOrquestra
SELECT fn_mediaSalarioOrquestra(2) AS salario_medio;
-- Exemplo: média salarial dos músicos ativos na orquestra 1



											#TRIGGER

												#1
-- Associe o músico a uma orquestra (sem data de saída)
INSERT INTO Musicos_Orquestras (idMusico, idOrquestra, dataEntrada, salario)
VALUES (1001, 1, '2023-01-01', 2000.00);

-- Atualize o status do músico para Inativo
UPDATE Musicos SET status = 'Inativo' WHERE idMusico = 1001;

-- Verifique se a data de saída foi preenchida automaticamente
SELECT * FROM Musicos_Orquestras WHERE idMusico = 1001;

-- Verifique se o histórico foi registrado
SELECT * FROM HistoricoStatusMusicos WHERE idMusico = 1001;

											#2 o salario minimo é de 1320
-- Caso 1: Inserir músico com salário abaixo do mínimo (1320.00) -> Deve falhar
INSERT INTO Musicos_Orquestras (idMusico, idOrquestra, dataEntrada, salario)
VALUES (2002, 100, CURDATE(), 1000.00);

-- Caso 2: Inserir músico para orquestra inativa (idOrquestra = 101) -> Deve falhar
INSERT INTO Musicos_Orquestras (idMusico, idOrquestra, dataEntrada, salario)
VALUES (2002, 101, CURDATE(), 1200.00);

-- Caso 3: Inserir músico com salário mais que 50% acima da média salarial da orquestra 100 (média 2000.00, 50% acima = 3000.00) -> Deve falhar
INSERT INTO Musicos_Orquestras (idMusico, idOrquestra, dataEntrada, salario)
VALUES (2003, 101, CURDATE(), 3500.00);

-- Caso 4: Inserir músico com salário válido (entre mínimo e até 50% acima da média) -> Deve funcionar
INSERT INTO Musicos_Orquestras (idMusico, idOrquestra, dataEntrada, salario)
VALUES (2002, 100, CURDATE(), 2900.00);



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


