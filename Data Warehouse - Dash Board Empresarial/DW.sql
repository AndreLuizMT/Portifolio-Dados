-- DW

-- ETL (Extract, Transform e Load)

-------------------------
--	** Stage Area **
-------------------------

-- CRIAR UM STAGE AREA --
CREATE DATABASE stage_area;

-- Selecionando BD para uso --
USE stage_area;

---------------------------------------
-- ** EXTRACT / LOAD / TRANSFORM  **
---------------------------------------
-- VENDEDOR

DROP TABLE IF EXISTS stage_area..tbvdd;
SELECT cdvdd,
	   nmvdd,
	   CASE WHEN sxvdd = 1 THEN 'M'
			WHEN sxvdd = 0 THEN 'F'
	   ELSE 'Erro' END AS sxvdd,
	   perccomissao,
	   matfunc
	INTO stage_area..tbvdd
	FROM erp..tbvdd;

-------------------------------
-- DEPENDENTES
DROP TABLE IF EXISTS stage_area..tbdep
SELECT *
	INTO stage_area..tbdep
	FROM erp..tbdep;

-------------------------------
-- PRODUTO
DROP TABLE IF EXISTS stage_area..tbpro
SELECT *
	INTO stage_area..tbpro
	FROM erp..tbpro;

-------------------------------
-- CLIENTE
DROP TABLE IF EXISTS stage_area..tbcli
SELECT *
	INTO stage_area..tbcli
	FROM erp..tbcli;

--------------------------------------
-- VENDAS
DROP TABLE IF EXISTS stage_area..tbven;
SELECT *					-- EXTRACT
	INTO stage_area.. tbven -- LOAD (carregando na stage area)..
	FROM erp..tbven;
---------------------------
-- DATA WAREHOUSE --
---------------------------
-- CRIAR UM BANCO DE DADOS CHAMADO: ARMAZEMDEDADOS
CREATE DATABASE armazemdedados;
USE armazemdedados;
---------------------------------------------------

-- ***************
-- ** Dimensões **
-- ***************
---------------------------------------------------
-- Dimensão Vendedor
DROP TABLE IF EXISTS armazemdedados..dim_vendedor;
SELECT cdvdd AS CodigoVendedor,
	   nmvdd AS NomeVendedor,
	   sxvdd AS SexoVendedor,
	   perccomissao AS PercentualComissao,
	   matfunc AS MatriculaFuncionario
	   INTO armazemdedados..dim_vendedor
	   FROM stage_area..tbvdd;

---------------------------------------------------
-- Dimensão Dependente
DROP TABLE IF EXISTS armazemdedados..dim_dependente;
SELECT cddep AS CodigoDependente,
	   nmdep AS NomeDependente,
	   dtnasc AS DataNascimentoDependente,
	   sxdep AS SexoDependente,
	   matfunc AS MatriculaFuncionario,
	   inepescola AS CodigoINEP
	   INTO armazemdedados..dim_dependente
	   FROM stage_area..tbdep;

	
---------------------------------------------------
-- Dimensão Produto
DROP TABLE IF EXISTS armazemdedados..dim_produto;
	SELECT cdpro AS CodigoProduto,
		   nmpro AS NomeProduto,
		   tppro AS TipoProduto,
		   undpro AS UnidadeProduto,
		   slpro AS SaldoProduto,
		   stpro AS StatusProduto
	INTO armazemdedados..dim_produto
	FROM stage_area..tbpro;

---------------------------------------------------
-- Dimensão Data
DROP TABLE IF EXISTS armazemdedados..dim_data;
SELECT DISTINCT
		dtVen			AS Data,
		day(dtven)		AS Dia,
		month(dtven)	AS Mes,
		year(dtven)		AS Ano,
		DATEPART(qq, dtven) AS Trimestre
	INTO armazemdedados..dim_data
	FROM stage_area..tbven;

--------------------------------------------------
-- Dimensão Canais
DROP TABLE IF EXISTS armazemdedados..dim_canal;
SELECT DISTINCT
	   CASE WHEN canal = 'Loja Própria' THEN 1
		    WHEN canal = 'Loja Virtual' THEN 2
	   ELSE 'Outros' END AS CodigoCanalVendas,
	   canal			 AS CanalVendas
  INTO armazemdedados..dim_canal
  FROM stage_area..tbven;

-------------------------------------------------
-- Dimensão Cliente
DROP TABLE IF EXISTS armazemdedados..dim_cliente;
SELECT DISTINCT
		cdcli AS CodigoCliente,
		nmcli AS NomeCliente,
		agecli AS IdadeCliente,
		clacli AS ClassificacaoCliente,
		sxcli AS SexoCliente,
		cidcli AS CidadeCliente,
		estcli AS EstadoCliente,
		paicli AS PaisCliente
	INTO armazemdedados..dim_cliente
	FROM stage_area..tbcli;

-------------------------------------------------
-- Dimensão Status

-- Status da Venda (1-OK, 2-EXCLUIDO, 3-CANCELADO)
SELECT DISTINCT
		stven AS CodigoStatus,
		CASE WHEN stven = 1 THEN 'OK'
			 WHEN stven = 2 THEN 'EXCLUIDO'
			 WHEN stven = 3 THEN 'CANCELADO'
		END DescricaoStatus
	FROM stage_area..tbven;

---------------------------------------------------
-- ***********
-- ** Fatos **
-- ***********

--------------------------------------------------- 
-- Fato Vendas

DROP TABLE IF EXISTS armazemdedados..fato_vendas;
SELECT cdven	AS CodigoVenda,
	   dtven	AS DataVenda,
	   cdcli	AS CodigoCliente,
	   cdpro	AS CodigoProduto,
	   qtven	AS QuantidadeVenda,
	   vruven	AS ValorUnitarioVenda,
	   vrtven	AS ValorTotalVenda,
	   cdvdd	AS CodigoVendedor,
	   CASE WHEN canal = 'Loja Própria' THEN 1
			WHEN canal = 'Loja Virtual' THEN 2
	   END		AS CodigoCanalVendas,
	   stven    AS CodigoStatus,
	   deleted  AS Deletado
	   INTO armazemdedados..fato_vendas
FROM erp..tbven;
	   
 




