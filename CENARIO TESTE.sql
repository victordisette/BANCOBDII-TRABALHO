#DEMOSTRAÇÃO DAs ATIVIDADES


# PROCEDURES 

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
'Rua Inexistente', '123', NULL, 'Bairro', '00000-000', 1, @resultado);
SELECT @resultado;



#FUNCTION 

-- 1. Testar função fn_calcularIdade
SELECT fn_calcularIdade('1995-05-20') AS idade; 
-- Esperado: idade atual de uma pessoa nascida em 20/05/1990 (exemplo)

-- 2. Testar função fn_tempoTotalOrquestra  TESTE
SELECT fn_tempoTotalOrquestra(3, 2) AS meses_totais;
-- Exemplo: total de meses que o músico com id 1 ficou na orquestra 1


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

-- Caso 3
INSERT INTO Musicos_Orquestras (idMusico, idOrquestra, dataEntrada, salario)
VALUES (2001, 100, CURDATE(), 3000.00);





