-- Desativar verificação de chaves estrangeiras temporariamente
SET FOREIGN_KEY_CHECKS = 0;

-- Excluir todas as tabelas na ordem inversa de criação
DROP TABLE IF EXISTS LogOrquestras;
DROP TABLE IF EXISTS Repertorios;
DROP TABLE IF EXISTS Eventos_Orquestras;
DROP TABLE IF EXISTS Eventos_Compositores;
DROP TABLE IF EXISTS Eventos;
DROP TABLE IF EXISTS Musicos_Orquestras;
DROP TABLE IF EXISTS Musicos_Instrumentos;
DROP TABLE IF EXISTS Patrocinadores;
DROP TABLE IF EXISTS Premios;
DROP TABLE IF EXISTS Sinfonias;
DROP TABLE IF EXISTS Instrumentos;
DROP TABLE IF EXISTS Orquestras;
DROP TABLE IF EXISTS Musicos;
DROP TABLE IF EXISTS Compositores;
DROP TABLE IF EXISTS Enderecos;
DROP TABLE IF EXISTS Cidades;
DROP TABLE IF EXISTS Estados;

-- Reativar verificação de chaves estrangeiras
SET FOREIGN_KEY_CHECKS = 1;

-- Excluir o banco de dados
DROP DATABASE IF EXISTS MINI_Escola;