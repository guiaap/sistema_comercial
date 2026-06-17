CREATE DATABASE sistema_comercial
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE cliente (
    id BIGINT GENERATED ALWAYS AS IDENTITY,

    nome VARCHAR(200) NOT NULL,
    cpf CHAR(11) NOT NULL,
    email VARCHAR(200) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    endereco TEXT NOT NULL,

    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_cliente PRIMARY KEY (id),
    CONSTRAINT uk_cliente_cpf UNIQUE (cpf),
    CONSTRAINT uk_cliente_email UNIQUE (email)
);

CREATE TABLE categoria_produto (
	id BIGINT GENERATED ALWAYS AS IDENTITY,

	nome VARCHAR(200) NOT NULL,
	descricao TEXT,

	criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_categoria_produto PRIMARY KEY (id)
);

CREATE TABLE produto (
	id BIGINT GENERATED ALWAYS AS IDENTITY,

	nome VARCHAR(200) NOT NULL,
	descricao TEXT,
	preco NUMERIC(10,2) NOT NULL CHECK (preco >= 0),
	quantidade_estoque INTEGER NOT NULL CHECK (quantidade_estoque >= 0),
	id_categoria INTEGER NOT NULL,
	
	criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_produto PRIMARY KEY (id),
	
	CONSTRAINT fk_categoria_produto 
		FOREIGN KEY (id_categoria)
		REFERENCES categoria_produto(id)
);

CREATE TABLE perfil (
	id BIGINT GENERATED ALWAYS AS IDENTITY,

	nome VARCHAR(200) NOT NULL,
	descricao TEXT,

	criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_perfil PRIMARY KEY (id)
);

CREATE TABLE usuario (
	id BIGINT GENERATED ALWAYS AS IDENTITY,

	nome VARCHAR(200) NOT NULL,
	email VARCHAR(200) NOT NULL,
	senha VARCHAR(200) NOT NULL,
	id_perfil INTEGER NOT NULL,

	criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_usuario PRIMARY KEY (id),	
	CONSTRAINT uk_usuario_email UNIQUE (email),

	CONSTRAINT fk_usuario_perfil
		FOREIGN KEY (id_perfil)
		REFERENCES perfil(id)
);

CREATE INDEX idx_produto_id_categoria
ON produto(id_categoria);

CREATE INDEX idx_usuario_id_perfil
ON usuario(id_perfil);

CREATE INDEX idx_cliente_nome
ON cliente(nome);

CREATE INDEX idx_produto_nome
ON produto(nome);
