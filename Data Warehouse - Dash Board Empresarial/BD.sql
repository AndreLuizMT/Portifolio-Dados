-- Criando banco de dados (DDL) --
CREATE DATABASE erp;

-- Selecionando o BD para uso --
USE erp;

-- CRIAR TABELA VENDEDOR --
CREATE TABLE tbvdd(
	cdvdd	SMALLINT PRIMARY KEY NOT NULL,
	nmvdd	VARCHAR(20),
	sxvdd	SMALLINT, -- 0 = F e 1 = M --
	perccomissao	DECIMAL(19,2),
	matfunc	SMALLINT NOT NULL
);

-- CRIAR TABELA DEPENDENTES --
CREATE TABLE tbdep (
	cddep SMALLINT PRIMARY KEY,
	nmdep VARCHAR(20),
	dtnasc DATETIME,
	sxdep VARCHAR(2),
	inepescola VARCHAR(10),
	matfunc smallint,
	CONSTRAINT FK_dep_vdd FOREIGN KEY (matfunc) REFERENCES tbvdd(cdvdd)
);

-- CRIAR TABELA PRODUTO --
CREATE TABLE tbpro (
	cdpro SMALLINT PRIMARY KEY,
	nmpro VARCHAR(50),
	tppro VARCHAR(1),
	undpro VARCHAR(2),
	slpro SMALLINT,
	stpro VARCHAR(50),
	vlpro DECIMAL(10,2) NOT NULL
);

-- CRIAR TABELA CLIENTE -- 
CREATE TABLE tbcli (
	cdcli SMALLINT PRIMARY KEY,
	nmcli VARCHAR(50),
	agecli SMALLINT,
	clacli SMALLINT,
	sxcli VARCHAR(1),
	cidcli VARCHAR(50),
	estcli VARCHAR(50),
	paicli VARCHAR(50)
);

--CRIAR TABELA VENDA -- 
CREATE TABLE tbven (
	cdven SMALLINT PRIMARY KEY,
	dtven DATE,
	qtven INT,
	vruven DECIMAL(18,2),
	vrtven DECIMAL(18,2) NOT NULL,
	canal VARCHAR(12) NOT NULL,
	stven SMALLINT,
	deleted SMALLINT,
	cdpro SMALLINT,
	cdvdd SMALLINT,
	cdcli SMALLINT,
	CONSTRAINT FK_ven_pro FOREIGN KEY (cdpro) REFERENCES tbpro(cdpro),
	CONSTRAINT FK_ven_vdd FOREIGN KEY (cdvdd) REFERENCES tbvdd(cdvdd),
	CONSTRAINT FK_ven_cli FOREIGN KEY (cdcli) REFERENCES tbcli(cdcli),
);


-- Populando Vendedor(DML) --
INSERT INTO tbvdd VALUES (1 ,'Vendedor A', 1, 1, 1);
INSERT INTO tbvdd VALUES (2 ,'Vendedor B', 1, 1, 2);
INSERT INTO tbvdd VALUES (3 ,'Vendedor C', 1, 1, 3);
INSERT INTO tbvdd VALUES (4 ,'Vendedor D', 1, 0.5, 4);
INSERT INTO tbvdd VALUES (5 ,'Vendedor E', 0, 0.5, 5);
INSERT INTO tbvdd VALUES (6 ,'Vendedor F', 1, 0.5, 6);
INSERT INTO tbvdd VALUES (7 ,'Vendedor G', 0, 0.5, 7);
INSERT INTO tbvdd VALUES (8 ,'Vendedor H', 1, 0.5, 8);
INSERT INTO tbvdd VALUES (9 ,'Vendedor I', 0, 0.5, 9);
INSERT INTO tbvdd VALUES (10 ,'Vendedor J', 1, 0.5, 10);

-- Populando Dependentes(DML) --
INSERT INTO tbdep VALUES(1,'Dependente 1', '20100204', 'M', '33062277', 1);
INSERT INTO tbdep VALUES(2,'Dependente 2', '20100205', 'M', '32072562', 2);
INSERT INTO tbdep VALUES(3,'Dependente 3', '20100206', 'F', '25063111', 3);
INSERT INTO tbdep VALUES(4,'Dependente 4', '20100208', 'M', '13106236', 4);
INSERT INTO tbdep VALUES(5,'Dependente 5', '20100209', 'M', '26127890', 5);
INSERT INTO tbdep VALUES(6,'Dependente 6', '20100210', 'F', '51061180', 6);
INSERT INTO tbdep VALUES(7,'Dependente 7', '20100211', 'M', '23249757', 7);
INSERT INTO tbdep VALUES(8,'Dependente 8', '20100212', 'F', '21188092', 8);
INSERT INTO tbdep VALUES(9,'Dependente 9', '20100213', 'F', '29311578', 9);
INSERT INTO tbdep VALUES(10,'Dependente 10', '20100214', 'M', '26101327', 10);

