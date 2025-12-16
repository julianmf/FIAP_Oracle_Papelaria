/*
DROP TABLE t_pap_cliente CASCADE CONSTRAINTS;
DROP TABLE t_pap_contato_pessoa CASCADE CONSTRAINTS;
DROP TABLE t_pap_cor CASCADE CONSTRAINTS;
DROP TABLE t_pap_endereco_pessoa CASCADE CONSTRAINTS;
DROP TABLE t_pap_especie_prod CASCADE CONSTRAINTS;
DROP TABLE t_pap_estoque CASCADE CONSTRAINTS;
DROP TABLE t_pap_fornecedor CASCADE CONSTRAINTS;
DROP TABLE t_pap_funcionario CASCADE CONSTRAINTS;
DROP TABLE t_pap_grupo_prod CASCADE CONSTRAINTS;
DROP TABLE t_pap_loja CASCADE CONSTRAINTS;
DROP TABLE t_pap_marca CASCADE CONSTRAINTS;
DROP TABLE t_pap_nf_ent_item CASCADE CONSTRAINTS;
DROP TABLE t_pap_nf_entrada CASCADE CONSTRAINTS;
DROP TABLE t_pap_nf_item CASCADE CONSTRAINTS;
DROP TABLE t_pap_nf_venda CASCADE CONSTRAINTS;
DROP TABLE t_pap_ordem_compra CASCADE CONSTRAINTS;
DROP TABLE t_pap_pedido CASCADE CONSTRAINTS;
DROP TABLE t_pap_pedido_item CASCADE CONSTRAINTS;
DROP TABLE t_pap_pessoa CASCADE CONSTRAINTS;
DROP TABLE t_pap_pf CASCADE CONSTRAINTS;
DROP TABLE t_pap_pj CASCADE CONSTRAINTS;
DROP TABLE t_pap_produto CASCADE CONSTRAINTS;
DROP TABLE t_pap_setor CASCADE CONSTRAINTS;
*/

/*****CRIACAO ESTRUTURA DAS TABELAS****/
CREATE TABLE t_pap_cliente (
    cd_cliente  NUMBER(10) NOT NULL,
    cd_pessoa   NUMBER(10) NOT NULL
);

ALTER TABLE t_pap_cliente ADD CONSTRAINT pk_cliente PRIMARY KEY ( cd_cliente );

CREATE TABLE t_pap_contato_pessoa (
    cd_contato  NUMBER(10) NOT NULL,
    cd_pessoa   NUMBER(10) NOT NULL,
    email       VARCHAR2(100),
    fone_res    VARCHAR2(14),
    fone_cel    VARCHAR2(14) NOT NULL,
    fone_com    VARCHAR2(14),
    st_contato  CHAR(1) DEFAULT '1' NOT NULL
);

ALTER TABLE t_pap_contato_pessoa
    ADD CHECK ( st_contato IN ( '0', '1' ) );

ALTER TABLE t_pap_contato_pessoa ADD CONSTRAINT pk_pap_contato_pessoa PRIMARY KEY ( cd_contato,
                                                                                    cd_pessoa );

CREATE TABLE t_pap_cor (
    cd_cor   NUMBER(3) NOT NULL,
    des_cor  VARCHAR2(45) NOT NULL,
    st_cor   CHAR(1) DEFAULT '1' NOT NULL
);

ALTER TABLE t_pap_cor
    ADD CHECK ( st_cor IN ( '0', '1' ) );

ALTER TABLE t_pap_cor ADD CONSTRAINT pk_pap_cor PRIMARY KEY ( cd_cor );

