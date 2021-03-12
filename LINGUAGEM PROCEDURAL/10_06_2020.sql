create function Dobro(@numero int)
returns int
begin
  return(@numero * 2)
end
go

 

select dbo.Dobro(14)
go

 

create function Dobro_v2(@numero int)
returns int
begin
  declare @calculo int
  set @calculo = @numero * 2

 

  return(@calculo)
end
go

 

select dbo.Dobro_v2(23)

go
create function trim(@texto varchar(100))
returns varchar (100)
begin
  return ltrim(rtrim(@texto))
end
go


drop function trim

select dbo.trim('  teste  ')

select * from cliente
go

 

create function ClientesAtivos()
returns Table
as
return
(
select * from cliente where StatusAtivo = 'S'
)
go

 

select * from dbo.ClientesAtivos()
go

 


create function ClientesConformeStatus(@Status char(01))
returns Table
as
return
(
select * from cliente where StatusAtivo = @Status
)
go

 

select * from dbo.ClientesConformeStatus('S')

 

select * from dbo.ClientesConformeStatus('N')

-- CRIAR UMA FUNCTION QUE RETORNE O SOMATÓRIO DE OPERAÇÕES DE DEPÓSITO PARA UMA DETERMINADA AGÊNCIA/CONTA INFORMADA COMO PARÂMETRO.

select sum(Valor) from Operacao where TipoOperacao = 'D' and Conta_Agencia_Numero = 2010 and Conta_Numero = 0001

go
alter function soma_depositos(@Conta_Agencia_Numero char(4), @Conta_Numero char(6))
returns decimal(10,2)
begin
  declare @calculo decimal(10,2)
  
  select  @calculo = sum(Valor) from Operacao where 
  TipoOperacao = 'D' and 
  Conta_Agencia_Numero = @Conta_Agencia_Numero and 
  Conta_Numero = @Conta_Numero
   

  return(@calculo)
end
go

select dbo.soma_depositos('2010', '0001')


-- CRIAR UMA FUNCTION QUE RETORNE UMA JUNÇÃO ENTRE AS TABELAS CLIENTE E CLIENTEPF TRAZENDO SOMENTE CLIENTES CUJO NOME
-- COMECEM POR UM DETERMINADO TEXTO


go
create function Clientes_PF(@texto varchar(10))
returns Table
as
return
(
select * from cliente join ClientePF on clientepf.Cliente_Id = Cliente.Id where nome like @texto+'%'
)
go


select * from Cliente 
	 JOIN ClientePF  
		on Cliente.Id = ClientePF.Cliente_Id where Cliente.Nome like 'M%'


select * from dbo.Clientes_PF('M')
