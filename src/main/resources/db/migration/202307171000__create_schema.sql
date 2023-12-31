
CREATE SEQUENCE IF NOT EXISTS seq_id INCREMENT BY 1 NO MAXVALUE START WITH 1000000 CACHE 10 NO CYCLE;

CREATE TABLE CURRENCY
(
    code varchar(3) NULL,
    name varchar(160) NULL,
    ID bigint NOT NULL DEFAULT nextval('seq_id')
);

CREATE TABLE ACCOUNT
(
    name varchar(160) NULL,
    number varchar(34) NULL,
    cur varchar(3) NULL,
    ID bigint NOT NULL DEFAULT nextval('seq_id')
);

CREATE TABLE PAYMENT_DOCUMENT
(
    account_id bigint NULL,
    amount numeric(17,2) NULL,
    expense boolean NULL,
    cur varchar(3) NULL,
    order_date date NULL,
    order_number varchar(20) NULL,
    payment_purpose varchar(1000) NULL,
    prop_10 varchar(10) NULL,
    prop_15 varchar(15) NULL,
    prop_20 varchar(20) NULL,
    ID bigint NOT NULL DEFAULT nextval('seq_id')
);

ALTER TABLE CURRENCY ADD CONSTRAINT PK_CURRENCY PRIMARY KEY (ID);
ALTER TABLE CURRENCY ADD CONSTRAINT UC_CURRENCY_code UNIQUE (code);
ALTER TABLE ACCOUNT ADD CONSTRAINT PK_ACCOUNT PRIMARY KEY (ID);
ALTER TABLE ACCOUNT ADD CONSTRAINT FK_ACCOUNT_cur FOREIGN KEY (cur) REFERENCES CURRENCY (code) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE PAYMENT_DOCUMENT ADD CONSTRAINT PK_PAYMENT_DOCUMENT PRIMARY KEY (ID);
ALTER TABLE PAYMENT_DOCUMENT ADD CONSTRAINT FK_PAYMENT_DOCUMENT_account_id FOREIGN KEY (account_id) REFERENCES ACCOUNT (ID) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE PAYMENT_DOCUMENT ADD CONSTRAINT FK_PAYMENT_DOCUMENT_cur FOREIGN KEY (cur) REFERENCES CURRENCY (code) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX IX_PAYMENT_DOCUMENT_cur on PAYMENT_DOCUMENT (cur);
CREATE INDEX IX_PAYMENT_DOCUMENT_order_date on PAYMENT_DOCUMENT (order_date);
CREATE INDEX IX_PAYMENT_DOCUMENT_order_number on PAYMENT_DOCUMENT (order_number);
