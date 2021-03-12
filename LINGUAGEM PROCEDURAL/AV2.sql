create table departamentos(
 id int primary key,
 nome varchar(100)
);
 go
create procedure inserir_departamento (@ID int, @nome varchar(100))
as
begin
	insert into departamentos
		(id, nome) values
		(@ID, @nome)
end	

exec inserir_departamento 1, 'wesley'

select * from departamentos


CREATE TABLE clientes(
 id DECIMAL,
 nome VARCHAR(100),
 consumo DECIMAL(6,2),
 status CHAR(1)
)


insert into clientes (id,nome,consumo,status) values (1,'a',99,'x')
insert into clientes (id,nome,consumo,status) values (2,'b',149,'x')
insert into clientes (id,nome,consumo,status) values (4,'c',200,'x')

select * from clientes

delete from clientes

 go
create procedure atualizar_o_status 
as
begin
	declare @cliente_id DECIMAL
	declare @cliente_consumo DECIMAL
	
	
	DEClARE cursor_cliente_id CURSOR FOR 
	select id,consumo from clientes
	
	open cursor_cliente_id
	FETCH cursor_cliente_id INTO @cliente_id,@cliente_consumo

	WHILE @@FETCH_STATUS = 0
		BEGIN
			begin
			if @cliente_consumo < 100 
				update  clientes set status = 'C' WHERE id =  @cliente_id 	
			end
			begin
			if @cliente_consumo > 100 and @cliente_consumo < 150
				update  clientes set status = 'B' WHERE id =  @cliente_id 	
			end
			begin
			if @cliente_consumo > 150
				update  clientes set status = 'A' WHERE id =  @cliente_id 	
			end
			

			FETCH cursor_cliente_id INTO @cliente_id,@cliente_consumo
		end
		
		
		CLOSE cursor_cliente_id
		DEALLOCATE cursor_cliente_id
end	

drop procedure atualizar_o_status


exec atualizar_o_status

select * from clientes


CREATE TABLE ALUNO (
MATRICULA DECIMAL,
NOME VARCHAR(20),
SOBRENOME VARCHAR(30)); 

select * from ALUNO

insert into ALUNO(MATRICULA,NOME,SOBRENOME) values(1,'wesley','menezes')


go
Create procedure nome_aluno (@MATRICULA DECIMAL, @nome_sobrenome VARCHAR(50) OUT) 
as
begin
	declare @ALUNO_NOME VARCHAR(20)
	declare @ALUNO_SOBRENOME VARCHAR(30)
	
	select  @ALUNO_NOME = NOME FROM ALUNO
	select  @ALUNO_SOBRENOME = SOBRENOME FROM ALUNO

	SET @nome_sobrenome = CONCAT(@ALUNO_NOME,@ALUNO_SOBRENOME)
	

end



declare @nome_sobrenome_out VARCHAR(50)

EXEC nome_aluno 1,  @nome_sobrenome_out out

select @nome_sobrenome_out