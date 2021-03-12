use estaciobd;

/** procedure - devolver a quantidade de linhas da tabela **/
 go

create procedure contar_estados( @quantidade int OUT)
as
begin
  select @quantidade = count(*) from estado
end

/** exemplo de execução **/
declare @total int 
exec contar_estados @total out
select @total


/** procedure - concatenar um texto **/
go

create procedure concatena_texto
as
begin
  declare @texto varchar(10)
  set @texto='Isto é um '
  --select concat(@texto,'exemplo')
  select @texto + 'exemplo'
end

/** exemplo de execução **/
exec concatena_texto


/** procedure - receber um numero e elevar ao quadrado **/

/** por default é só de entrada s**/
go

create procedure elevar_ao_quadrado ( @numero int out)
as
begin
	SET @numero = @numero*@numero
end

/** exemplo de execução **/
declare @valor int
set @valor = 5
exec elevar_ao_quadrado @valor out
select @valor


/** procedure - receber dois números e calcular a média **/

go

create procedure calcula_media (@numero1 int, @numero2 int, @retorno int out)
as
begin
	declare @conta int
    set @conta = (@numero1+@numero2)/2;
    set @retorno = @conta
end

/** exemplo de execução **/
declare @media int
set @media=0
exec calcula_media 4,2,@media out
select @media

/** procedure - receber dois números, calcular a média e devolver se foi aprovado ou reprovado**/
go

create procedure verifica_aprovacao ( @nota1 decimal(10,2), @nota2 decimal(10,2), @status varchar(20) out)
as
begin 
	if (@nota1+@nota2)/2 > 6
		set @status = 'aprovado'
	else 
		set @status = 'reprovado'
end

/** exemplo de execução **/
declare @resultado char(20)
exec verifica_aprovacao 10, 8, @resultado out
select @resultado

/** exercicios 

1) Ler dois números e calcular seu produto
2) Ler um número e informar a metade e o dobro do numero lido
3) Ler dois números e informar sua soma e sua diferença
4) Ler um número e informar se o dobro donúmero é maior que 100.

**/ 

/** EXERCICIO 1 **/
go

create procedure exercicio_1 (@numero1 int, @numero2 int, @produto int out)
as
begin 
    set @produto = @numero1 * @numero2
end
go


declare @resultado1 int
set @resultado1 = 0
exec exercicio_1 2, 4, @resultado1 out
select @resultado1
go

/** EXERCICIO 2 **/

go
create procedure exercicio_2 (@numero1  decimal(10,2), @metade  decimal(10,2) out, @dobro  decimal(10,2) out)
as
begin 
    set @metade = @numero1/2 
	set @dobro = @numero1*2 
end

declare @metade2 decimal(10,2) , @dobro2 decimal(10,2)
exec exercicio_2 9, @metade2 out, @dobro2 out
select @metade2, @dobro2

drop procedure exercicio_2

/** EXERCICIO 3 **/
go
create procedure exercicio_3 (@numero1 decimal(10,2),@numero2 decimal(10,2), @soma decimal(10,2) out,@diferenca decimal(10,2) out)
as
begin 
    set @soma = @numero1+@numero2;
	set @diferenca = @numero1-@numero2
end


declare @soma3 decimal(10,2), @diferenca3 decimal(10,2)
exec exercicio_3 10,5, @soma3 out, @diferenca3 out
select @soma3, @diferenca3

/** EXERCICIO 4 **/

go

create procedure exercicio_4 (@numero int, @status varchar(20) out)
as
begin 
	if (@numero*2)>100 
		set @status = 'Maior que 100'
	else 
		set @status = 'Menor que 100'
end
go
declare @resultado4  varchar(20)
exec exercicio_4 40, @resultado4 out
select @resultado4

go

---1)Crie uma procedure que leia dois números quaisquer e informa se o primeiro é maior, igual ou menor do que o segundo.

create procedure exercicio_1_X (@numero1 int, @numero2 int, @status varchar(50) out)
as
begin 
    if (@numero1 > @numero2)
        set @status = 'Primeiro é maior que o segundo.'
		
	else if (@numero1 = @numero2)
			set @status = 'Primeiro é igual ao segundo.'
		else
			set @status = 'Primeiro é menor que o segundo'    
end

 

DECLARE @resultado varchar(50) 
exec exercicio_1_x 2, 4, @resultado out
select @resultado

--2)Crie uma procedure que leia um número qualquer e informa se o número lido está no intervalo de 0 a 100.
 

go
create procedure exercicio_2_x (@numero int, @status varchar(50) out)
as
begin 
    if @numero >= 0 and @numero <= 100
        set @status = 'Número está no intervalo de 0 a 100.'
    else
        set @status = 'Número não está no intervalo de 0 a 100.'
    
end

 

declare @resultado varchar(50) 
exec exercicio_2_x 101, @resultado out
select @resultado

--3)Crie uma procedure que leia um número qualquer e informa se o número lido está nos intervalos de 0 a 10 ou 20 a 30.

 

go
create procedure exercicio_3_x (@numero int,  @status varchar(100) out)
as
begin 
    if @numero >= 0 and @numero <= 10
        set @status = 'Número está no intervalo de 0 a 10.'
    else if @numero >= 20 and @numero <= 30
        set @status = 'Número está no intervalo de 20 a 30.'
    else
        set @status = 'Número não está nos intervalos de 0 a 10 ou 20 a 30.'    
   
end

 
go
declare @resultado varchar(100) 
exec exercicio_3_x 10, @resultado out
select @resultado
go




--4)Crie uma procedure que leia três números e informa qual dos três é o maior.

 

create procedure exercicio_40 (@numero1 int, @numero2 int, @numero3 int, @status varchar(100) out)
as
begin 
    declare @maior int
    if (@numero1 > @numero2)
      set @maior = @numero1;
    else if @numero2 > @numero3
      set @maior = @numero2
    else
      set @maior = @numero3        
    set @status = concat('O maior número é o número ', @maior)
end
 


/** exemplo de execução **/
declare @resultado varchar(100) = ''
exec exercicio_40 234,21,223,@resultado out
select @resultado


--5)Crie uma procedure que leia a renda de uma pessoa e calcula um imposto, com base na tabela de alíquotas abaixo. 
--Até     1.200,00    isento
--de     1.201,00 a 5.000,00    10%
--de    5.001,00 a 10.000,00    15%
--acima de 10.000,00        20%

 

go
create procedure exercicio_5_x (@renda decimal(10,2),@imposto decimal(10,2) out)
as
begin 
    if @renda <= 1000
      set @imposto = 0;
    else if @renda >= 1201 and @renda <= 5000
      set @imposto = @renda * 0.10;
    else if @renda >= 5001 and @renda <= 10000
      set @imposto = @renda * 0.15
    else
      set @imposto = @renda * 0.20
    
end

 

declare @imposto decimal(10,2)
exec exercicio_5_x 5000, @imposto out 
select @imposto