-- Populando Produto(DML) --
INSERT INTO tbpro VALUES (1, 'Produto A', 'A', 'KG', 20000, 'Ativo', 0.34);
INSERT INTO tbpro VALUES (2, 'Produto N', 'B', 'KG', 10000, 'Ativo', 0.50);
INSERT INTO tbpro VALUES (3, 'Produto F', 'C', 'KG', 20000, 'Ativo', 0.80);
INSERT INTO tbpro VALUES (4, 'Produto S', 'A', 'KG', 20000, 'Ativo', 0.90);
INSERT INTO tbpro VALUES (5, 'Produto W', 'C', 'KG', 30000, 'Ativo', 0.40);
INSERT INTO tbpro VALUES (6, 'Produto U', 'B', 'KG', 10000, 'Ativo', 1.0);
INSERT INTO tbpro VALUES (7, 'Produto Z', 'X', 'KG', 20000, 'Ativo', 0.70);
INSERT INTO tbpro VALUES (8, 'Produto L', 'Q', 'KG', 20000, 'Ativo', 0.35);
INSERT INTO tbpro VALUES (9, 'Produto O', 'A', 'KG', 10000, 'Ativo', 0.80);
INSERT INTO tbpro VALUES (10, 'Produto I', 'X', 'KG', 15000, 'Ativo', 0.52);
INSERT INTO tbpro VALUES (11, 'Produto H', 'B', 'KG', 30200, 'Ativo', 0.33);
INSERT INTO tbpro VALUES (12, 'Produto V', 'C', 'KG', 12000, 'Ativo', 0.50);
INSERT INTO tbpro VALUES (13, 'Produto Z', 'T', 'KG', 15000, 'Ativo', 0.80);
INSERT INTO tbpro VALUES (14, 'Produto X', 'H', 'KG', 20000, 'Ativo', 0.40);
INSERT INTO tbpro VALUES (15, 'Produto Y', 'O', 'KG', 14500, 'Ativo', 0.90);

-- Populando Cliente(DML) --

INSERT INTO tbcli VALUES (1, 'Cliente A', 20, 2, 'M', 'Tianguá', 'Ceará', 'Brasil');
INSERT INTO tbcli VALUES (2, 'Cliente B', 25, 2, 'M', 'Sobral', 'Ceará', 'Brasil');
INSERT INTO tbcli VALUES (3, 'Cliente C', 23, 2, 'F', 'Brasília', 'Distrito Federal', 'Brasil');
INSERT INTO tbcli VALUES (4, 'Cliente D', 24, 2, 'M', 'São Paulo', 'São Paulo', 'Brasil');
INSERT INTO tbcli VALUES (5, 'Cliente E', 28, 2, 'M', 'Rio Branco', 'Acre', 'Brasil');
INSERT INTO tbcli VALUES (6, 'Cliente F', 30, 2, 'F', 'Rio de Janeiro', 'Rio de Janeiro', 'Brasil');
INSERT INTO tbcli VALUES (7, 'Cliente G', 21, 2, 'F', 'Fortaleza', 'Ceará', 'Brasil');
INSERT INTO tbcli VALUES (8, 'Cliente H', 49, 2, 'F', 'Ipú', 'Ceará', 'Brasil');
INSERT INTO tbcli VALUES (9, 'Cliente I', 52, 2, 'M', 'Sobral', 'Ceará', 'Brasil');
INSERT INTO tbcli VALUES (10, 'Cliente J', 30, 2, 'F', 'Palmas', 'Tocantins', 'Brasil');

-- Populando Vendas (DML) --
INSERT INTO tbven VALUES (1, '2022-04-01', 4000, 0.34, 1360.00, 'Loja Própria', 1, 0, 1, 1, 1);
INSERT INTO tbven VALUES (2, '2022-04-02', 1000, 0.50, 500.00, 'Loja Própria', 1, 0, 2, 2, 2);
INSERT INTO tbven VALUES (3, '2022-04-03', 2000, 0.80, 1600.00, 'Loja Virtual', 3, 0, 3, 3, 3);
INSERT INTO tbven VALUES (4, '2022-04-04', 3000, 0.90, 2700.00, 'Loja Própria', 1, 0, 4, 4, 4);
INSERT INTO tbven VALUES (5, '2022-04-05', 4000, 0.40, 1600.00, 'Loja Virtual', 2, 0, 5, 5, 5);
INSERT INTO tbven VALUES (6, '2022-04-06', 4000, 1.00, 4000.00, 'Loja Própria', 1, 0, 6, 6, 6);
INSERT INTO tbven VALUES (7, '2022-04-07', 2000, 0.70, 1400.00, 'Loja Própria', 1, 0, 7, 7, 7);
INSERT INTO tbven VALUES (8, '2022-04-08', 1000, 0.35, 350.00, 'Loja Virtual', 1, 0, 8, 8, 8);
INSERT INTO tbven VALUES (9, '2022-04-09', 5000, 0.80, 4000.00, 'Loja Própria', 1, 0, 9, 9, 9);
INSERT INTO tbven VALUES (10, '2022-04-10', 1000, 0.52, 520.00, 'Loja Virtual', 1, 0, 10, 10, 10);