CREATE TABLE t_pap_endereco_pessoa (
    seq_lograd     NUMBER(7) NOT NULL,
    cd_pessoa      NUMBER(10) NOT NULL,
    cd_lograd      NUMBER(7) NOT NULL,
    des_lograd     VARCHAR2(120) NOT NULL,
    nr_logradouro  VARCHAR2(10) NOT NULL,
    tp_lograd      VARCHAR2(30) NOT NULL,
    cep            VARCHAR2(10) NOT NULL,
    bairro         VARCHAR2(30) NOT NULL,
    cidade         VARCHAR2(40) NOT NULL,
    uf             CHAR(2) NOT NULL,
    complemento    VARCHAR2(250),
    st_lograd      CHAR(1) DEFAULT '1'
);

ALTER TABLE t_pap_endereco_pessoa
    ADD CHECK ( st_lograd IN ( '0', '1' ) );

ALTER TABLE t_pap_endereco_pessoa ADD CONSTRAINT pk_pap_endereco_pessoa PRIMARY KEY ( seq_lograd,
                                                                                      cd_pessoa );

CREATE TABLE t_pap_especie_prod (
    cd_especie  NUMBER(6) NOT NULL,
    nm_especie  VARCHAR2(60)
);

ALTER TABLE t_pap_especie_prod ADD CONSTRAINT pk_especie_prod PRIMARY KEY ( cd_especie );

CREATE TABLE t_pap_estoque (
    cd_loja      NUMBER(4) NOT NULL,
    cd_prod      NUMBER(6) NOT NULL,
    cd_setor     NUMBER(5) NOT NULL,
    qtd          NUMBER(8) NOT NULL,
    vlr_custo    NUMBER(6, 2) NOT NULL,
    dt_fab       DATE,
    lote         VARCHAR2(20),
    localizacao  VARCHAR2(30) NOT NULL
);

ALTER TABLE t_pap_estoque
    ADD CONSTRAINT pk_pap_estoque PRIMARY KEY ( cd_prod,
                                                cd_setor,
                                                cd_loja );

CREATE TABLE t_pap_fornecedor (
    cd_fornec  NUMBER(8) NOT NULL,
    cd_pessoa  NUMBER(10) NOT NULL
);

ALTER TABLE t_pap_fornecedor ADD CONSTRAINT pk_pap_fornecedor PRIMARY KEY ( cd_fornec );

CREATE TABLE t_pap_funcionario (
    cd_func      NUMBER(8) NOT NULL,
    cd_vendedor  NUMBER(8) NOT NULL,
    cd_pessoa    NUMBER(10) NOT NULL
);

ALTER TABLE t_pap_funcionario ADD CONSTRAINT pk_pap_funcionario PRIMARY KEY ( cd_func );

CREATE TABLE t_pap_grupo_prod (
    cd_grupo    NUMBER(6) NOT NULL,
    cd_especie  NUMBER(6) NOT NULL,
    nm_grupo    VARCHAR2(30) NOT NULL
);

ALTER TABLE t_pap_grupo_prod ADD CONSTRAINT pk_grupo_prod PRIMARY KEY ( cd_grupo,
                                                                        cd_especie );

CREATE TABLE t_pap_loja (
    cd_loja      NUMBER(4) NOT NULL,
    nm_loja      VARCHAR2(100) NOT NULL,
    telefone     VARCHAR2(14) NOT NULL,
    cpnj         VARCHAR2(14) NOT NULL,
    end_loja     VARCHAR2(100),
    nr_loja      VARCHAR2(20),
    bairro_loja  VARCHAR2(30),
    cidade_loja  VARCHAR2(60),
    st_loja      CHAR(1) DEFAULT '1' NOT NULL
);

ALTER TABLE t_pap_loja
    ADD CHECK ( st_loja IN ( '0', '1' ) );

ALTER TABLE t_pap_loja ADD CONSTRAINT ck_cd_loja CHECK ( cd_loja > 0 );

ALTER TABLE t_pap_loja ADD CONSTRAINT pk_pap_loja PRIMARY KEY ( cd_loja );

ALTER TABLE t_pap_loja ADD CONSTRAINT un_pap_nome_loja UNIQUE ( nm_loja );

