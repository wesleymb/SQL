  
--1)Crie uma procedure que receba dois números inteiros, inicial e final, 
--e mostre na tela os números inteiros do inicial até o final.


--Crítica: o número final deve ser maior do que o inicial.


create procedure aula_1(@inicial int, @final int)
as
begin
  if @final <= @inicial
    select 'O número inicial deve ser menor que o número final' as mensagem
  else
    while @inicial <= @final
    begin
      select @inicial
      set @inicial = @inicial + 1
    end
end
go


exec aula_1 2, 10


--2)Crie uma procedure que calcula a soma dos números pares compreendidos entre dois números recebidos.
--Crítica: o número final deve ser maior do que o inicial.

go

create procedure aula_2 (@inicial int, @final int)
as
begin
   declare @soma int
   set @soma = 0
   if @final <= @inicial
     select 'O número @inicial deve ser menor que o número @final.' as mensagem
   else
   begin
      while @inicial <= @final
      begin
         if @inicial % 2 = 0
           set @soma = @soma + @inicial
         set @inicial = @inicial + 1
      end
      select 'A @soma é: ', @soma
   end
end
go

 

exec aula_2 1,6



 
 --3)Crie uma procedure que receba um número de 1 a 9 e mostra a tabuada de multiplicação do número. Por exemplo, para o 5:
--5 x 1  = 5
--5 x 2  = 10
--...
--5 x 10 = 50
 go
create procedure aula_3 (@numero int)
as
begin
   declare @contador int
   if @numero > 9
     select 'O número deve ser menor ou igual a 9.' as mensagem
   else
   begin
      set @contador = 1
      while @contador <= 10
      begin
         select concat(@numero, ' x ', @contador, ' = ', @numero * @contador)
         set @contador = @contador + 1
      end 
   end
end

 

exec aula_3 8


--4)Crie uma procedure que receba um número e calcule o seu fatorial.
go
create procedure aula_4 (@numero int)
as
begin
   declare @fatorial int, @contador int
   set @contador = 1
   set @fatorial = 1
   while @contador <= @numero
   begin
     set @fatorial = @fatorial * @contador
     set @contador = @contador + 1
   end
   select @fatorial
end

 

exec aula_4 4

