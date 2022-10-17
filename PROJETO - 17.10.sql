DROP DATABASE IF EXISTS projeto_bd;
CREATE DATABASE projeto_bd;
USE projeto_bd;

CREATE TABLE estado(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
,nome VARCHAR(255) NOT NULL UNIQUE 
,sigla CHAR(2) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'  
,CONSTRAINT estado_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

INSERT INTO estado (id,nome,sigla,ativo) VALUES(NULL,'PARANÁ','PR','S');
INSERT INTO estado (id,nome,sigla,ativo) VALUES(NULL,'SÃO PAULO','SP','S');
INSERT INTO estado (id,nome,sigla,ativo) VALUES(NULL,'ESPIRITO SANTO','ES','S');

CREATE TABLE cidade(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT 
,nome VARCHAR(255) NOT NULL
,estado_id INT NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,CHECK (ativo IN('S','N'))
,FOREIGN KEY (estado_id) REFERENCES estado (id)
,CONSTRAINT estado_id FOREIGN KEY (estado_id) REFERENCES estado (id)
);


INSERT INTO cidade (nome,estado_id)
VALUES ('PARANAVAÍ', '1');
INSERT INTO cidade (nome,estado_id)
VALUES ('SUMARÉ', '2');
INSERT INTO cidade (nome,estado_id)
VALUES ('VITÓRIA', '3');

CREATE TABLE filial(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
,nome VARCHAR(255) NOT NULL UNIQUE
,cnpj VARCHAR(18) NOT NULL UNIQUE
,centro_de_custos VARCHAR(255) NOT NULL 
,cidade_id INT NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,CONSTRAINT cidade_id FOREIGN KEY (cidade_id) REFERENCES cidade (id)
,CONSTRAINT filial_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

INSERT INTO filial (nome, cnpj, centro_de_custos, cidade_id, ativo) VALUES('PARANAVAÍ', '11.111.111/0001-00' ,'PARANAVAÍ', 1 , 'S');
INSERT INTO filial (nome, cnpj, centro_de_custos, cidade_id, ativo) VALUES('SUMARÉ', '22.222.222/0002-00', 'SUMARÉ', 2 ,  'S');
INSERT INTO filial (nome, cnpj, centro_de_custos, cidade_id, ativo) VALUES('VITÓRIA', '33.333.333/0003-00', 'VITÓRIA', 3, 'S');

CREATE TABLE pedido(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
,descricao VARCHAR(255) NOT NULL UNIQUE
,filial_id INT NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,CONSTRAINT filial_id FOREIGN KEY (filial_id) REFERENCES filial (id)
,CONSTRAINT pedido_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

INSERT INTO pedido (descricao, filial_id, ativo) VALUES('IMOBILIZADO', 1 , 'S');
INSERT INTO pedido (descricao, filial_id, ativo) VALUES('AUTOMACAO', ' 2' ,  'S');
INSERT INTO pedido (descricao, filial_id, ativo) VALUES('TECNOLOGIA', 3, 'S');

CREATE TABLE item_pedido(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
,quantidade VARCHAR(255) NOT NULL UNIQUE
,pedido_id INT NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,CONSTRAINT pedido_id FOREIGN KEY (pedido_id) REFERENCES pedido (id)
,CONSTRAINT item_pedido_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

INSERT INTO item_pedido (quantidade, pedido_id, ativo) VALUES('DISPENSOR_AUTOMATICO', 1 , 'S');
INSERT INTO item_pedido (quantidade, pedido_id, ativo) VALUES('LEITORES', ' 2' ,  'S');
INSERT INTO item_pedido (quantidade, pedido_id, ativo) VALUES('INTERNET', 3, 'S');

CREATE TABLE categoria(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
,descricao VARCHAR(255) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,CONSTRAINT categoria_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

INSERT INTO categoria (descricao, ativo) VALUES('IMOBILIZADO EM CURSO', 'S');
INSERT INTO categoria (descricao, ativo) VALUES('AUTOMACAO EM CURSO', 'S');
INSERT INTO categoria (descricao, ativo) VALUES('TI EM CURSO', 'S');

CREATE TABLE categoria_produto(
produto_id INT NOT NULL
,categoria_id INT NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,CONSTRAINT categoria_produto_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

INSERT INTO categoria_produto (produto_id, categoria_id, ativo) VALUES(1, 1 , 'S');
INSERT INTO categoria_produto (produto_id, categoria_id, ativo) VALUES(2, 2 ,'S');
INSERT INTO categoria_produto (produto_id, categoria_id, ativo) VALUES(3, 3, 'S');

CREATE TABLE tipo(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
,descricao VARCHAR(255) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,CONSTRAINT descricao_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

INSERT INTO tipo (descricao, ativo) VALUES('ATIVO', 'S');
INSERT INTO tipo (descricao, ativo) VALUES('LEITORES', 'S');
INSERT INTO tipo (descricao, ativo) VALUES('TI ', 'S');

CREATE TABLE tipo_produto(
produto_id INT NOT NULL
,tipo_id INT NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
);

INSERT INTO tipo_produto (produto_id, tipo_id, ativo) VALUES(1, 1 , 'S');
INSERT INTO tipo_produto (produto_id, tipo_id, ativo) VALUES(2, 2 ,'S');
INSERT INTO tipo_produto (produto_id, tipo_id, ativo) VALUES(3, 3, 'S');


CREATE TABLE produto(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
,nome VARCHAR(255) NOT NULL UNIQUE
,preco DECIMAL(8,2) NOT NULL
,item_pedido_id INT NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,CONSTRAINT item_pedido_id FOREIGN KEY (item_pedido_id) REFERENCES item_pedido (id)
,CONSTRAINT produto_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

INSERT INTO produto (nome, preco, item_pedido_id, ativo) VALUES('ATM', 199000.00 , 1, 'S');
INSERT INTO produto (nome, preco, item_pedido_id, ativo) VALUES('DIGITALIZADORA', 700.00 , 2, 'S');
INSERT INTO produto (nome, preco, item_pedido_id, ativo) VALUES('ROTEADOR', 300.00 , 1, 'S');

CREATE TABLE fornecedor(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
,nome VARCHAR(255) NOT NULL UNIQUE
,cnpj VARCHAR(18) NOT NULL UNIQUE
,endereco VARCHAR(255) NOT NULL  
,ativo CHAR(1) NOT NULL DEFAULT 'S'

);

INSERT INTO fornecedor (id,nome, cnpj, endereco, ativo) VALUES(NULL,'PERTO S.A', '11.111.111/0004-00' ,'RUA INGLATERRA', 'S');
INSERT INTO fornecedor (id,nome, cnpj, endereco, ativo) VALUES(NULL,'GERTEC S.A', '22.222.222/0005-00', 'AVENIDA SAO JOAO', 'S');
INSERT INTO fornecedor (id,nome, cnpj, endereco, ativo) VALUES(NULL,'PROTEGE S.A', '33.333.333/0006-00', 'RUA DO VENTRE LIVRE', 'S');

CREATE TABLE orcamento(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
,prazo_entrega VARCHAR(255) NOT NULL
,aprovacao CHAR(1) NOT NULL DEFAULT 'S'
,valor_orcado DECIMAL (8,2) NOT NULL  
,item_pedido_id INT NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,CONSTRAINT orcamento_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

INSERT INTO orcamento (id, prazo_entrega, aprovacao, valor_orcado, item_pedido_id, ativo) VALUES(NULL,'100 DIAS', 'S' ,'112000.00', 1 , 'S');
INSERT INTO orcamento (id, prazo_entrega, aprovacao, valor_orcado, item_pedido_id, ativo) VALUES(NULL,'20 DIAS', 'S', '790.00', 2, 'S');
INSERT INTO orcamento (id, prazo_entrega, aprovacao, valor_orcado, item_pedido_id, ativo) VALUES(NULL,'10 DIAS', 'S', '3000.00', 3, 'S');

CREATE TABLE compra(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
,valor_compra DECIMAL(8,2) NOT NULL
,quantidade_comprada VARCHAR(255) NOT NULL DEFAULT 'S'
,orcamento_id INT NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,CONSTRAINT orcamento_id FOREIGN KEY (orcamento_id) REFERENCES orcamento (id)
,CONSTRAINT compra_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

INSERT INTO compra (valor_compra, quantidade_comprada, orcamento_id, ativo) VALUES(111000.00, 1 , 1, 'S');
INSERT INTO compra (valor_compra, quantidade_comprada, orcamento_id, ativo) VALUES(790.00, 1 , 2, 'S');
INSERT INTO compra (valor_compra, quantidade_comprada, orcamento_id, ativo) VALUES(3000.00, 10 , 3, 'S');


SELECT * FROM estado;
SELECT * FROM cidade;
SELECT * FROM produto;
SELECT * FROM filial;
SELECT * FROM fornecedor;
SELECT * FROM orcamento;
SELECT * FROM pedido;
SELECT * FROM item_pedido;
SELECT * FROM compra;
SELECT * FROM categoria;
SELECT * FROM tipo;
SELECT * FROM categoria_produto;
SELECT * FROM tipo_produto;

/** 11. De acordo com o projeto do SEU COLEGA, elabore uma consulta RELEVANTE que ajude de alguma forma a empresa. 
A consulta deve envolver mais de 4 tabelas.**/

-- Informar a cidade da filial que informou o pedido de um Imobilizado
SELECT cidade.nome
FROM cidade, estado, filial, pedido
WHERE pedido.filial_id = filial.id
AND cidade.estado_id = estado.id
AND cidade.id = filial.cidade_id;