CREATE TABLE t_pap_marca (
    cd_marca   NUMBER(3) NOT NULL,
    des_marca  VARCHAR2(45) NOT NULL,
    st_marca   CHAR(1) DEFAULT '1' NOT NULL
);

ALTER TABLE t_pap_marca
    ADD CHECK ( st_marca IN ( '0', '1' ) );

ALTER TABLE t_pap_marca ADD CONSTRAINT pk_pap_marca PRIMARY KEY ( cd_marca );

CREATE TABLE t_pap_nf_ent_item (
    cd_nf_item  NUMBER(10) NOT NULL,
    cd_nf       NUMBER(10) NOT NULL,
    qtd         NUMBER(8) NOT NULL,
    val_unit    NUMBER(6, 2) NOT NULL,
    dt_fab      DATE,
    lote        VARCHAR2(20)
);

ALTER TABLE t_pap_nf_ent_item ADD CONSTRAINT ck_vlr_unit_entr_valid CHECK ( val_unit > 0 );

ALTER TABLE t_pap_nf_ent_item ADD CONSTRAINT ck_quant_valid CHECK ( qtd > 0 );

ALTER TABLE t_pap_nf_ent_item ADD CONSTRAINT pk_pap_nf_ent_item PRIMARY KEY ( cd_nf_item,
                                                                              cd_nf );

CREATE TABLE t_pap_nf_entrada (
    cd_nf       NUMBER(10) NOT NULL,
    cd_oc       NUMBER(10) NOT NULL,
    cd_fornec   NUMBER(8) NOT NULL,
    cd_setor    NUMBER(5) NOT NULL,
    nr_nf       NUMBER(10) NOT NULL,
    nf_serie    VARCHAR2(10) NOT NULL,
    dt_emissao  DATE NOT NULL,
    dt_receb    DATE NOT NULL,
    val_ipi     NUMBER(4, 2),
    val_icms    NUMBER(8, 2),
    val_total   NUMBER(8, 2) NOT NULL
);

ALTER TABLE t_pap_nf_entrada ADD CONSTRAINT ck_vlr_ipi_valid CHECK ( val_ipi > 0 );

ALTER TABLE t_pap_nf_entrada ADD CONSTRAINT ck_vlr_icms_valid CHECK ( val_icms > 0 );

ALTER TABLE t_pap_nf_entrada ADD CONSTRAINT ck_vlr_total_valid CHECK ( val_total > 0 );

ALTER TABLE t_pap_nf_entrada ADD CONSTRAINT pk_pap_nf_entrada PRIMARY KEY ( cd_nf );

ALTER TABLE t_pap_nf_entrada ADD CONSTRAINT un_pap_nf_entrada UNIQUE ( nr_nf );

CREATE TABLE t_pap_nf_item (
    cd_nf_item    NUMBER(10) NOT NULL,
    cd_nf         NUMBER(10) NOT NULL,
    qtd           NUMBER(8) NOT NULL,
    val_unitario  NUMBER(8, 2) NOT NULL
);

ALTER TABLE t_pap_nf_item ADD CONSTRAINT ck_nf_qt_venda_valid CHECK ( qtd > 0 );

ALTER TABLE t_pap_nf_item ADD CONSTRAINT ck_nf_vl_unit_venda_valid CHECK ( val_unitario > 0 );

ALTER TABLE t_pap_nf_item ADD CONSTRAINT pk_pap_nf_item PRIMARY KEY ( cd_nf,
                                                                      cd_nf_item );

CREATE TABLE t_pap_nf_venda (
    cd_nf         NUMBER(10) NOT NULL,
    seq_ped_item  NUMBER(10) NOT NULL,
    cd_pedido     NUMBER(10) NOT NULL,
    cd_cliente    NUMBER(10) NOT NULL,
    nr_nf_venda   NUMBER(10) NOT NULL,
    nr_serie_nf   VARCHAR2(10) NOT NULL,
    dt_emissao    DATE NOT NULL,
    val_ipi       NUMBER(4, 2) NOT NULL,
    val_icms      NUMBER(8, 2) NOT NULL,
    val_total     NUMBER(8, 2) NOT NULL
);

