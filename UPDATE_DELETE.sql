-- 1. Atualizar o status de um músico para inativo
UPDATE Musicos SET status = 'Inativo' WHERE idMusico = 5;

-- 2. Atualizar o email de um músico
UPDATE Musicos SET email = 'novo.email@musico.com' WHERE idMusico = 3;

-- 3. Atualizar o salário de um músico em uma orquestra
UPDATE Musicos_Orquestras SET salario = 9000.00 
WHERE idMusico = 1 AND idOrquestra = 1;

-- 4. Atualizar a data de falecimento de um compositor
UPDATE Compositores SET dataFalecimento = '2023-12-31' 
WHERE idCompositor = 15;

-- 5. Atualizar o preço dos ingressos para um evento
UPDATE Eventos SET precoIngresso = precoIngresso * 1.1 
WHERE idEvento = 5;

-- 6. Atualizar o nível de proficiência de um músico em um instrumento
UPDATE Musicos_Instrumentos SET nivelProficiencia = 'Expert' 
WHERE idMusico = 7 AND idInstrumento = 7;

-- 7. Atualizar o website de uma orquestra
UPDATE Orquestras SET website = 'www.novosite.org.br' 
WHERE idOrquestra = 4;

-- 8. Atualizar o complemento de um endereço
UPDATE Enderecos SET complemento = 'Sala 502' 
WHERE idEndereco = 3;

-- 9. Atualizar a descrição de um instrumento
UPDATE Instrumentos SET descricao = CONCAT(descricao, ' Muito utilizado em orquestras sinfônicas.') 
WHERE idInstrumento = 1;

-- 10. Atualizar o horário de um evento
UPDATE Eventos SET horario = '20:30:00' 
WHERE idEvento = 8;

-- 11. Deletar um patrocinador específico (não precisa de correção - usa PK)
DELETE FROM Patrocinadores WHERE idPatrocinador = 6;

-- 12. Deletar prêmios anteriores a 2010 (corrigido)
DELETE FROM Premios 
WHERE idPremio IN (SELECT idPremio FROM (SELECT idPremio FROM Premios WHERE ano < 2010) AS temp);

-- 13. Deletar um evento cancelado (não precisa de correção - usa PK)
DELETE FROM Eventos WHERE idEvento = 13;

-- 14. Deletar a relação de um músico com um instrumento secundário (não precisa - usa PK composta)
DELETE FROM Musicos_Instrumentos 
WHERE idMusico = 2 AND idInstrumento = 1;

-- 15. Deletar músicos inativos (corrigido)
DELETE FROM Musicos 
WHERE idMusico IN (SELECT idMusico FROM (SELECT idMusico FROM Musicos WHERE status = 'Inativo') AS temp);

-- 16. Deletar orquestras inativas (corrigido)
DELETE FROM Orquestras 
WHERE idOrquestra IN (SELECT idOrquestra FROM (SELECT idOrquestra FROM Orquestras WHERE ativo = FALSE) AS temp);

-- 17. Deletar sinfonias sem compositor conhecido (não precisa - usa PK)
DELETE FROM Sinfonias WHERE idCompositor IS NULL;

-- 18. Deletar relações de eventos com orquestras onde o cache é menor que 15000 (corrigido)
DELETE FROM Eventos_Orquestras 
WHERE (idEvento, idOrquestra) IN (
    SELECT idEvento, idOrquestra FROM (
        SELECT idEvento, idOrquestra FROM Eventos_Orquestras 
        WHERE cache < 15000
    ) AS temp
);

