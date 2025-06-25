						-- PROCEDURES 
-- _______________________________________________________-- 
#1
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

SELECT 
    o.idOrquestra,
    o.nome AS nome_orquestra,
    o.anoCriacao,
    o.website,
    o.email,
    o.ativo,
    e.rua,
    e.numero,
    e.bairro,
    e.cep,
    c.nome AS cidade,
    es.nome AS estado,
    es.sigla AS uf
FROM Orquestras o
JOIN Enderecos e ON o.idEndereco = e.idEndereco
JOIN Cidades c ON e.idCidade = c.idCidade
JOIN Estados es ON c.idEstado = es.idEstado
WHERE o.nome = 'Orquestra Harmonia';


						-- FUNCTIONS-- 
-- _______________________________________________________-- 
#1
-- 4. Testar fn_qtdEventosOrquestra
SELECT fn_qtdEventosOrquestra(10) AS qtd_eventos;
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


#2
-- 6. Testar fn_mediaSalarioOrquestra
SELECT fn_mediaSalarioOrquestra(1) AS salario_medio;
-- Média salarial dos músicos ativos na orquestra 1

SELECT AVG(salario) AS salario_medio
FROM Musicos_Orquestras
WHERE idOrquestra = 1 AND dataSaida IS NULL;


						-- TRIGGERS-- 
-- _______________________________________________________-- 



#1

SELECT idMusico, nome, status FROM Musicos WHERE idMusico = 2;
SELECT * FROM Musicos_Orquestras WHERE idMusico = 2 AND dataSaida IS NULL;


UPDATE Musicos SET status = 'Inativo' WHERE idMusico = 2;


SELECT idMusico, nome, status FROM Musicos WHERE idMusico = 2;
SELECT * FROM Musicos_Orquestras WHERE idMusico = 2;

#2

INSERT INTO Musicos_Orquestras (idMusico, idOrquestra, dataEntrada, salario)
VALUES (3, 1, CURDATE(), 1000.00);


INSERT INTO Musicos_Orquestras (idMusico, idOrquestra, dataEntrada, salario)
VALUES (3, 1, CURDATE(), 1500.00);


SELECT * FROM Musicos_Orquestras WHERE idMusico = 3 AND idOrquestra = 1;