ALTER TABLE t_pap_nf_venda ADD CONSTRAINT ck_nfv_vlr_ipi CHECK ( val_ipi > 0 );

ALTER TABLE t_pap_nf_venda ADD CONSTRAINT ck_nfv_vlr_icms CHECK ( val_icms > 0 );

ALTER TABLE t_pap_nf_venda ADD CONSTRAINT ck_nfv_vlr_total CHECK ( val_total > 0 );

ALTER TABLE t_pap_nf_venda ADD CONSTRAINT pk_pap_nf_venda PRIMARY KEY ( cd_nf );

ALTER TABLE t_pap_nf_venda ADD CONSTRAINT un_pap_nr_nf_venda UNIQUE ( nr_nf_venda );

CREATE TABLE t_pap_ordem_compra (
    cd_oc    NUMBER(10) NOT NULL,
    cd_prod  NUMBER(6) NOT NULL,
    qtd      NUMBER(10) NOT NULL
);

ALTER TABLE t_pap_ordem_compra ADD CONSTRAINT ck_oc_qt_valid CHECK ( qtd > 0 );

ALTER TABLE t_pap_ordem_compra ADD CONSTRAINT pk_pap_ordem_compra PRIMARY KEY ( cd_oc );

CREATE TABLE t_pap_pedido (
    cd_pedido      NUMBER(10) NOT NULL,
    cd_cliente     NUMBER(10) NOT NULL,
    cd_func        NUMBER(8) NOT NULL,
    dt_pedido      DATE NOT NULL,
    val_total_ped  NUMBER(6, 2) NOT NULL
);

ALTER TABLE t_pap_pedido ADD CONSTRAINT ck_vlr_pedido_valid CHECK ( val_total_ped > 0 );

ALTER TABLE t_pap_pedido ADD CONSTRAINT pk_pap_pedido PRIMARY KEY ( cd_pedido,
                                                                    cd_cliente );

CREATE TABLE t_pap_pedido_item (
    seq_ped_item  NUMBER(10) NOT NULL,
    cd_pedido     NUMBER(10) NOT NULL,
    cd_cliente    NUMBER(10) NOT NULL,
    cd_loja       NUMBER(4) NOT NULL,
    cd_setor      NUMBER(5) NOT NULL,
    cd_prod       NUMBER(6) NOT NULL,
    qtd           NUMBER(8) NOT NULL,
    val_unit      NUMBER(8, 2) NOT NULL,
    desc_percent  NUMBER(4, 2)
);

ALTER TABLE t_pap_pedido_item ADD CONSTRAINT ck_vlr_ped_item_valid CHECK ( val_unit > 0 );

ALTER TABLE t_pap_pedido_item ADD CONSTRAINT ck_qt_ped_item_valid CHECK ( qtd > 0 );

ALTER TABLE t_pap_pedido_item
    ADD CONSTRAINT pk_pap_pedido_item PRIMARY KEY ( seq_ped_item,
                                                    cd_pedido,
                                                    cd_cliente );

CREATE TABLE t_pap_pessoa (
    cd_pessoa   NUMBER(10) NOT NULL,
    tp_pessoa   CHAR(1) NOT NULL,
    dt_criacao  DATE NOT NULL,
    nm_pessoa   VARCHAR2(100),
    st_pessoa   CHAR(1) DEFAULT '1' NOT NULL
);

ALTER TABLE t_pap_pessoa
    ADD CONSTRAINT c_tipo_pessoa CHECK ( tp_pessoa IN ( 'F', 'J' ) );

