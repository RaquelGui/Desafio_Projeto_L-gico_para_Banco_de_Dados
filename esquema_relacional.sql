-- criação do banco de dados para o cenário do E-commerce

-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- criar tabela cliente

create table clients(
	idClient int auto_increment primary key,
    Fname VARCHAR (30),
    Minit CHAR(3),
    Lname VARCHAR (20),
    CPF CHAR(11) NOT NULL,
    constraint unique_cpf_client unique (CPF),
    adress VARCHAR(60)
);

alter table clients auto_increment=1;

-- desc clients;

-- criar tabela produto

create table product(
	idProduct int auto_increment primary key,
    Pname VARCHAR (30) not null,
    classification_kids bool default false,
    category ENUM ('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
    Avaliação float default 0,
    size VARCHAR (10)
);

-- criat tabela payments
-- para ser continuado no desafio: terminar de implementar a tabela e criar a conexão com as tabelas necessárias,
-- além disso, reflita essa modificação do diagrama de esquema relacional
-- criar constraints relacionadas ao pagamento

-- create table payments(
	-- idClient int primary key,
   -- id_payment int,
    -- typePayment enum ('Boleto','Cartão', 'Dois Cartões'),
   -- limitAvaiable float, 
   -- dateValid check not null,
   -- primary key (idClient, id_payment)
-- );


-- criat tabela pedido

create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado','Confirmado','Em Processamento') not null default ('Em processamento'),
    orderDescription VARCHAR (255),
    sendValue float default 10,
    paymentCash bool default false,
	constraint fk_order_client foreign key (idOrderClient) references clients(idClient) 
		on update cascade
);
-- desc orders;
-- criar tabela estoque

create table productsStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar (255),
    quantity int default 0
);

-- criar tabela fornecedor

create table supplier(
	idSupplier  int auto_increment primary key,
    SocialName varchar (255) not null,
    CNPJ char (15) not null,
    contact char (11) not null, 
    constraint unique_supplier unique (CNPJ)
);

-- desc supplier;

-- criar tabela vendedor

create table seller(
	idSeller  int auto_increment primary key,
    SocialName varchar (255) not null,
    AbstractName varchar (255),
    CNPJ char (15),
    CPF char (9),
    Location varchar(255),
	contact char (11) not null, 
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

create table productSeller(
	idPseller int,
    idProduct int,
    prodQuantity int default 1,
    primary key (idPSeller, idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller (idSeller),
    constraint fk_product_product foreign key (idProduct) references product (idProduct)
);

-- desc productSeller;

create table productOrder(
	idPOproduct int,
    idPOorder int, 
    poQuantity int default 1, 
    poStatus enum ('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
	constraint fk_productorder_seller foreign key (idPOproduct) references product (idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
	idLproduct int, 
	idLstorage int, 
	location varchar (255) not null,
	primary key (idLproduct, idLstorage),
	constraint fk_storageLocation_product foreign key (idLproduct) references product (idProduct),
	constraint fk_storageLocation_storage foreign key (idLstorage) references productsStorage (idProdStorage)
);

create table productSupplier(
	idPsSupplier int, 
	idPsproduct int, 
	quantity int not null,
	primary key (idPsSupplier, idPsproduct),
	constraint fk_productSupplier_supplier foreign key (idPsSupplier) references supplier (idSupplier),
	constraint fk_productSupplier_product foreign key (idPsproduct) references product (idProduct)
);

-- show tables;
-- show databases;
-- use information_schema;
-- show tables;
-- desc table_constraints;
-- desc referential_constraints;
-- select * from referential_constraints where constraint_schema = 'ecommerce';