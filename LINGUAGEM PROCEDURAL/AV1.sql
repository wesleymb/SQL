CREATE PROCEDURE CALCULAR (@Valor1 FLOAT,@Valor2 FLOAT, @OPERACAO CHAR(1))
AS
BEGIN 
	IF (@OPERACAO = '+')
		SELECT(CONCAT('RESULTADO: ',@Valor1+@Valor2))

	IF (@OPERACAO = '-')
		SELECT(CONCAT('RESULTADO: ',@Valor1-@Valor2))

	IF (@OPERACAO = 'x')
		SELECT(CONCAT('RESULTADO: ',@Valor1*@Valor2))
	
	IF (@OPERACAO = '/')
		SELECT(CONCAT('RESULTADO: ',@Valor1 - @Valor2))

END


GO 

EXEC CALCULAR 10, 5, '/' 


create table Notas(
Matricula Int not null primary key,
AV1 Decimal (5,2) null,
AV2 Decimal (5,2) null,
Media Decimal(5,2) null, 
Aprovado Char(01) null)

insert into Notas (Matricula, AV1, AV2, Media, Aprovado) values (1001, 4, 8, null, null)
insert into Notas (Matricula, AV1, AV2, Media, Aprovado) values (1002, 3, 10, null, null)
insert into Notas (Matricula, AV1, AV2, Media, Aprovado) values (1003, 8, 7, null, null)
insert into Notas (Matricula, AV1, AV2, Media, Aprovado) values (1004, 6, 10, null, null)

GO
CREATE PROCEDURE AVALIAR
AS
BEGIN
	DECLARE @MATRICULA INT 
	DECLARE @AV1 Decimal (5,2)
	DECLARE @AV2 Decimal (5,2)

	DEClARE cursor_AV1_AV2 CURSOR FOR 
	select AV1,AV2,Matricula
	from Notas

	open cursor_AV1_AV2
	FETCH cursor_AV1_AV2 INTO @AV1, @AV2,@MATRICULA
	WHILE @@FETCH_STATUS = 0
		BEGIN
		DECLARE @MEDIA Decimal (5,2)
		SET @MEDIA = (@AV1+@AV2)/2
		
		
		UPDATE Notas
		SET MEDIA = @MEDIA 
		WHERE MATRICULA = @MATRICULA
		
		IF (@MEDIA >=6)
			UPDATE Notas
			SET Aprovado = 'S' 
			WHERE MATRICULA = @MATRICULA
		ELSE
			UPDATE Notas
			SET Aprovado = 'N' 
			WHERE MATRICULA = @MATRICULA

		FETCH cursor_AV1_AV2 INTO @AV1, @AV2,@MATRICULA
		END
	CLOSE cursor_AV1_AV2
	DEALLOCATE cursor_AV1_AV2
	SELECT * FROM NOTAS
END

EXEC AVALIAR

SELECT * FROM NOTAS