ALTER TABLE t_pap_pessoa
    ADD CHECK ( st_pessoa IN ( '0', '1' ) );

ALTER TABLE t_pap_pessoa ADD CONSTRAINT pk_pap_pessoa PRIMARY KEY ( cd_pessoa );

CREATE TABLE t_pap_pf (
    cd_pessoa  NUMBER(10) NOT NULL,
    nr_cpf     VARCHAR2(14),
    nr_rg      VARCHAR2(14),
    dt_nasc    DATE,
    sexo       CHAR(1)
);

ALTER TABLE t_pap_pf
    ADD CHECK ( sexo IN ( 'F', 'M', 'O' ) );

ALTER TABLE t_pap_pf ADD CONSTRAINT pk_pap_pf PRIMARY KEY ( cd_pessoa );

ALTER TABLE t_pap_pf ADD CONSTRAINT un_pap_pf_cpf UNIQUE ( nr_cpf );

CREATE TABLE t_pap_pj (
    cd_pessoa         NUMBER(10) NOT NULL,
    nr_cnpj           VARCHAR2(14) NOT NULL,
    nm_razao_social   VARCHAR2(100) NOT NULL,
    nm_fantasia       VARCHAR2(100),
    nr_insc_estadual  VARCHAR2(20)
);

ALTER TABLE t_pap_pj ADD CONSTRAINT pk_pap_pj PRIMARY KEY ( cd_pessoa );

ALTER TABLE t_pap_pj ADD CONSTRAINT t_pap_pj_nr_cnpj_un UNIQUE ( nr_cnpj );

CREATE TABLE t_pap_produto (
    cd_prod     NUMBER(6) NOT NULL,
    cd_especie  NUMBER(6) NOT NULL,
    cd_grupo    NUMBER(6) NOT NULL,
    cd_marca    NUMBER(3) DEFAULT 1 NOT NULL,
    cd_cor      NUMBER(3) NOT NULL,
    des_prod    VARCHAR2(45) NOT NULL,
    uni_prod    VARCHAR2(10) NOT NULL,
    st_produto  CHAR(1) DEFAULT '1'
);

ALTER TABLE t_pap_produto
    ADD CHECK ( st_produto IN ( '0', '1' ) );

ALTER TABLE t_pap_produto ADD CONSTRAINT pk_pap_produto PRIMARY KEY ( cd_prod );

CREATE TABLE t_pap_setor (
    cd_setor      NUMBER(5) NOT NULL,
    cd_loja       NUMBER(4) NOT NULL,
    nm_setor      VARCHAR2(30) NOT NULL,
    cd_cent_cust  NUMBER(3),
    st_setor      CHAR(1) DEFAULT '1'
);

ALTER TABLE t_pap_setor
    ADD CHECK ( st_setor IN ( '0', '1' ) );

ALTER TABLE t_pap_setor ADD CONSTRAINT pk_pap_setor PRIMARY KEY ( cd_setor );

ALTER TABLE t_pap_setor ADD CONSTRAINT un_pap_nome_setor UNIQUE ( nm_setor );

/****CRIACAO DE CHAVES ESTRANGEIRAS ****/
ALTER TABLE t_pap_grupo_prod
    ADD CONSTRAINT fk_especie_grupo_prod FOREIGN KEY ( cd_especie )
        REFERENCES t_pap_especie_prod ( cd_especie );

ALTER TABLE t_pap_produto
    ADD CONSTRAINT fk_grupo_espc_prod FOREIGN KEY ( cd_grupo,
                                                    cd_especie )
        REFERENCES t_pap_grupo_prod ( cd_grupo,
                                      cd_especie );

ALTER TABLE t_pap_contato_pessoa
    ADD CONSTRAINT fk_pap_contato_pessoa FOREIGN KEY ( cd_pessoa )
        REFERENCES t_pap_pessoa ( cd_pessoa );

