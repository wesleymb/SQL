create procedure primo(@numero int)
as
begin
   declare @contador int
   declare @primo char(01)
   set @contador = 2
   set @primo = 'S'
   while @contador < @numero
   begin
     if @numero % @contador = 0
       set @primo = 'N'
     set @contador = @contador + 1
   end
   if @primo = 'S'
     select 'O número é primo'
   else
     select 'O número não é primo'
end
go

 

exec primo 32

--Crie uma procedure que mostre a quantidade de valores pares entre dois números lidos

go
create procedure pares_entre_valores(@numero1 int, @numero2 int)
as
begin
	declare @contador int = 0
	declare @pares int =0
	while @numero1 <= @numero2
		begin
		if @numero1 % 2 = 0
			set @pares = @pares + 1
		set @numero1 = @numero1 + 1
	
	end
	select concat('Total: ', @pares)
end

drop procedure  pares_entre_valores
go
exec pares_entre_valores 1,10


--Crie uma procedure que que calcule e mostre uma tabela de conversão de graus Celsius para Fahrenheit, de N a Y (Celsius)

--1 Celsius - 33,8 Fahrenheit

--conversão celsius fahrenheit

go
alter procedure  celsius_para_fahrenheit(@n float, @y float)
as
begin 
	while @n <= @y
		begin
		declare @total float
		set @total = (@n * 9/5) + 32
		select CONCAT(@n,'C' ,' = ', @total,'F')
		set @total = 0
		set @n = @n + 1
		end
end
go
drop procedure celsius_para_fahrenheit
go
exec celsius_para_fahrenheit 1,3

--Escreva um laço while para imprimir todos os quadrados menores que n. Por exemplo, se n for 100, imprimir 0 1 4 9 16 25 36 49 64 81.

go
alter procedure  quadro_maior(@numero int)
as
begin
	declare @quadrado int = 1
	declare @contador int = 1
	while @quadrado < @numero
		begin
		set @quadrado = @contador  * @contador
		
		if @quadrado < @numero
			select concat( 'Menor: ',@quadrado)
		set @contador = @contador  + 1
		end

end

exec quadro_maior 20