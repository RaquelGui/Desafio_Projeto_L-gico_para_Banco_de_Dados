-- inserção de dados e queries

use ecommerce;
show tables;
-- desc clients;
-- IdClient, Fname, Minit, Lname, CPF, Adress

insert into clients (Fname, Minit, Lname, CPF, adress) 
	values ('Maria', 'M', 'Silva', 123456789, 'rua silva prata 29, Carangola - Cidade das Flores'),
			('Marheus', 'O', 'Pimentel', 987654321, 'rua alameda 189, Centro - Cidade das Flores'),
            ('Ricardo', 'F', 'Silva', 45678913, 'avenida alameda vinha 1009, Centro - Cidade das Flores'),
            ('Julia', 'S', 'França', 789123456, 'rua laranjeiras 861, Centro - Cidade das Flores'),
            ('Roberta', 'G', 'Assis', 98745631, 'avenida koeller 19, Centro - Cidade das Flores'),
            ('Isabela', 'M', 'Cruz', 654789123, 'rua alameda das flores 18, Centro - Cidade das Flores');
   
-- desc product;
-- IdProduct, Pname, classification_kids bool, category ('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis'), avaliação, size

insert into product(Pname, classification_kids, category, avaliação, size)		
		values ('Fone de ouvido', false, 'Eletrônico', '4', null),
				('Barbie Elsa', true, 'Brinquedos', '3', null),
				('Body Carters', true, 'Vestimenta', '5', null),
				('Microfone Vedo - YouTuber', False, 'Eletrônico', '4', null),
				('Sofá retrátil', false, 'Móveis', '3', '3x57x80'),
				('Farinha de arroz', false, 'Alimentos', '2', null),
				('Fire Stick Amazon', false, 'Eletrônico', '3', null);

select * from clients;
select * from product;

-- desc orders;
-- 'idOrder', 'idOrderClient', 'orderStatus','orderDescription','sendValue','paymentCash'
-- delete from orders where idOrderClient in (1,2,3,4);

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
		values (1, default, 'compra via aplicativo', null, 1),
				(2, default, 'compra via aplicativo', 50, 0),
                (3, 'Confirmado', null, null, 1),
                (4, default, 'compra via web site', 150, 0);

	       
select * from orders;
-- desc productOrder;
-- idPOproduct, idPOorder, poQuantity, poStatus)

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
		(1,1,2,null),
        (2,1,1,null),
        (3,2,1, null);
        
desc productsStorage;
-- storageLocation, quantity
insert into productsStorage (storageLocation, quantity) values
		('Rio de Janeiro', 1000),
        ('Rio de Janeiro', 500),
        ('São Paulo', 10),
        ('São Paulo', 100),
        ('São Paulo', 10),
        ('Brasília',60);
        
-- desc storageLocation;
-- idLproduct , idLstorage, location

insert into storageLocation (idLproduct, idLstorage, location) values
			(1, 2, 'RJ'),
            (2, 6, 'GO');

-- desc supplier;
-- idSupplier , SocialName , CNPJ , contact

insert into supplier (SocialName, CNPJ, contact) values
			('Almeida e filhos', 12345678912345, '21985747234'),
			('Eletrônicos Silva', 85389027000123, '2198653728'),
            ('Eletrônicos Valma', 93890321777738, '2498209832');
            
select * from supplier;

-- desc productSupplier;
-- idPsSupplier , idPsproduct , quantity

insert into productSupplier (idPsSupplier, idPsproduct, quantity) values
			(1,1,500),
			(1,2,400),
            (2,4,633),
            (3,3,5),
            (2,5,10);

-- desc seller;
-- idSeller , SocialName , AbstractName , CNPJ, CPF, Location, contact

insert into seller (SocialName, AbstractName, CNPJ, CPF, Location, contact) values
			('Tech Eletronics', null, 12345678901222, null, 'Rio de Janeiro', 2199832781),
            ('Botique Durgas', null, null, 123456789, 'Rio de Janeiro', 2198761234),
            ('Kids World', null, 456789012345, null, 'São Paulo', 1198762901);
            
select * from seller;

desc productSeller;
-- idPseller, idProduct, prodQuantity

insert into productSeller (idPseller, idProduct, prodQuantity) values
			(1,6,80),
            (2,7,10);
			
select * from productSeller;
select count(*) from clients;

select * from clients c, orders o where c.idClient = idOrderClient;
select Fname, Lname, idOrder, orderStatus from clients c, orders o where c.idClient = idOrderClient;
select concat(Fname, ' ', Lname) as Client, idOrder as Request, orderStatus as Order_Status from clients c, orders o where c.idClient = idOrderClient;

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
		values (2, default, 'compra via aplicativo', null, 1);
        
select * from clients c, orders o 
		where c.idClient = idOrderClient
		group by idOrder;
				
select * from clients LEFT OUTER JOIN orders ON idClient = idOrderClient;

select c.idClient, Fname, count(*) as Number_of_orders from clients c 
					inner join orders o ON c.idClient = o.idOrderClient
					inner join productOrder p ON p.idPOOrder = o.idOrder
				group by idClient;
                