ALTER TABLE t_pap_produto
    ADD CONSTRAINT fk_pap_cor FOREIGN KEY ( cd_cor )
        REFERENCES t_pap_cor ( cd_cor );

ALTER TABLE t_pap_endereco_pessoa
    ADD CONSTRAINT fk_pap_endereco_pessoa FOREIGN KEY ( cd_pessoa )
        REFERENCES t_pap_pessoa ( cd_pessoa );

ALTER TABLE t_pap_pedido_item
    ADD CONSTRAINT fk_pap_estoque FOREIGN KEY ( cd_prod,
                                                cd_setor,
                                                cd_loja )
        REFERENCES t_pap_estoque ( cd_prod,
                                   cd_setor,
                                   cd_loja );

ALTER TABLE t_pap_nf_entrada
    ADD CONSTRAINT fk_pap_fornecedor FOREIGN KEY ( cd_fornec )
        REFERENCES t_pap_fornecedor ( cd_fornec );

ALTER TABLE t_pap_funcionario
    ADD CONSTRAINT fk_pap_func_vendedor FOREIGN KEY ( cd_vendedor )
        REFERENCES t_pap_funcionario ( cd_func );

ALTER TABLE t_pap_pedido
    ADD CONSTRAINT fk_pap_funcionario FOREIGN KEY ( cd_func )
        REFERENCES t_pap_funcionario ( cd_func );

ALTER TABLE t_pap_estoque
    ADD CONSTRAINT fk_pap_loja_est FOREIGN KEY ( cd_loja )
        REFERENCES t_pap_loja ( cd_loja );

ALTER TABLE t_pap_setor
    ADD CONSTRAINT fk_pap_loja_setor FOREIGN KEY ( cd_loja )
        REFERENCES t_pap_loja ( cd_loja );

ALTER TABLE t_pap_produto
    ADD CONSTRAINT fk_pap_marca FOREIGN KEY ( cd_marca )
        REFERENCES t_pap_marca ( cd_marca );

ALTER TABLE t_pap_nf_ent_item
    ADD CONSTRAINT fk_pap_nf_entrada FOREIGN KEY ( cd_nf )
        REFERENCES t_pap_nf_entrada ( cd_nf );

ALTER TABLE t_pap_nf_item
    ADD CONSTRAINT fk_pap_nf_item FOREIGN KEY ( cd_nf )
        REFERENCES t_pap_nf_venda ( cd_nf );

ALTER TABLE t_pap_nf_venda
    ADD CONSTRAINT fk_pap_nf_venda FOREIGN KEY ( seq_ped_item,
                                                 cd_pedido,
                                                 cd_cliente )
        REFERENCES t_pap_pedido_item ( seq_ped_item,
                                       cd_pedido,
                                       cd_cliente );

ALTER TABLE t_pap_nf_entrada
    ADD CONSTRAINT fk_pap_ordem_compra FOREIGN KEY ( cd_oc )
        REFERENCES t_pap_ordem_compra ( cd_oc );

ALTER TABLE t_pap_pedido_item
    ADD CONSTRAINT fk_pap_pedido FOREIGN KEY ( cd_pedido,
                                               cd_cliente )
        REFERENCES t_pap_pedido ( cd_pedido,
                                  cd_cliente );

ALTER TABLE t_pap_pedido
    ADD CONSTRAINT fk_pap_pedido_t_cliente FOREIGN KEY ( cd_cliente )
        REFERENCES t_pap_cliente ( cd_cliente );

ALTER TABLE t_pap_cliente
    ADD CONSTRAINT fk_pap_pessoa_cliente FOREIGN KEY ( cd_pessoa )
        REFERENCES t_pap_pessoa ( cd_pessoa );

ALTER TABLE t_pap_funcionario
    ADD CONSTRAINT fk_pap_pessoa_func FOREIGN KEY ( cd_pessoa )
        REFERENCES t_pap_pessoa ( cd_pessoa );

ALTER TABLE t_pap_pj
    ADD CONSTRAINT fk_pap_pessoa_pj FOREIGN KEY ( cd_pessoa )
        REFERENCES t_pap_pessoa ( cd_pessoa );

ALTER TABLE t_pap_pf
    ADD CONSTRAINT fk_pap_pf FOREIGN KEY ( cd_pessoa )
        REFERENCES t_pap_pessoa ( cd_pessoa );

ALTER TABLE t_pap_fornecedor
    ADD CONSTRAINT fk_pap_pj FOREIGN KEY ( cd_pessoa )
        REFERENCES t_pap_pj ( cd_pessoa );

ALTER TABLE t_pap_estoque
    ADD CONSTRAINT fk_pap_produto_est FOREIGN KEY ( cd_prod )
        REFERENCES t_pap_produto ( cd_prod );

ALTER TABLE t_pap_ordem_compra
    ADD CONSTRAINT fk_pap_produto_oc FOREIGN KEY ( cd_prod )
        REFERENCES t_pap_produto ( cd_prod );

ALTER TABLE t_pap_nf_entrada
    ADD CONSTRAINT fk_pap_setor FOREIGN KEY ( cd_setor )
        REFERENCES t_pap_setor ( cd_setor );

ALTER TABLE t_pap_estoque
    ADD CONSTRAINT fk_pap_setor_est FOREIGN KEY ( cd_setor )
        REFERENCES t_pap_setor ( cd_setor );

/****CRIACAO DE TRIGGERS - VALIDAR TIPO DE PESSOA****/
CREATE OR REPLACE TRIGGER trg_pessoa_tipo_pj BEFORE
    INSERT OR UPDATE OF cd_pessoa ON t_pap_pj
    FOR EACH ROW
DECLARE
    d CHAR(1);
BEGIN
    SELECT
        a.tp_pessoa
    INTO d
    FROM
        t_pap_pessoa a
    WHERE
        a.cd_pessoa = :new.cd_pessoa;

    IF ( d IS NULL OR d <> 'J' ) THEN
        raise_application_error(-20223,
                               'FK FK_PAP_PESSOA_PJ in Table T_PAP_PJ violates Arc constraint on Table T_PAP_PESSOA - discriminator column tp_pessoa doesn''t have value ''J''');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER trg_pessoa_tipo_pf BEFORE
    INSERT OR UPDATE OF cd_pessoa ON t_pap_pf
    FOR EACH ROW
DECLARE
    d CHAR(1);
BEGIN
    SELECT
        a.tp_pessoa
    INTO d
    FROM
        t_pap_pessoa a
    WHERE
        a.cd_pessoa = :new.cd_pessoa;

    IF ( d IS NULL OR d <> 'F' ) THEN
        raise_application_error(-20223,
                               'FK FK_PAP_PF in Table T_PAP_PF violates Arc constraint on Table T_PAP_PESSOA - discriminator column tp_pessoa doesn''t have value ''F''');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

/****CRIACAO DE SEQUENCES****/
CREATE SEQUENCE SEQ_CLIENTE         INCREMENT BY 1 START WITH 1 MAXVALUE 9999999999;	
CREATE SEQUENCE SEQ_CONTATO_PESSOA  INCREMENT BY 1 START WITH 1 MAXVALUE 9999999999;	
CREATE SEQUENCE SEQ_COR             INCREMENT BY 1 START WITH 1 MAXVALUE 999;	
CREATE SEQUENCE SEQ_ENDERECO_PESSOA INCREMENT BY 1 START WITH 1 MAXVALUE 9999999;	
CREATE SEQUENCE SEQ_ESPECIE_PROD    INCREMENT BY 1 START WITH 1 MAXVALUE 999999;	
CREATE SEQUENCE SEQ_ESTOQUE         INCREMENT BY 1 START WITH 1 MAXVALUE 9999;	
CREATE SEQUENCE SEQ_FORNECEDOR      INCREMENT BY 1 START WITH 1 MAXVALUE 99999999;
CREATE SEQUENCE SEQ_FUNCIONARIO     INCREMENT BY 1 START WITH 1 MAXVALUE 99999999;	
CREATE SEQUENCE SEQ_GRUPO_PROD      INCREMENT BY 1 START WITH 1 MAXVALUE 999999;	
CREATE SEQUENCE SEQ_LOJA            INCREMENT BY 1 START WITH 1 MAXVALUE 9999;	
CREATE SEQUENCE SEQ_MARCA           INCREMENT BY 1 START WITH 1 MAXVALUE 999;	
CREATE SEQUENCE SEQ_NF_ENTRADA      INCREMENT BY 1 START WITH 1 MAXVALUE 9999999999;
CREATE SEQUENCE SEQ_NF_ENTRADA_ITEM INCREMENT BY 1 START WITH 1 MAXVALUE 9999999999;	
CREATE SEQUENCE SEQ_NF_VENDA_ITEM   INCREMENT BY 1 START WITH 1 MAXVALUE 9999999999;	
CREATE SEQUENCE SEQ_NF_VENDA        INCREMENT BY 1 START WITH 1 MAXVALUE 9999999999;	
CREATE SEQUENCE SEQ_ORDEM_COMPRA    INCREMENT BY 1 START WITH 1 MAXVALUE 9999999999;	
CREATE SEQUENCE SEQ_PEDIDO          INCREMENT BY 1 START WITH 1 MAXVALUE 9999999999;	
CREATE SEQUENCE SEQ_PEDIDO_ITEM     INCREMENT BY 1 START WITH 1 MAXVALUE 9999999999;	
CREATE SEQUENCE SEQ_PESSOA          INCREMENT BY 1 START WITH 1 MAXVALUE 9999999999;	
CREATE SEQUENCE SEQ_PF              INCREMENT BY 1 START WITH 1 MAXVALUE 9999999999;	
CREATE SEQUENCE SEQ_PJ              INCREMENT BY 1 START WITH 1 MAXVALUE 9999999999;	
CREATE SEQUENCE SEQ_PRODUTO         INCREMENT BY 1 START WITH 1 MAXVALUE 999999;	
CREATE SEQUENCE SEQ_SETOR           INCREMENT BY 1 START WITH 1 MAXVALUE 99999;	


/*
DROP SEQUENCE SEQ_CLIENTE;         
DROP SEQUENCE SEQ_CONTATO_PESSOA;  
DROP SEQUENCE SEQ_COR;             
DROP SEQUENCE SEQ_ENDERECO_PESSOA; 
DROP SEQUENCE SEQ_ESPECIE_PROD;    
DROP SEQUENCE SEQ_ESTOQUE;         
DROP SEQUENCE SEQ_FORNECEDOR;      
DROP SEQUENCE SEQ_FUNCIONARIO;     
DROP SEQUENCE SEQ_GRUPO_PROD;      
DROP SEQUENCE SEQ_LOJA;            
DROP SEQUENCE SEQ_MARCA;           
DROP SEQUENCE SEQ_NF_ENTRADA;      
DROP SEQUENCE SEQ_NF_ENTRADA_ITEM; 
DROP SEQUENCE SEQ_NF_VENDA_ITEM;   
DROP SEQUENCE SEQ_NF_VENDA;        
DROP SEQUENCE SEQ_ORDEM_COMPRA;    
DROP SEQUENCE SEQ_PEDIDO;          
DROP SEQUENCE SEQ_PEDIDO_ITEM;     
DROP SEQUENCE SEQ_PESSOA;          
DROP SEQUENCE SEQ_PF;              
DROP SEQUENCE SEQ_PJ;              
DROP SEQUENCE SEQ_PRODUTO;         
DROP SEQUENCE SEQ_SETOR;    
*/