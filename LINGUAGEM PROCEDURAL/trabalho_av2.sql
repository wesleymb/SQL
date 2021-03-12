	
create table Cadastro(
  Matricula int not null primary key,
  Nome varchar(30) not null,
  Email varchar(40) null,
  DtaNascto date not null,
  CPF decimal(11) not null)

create table Log(
  id int not null identity,
  DtaHora datetime not null,
  TipoExecucao char(01) not null, --I / A / D
  NomeUsuario varchar(30) not null,
  HostName varchar(30) not null,
  ValoresInseridos varchar(200) null,
  ValoresExcluidos varchar(200) null)

select getdate()
select SYSTEM_USER
select host_name()

select * from Cadastro 

insert into Cadastro (Matricula, Nome, Email, DtaNascto, CPF) 
values (4321, 'Wesley', 'wesleyafdp@gmail.com', '1991-03-05', '256969')

select cast(Matricula as varchar)+';' from Cadastro

GO
CREATE TRIGGER TGR_Cadastro_INSERT
ON Cadastro
FOR INSERT
AS
BEGIN
    DECLARE
		@Matricula int,
		@Nome varchar(30),
		@Email varchar(40),
		@DtaNascto date,
		@CPF decimal(11),
		------------------------------------------------------
		@DtaHora datetime = cast(getdate() as varchar),
		@TipoExecucao char(1) = 'I',
		@NomeUsuario varchar(30) = SYSTEM_USER,
		@HostName varchar(30) = host_name()


    SELECT 
		@Matricula = Matricula, 
		@Nome = Nome,
		@Email = Email,
		@DtaNascto = DtaNascto,
		@CPF = CPF
	FROM inserted
	
	DECLARE
		@ValoresInseridos varchar(900) = concat(@Matricula,';',@Nome,';', @Email,';',@DtaNascto ,';',@CPF)
	
		

    insert into Log (
		DtaHora,
		TipoExecucao,
		NomeUsuario,
		HostName,
		ValoresInseridos
		) 
		Values(
		@DtaHora,
		@TipoExecucao,
		@NomeUsuario,
		@HostName,
		@ValoresInseridos
		)
END
go
 
 -----------------------------------------------------------------------------------------------------
 
 CREATE TRIGGER TGR_Cadastro_DELETE
ON Cadastro
FOR DELETE
AS
BEGIN
    DECLARE
		@Matricula int,
		@Nome varchar(30),
		@Email varchar(40),
		@DtaNascto date,
		@CPF decimal(11),
		------------------------------------------------------
		@DtaHora datetime = cast(getdate() as varchar),
		@TipoExecucao char(1) = 'D',
		@NomeUsuario varchar(30) = SYSTEM_USER,
		@HostName varchar(30) = host_name()


    SELECT 
		@Matricula = Matricula, 
		@Nome = Nome,
		@Email = Email,
		@DtaNascto = DtaNascto,
		@CPF = CPF
	FROM deleted
	
	DECLARE
		@ValoresExcluidos varchar(900) = concat(@Matricula,';',@Nome,';', @Email,';',@DtaNascto ,';',@CPF)
	
		

    insert into Log (
		DtaHora,
		TipoExecucao,
		NomeUsuario,
		HostName,
		ValoresExcluidos
		) 
		Values(
		@DtaHora,
		@TipoExecucao,
		@NomeUsuario,
		@HostName,
		@ValoresExcluidos
		)
END
go
 

 ----------------------------------------------------------------------------------------------------
CREATE TRIGGER TGR_Cadastro_UPDATE
ON Cadastro
FOR UPDATE
AS
BEGIN
    DECLARE
		@Matricula int,
		@Nome varchar(30),
		@Email varchar(40),
		@DtaNascto date,
		@CPF decimal(11),
		------------------------------------------------------
		@DtaHora datetime = cast(getdate() as varchar),
		@TipoExecucao char(1) = 'A',
		@NomeUsuario varchar(30) = SYSTEM_USER,
		@HostName varchar(30) = host_name()


    SELECT 
		@Matricula = Matricula, 
		@Nome = Nome,
		@Email = Email,
		@DtaNascto = DtaNascto,
		@CPF = CPF
	FROM deleted
	
	
	DECLARE
		@ValoresExcluidos varchar(900) = concat(@Matricula,';',@Nome,';', @Email,';',@DtaNascto ,';',@CPF)
	
	
	 SELECT 
		@Matricula = Matricula, 
		@Nome = Nome,
		@Email = Email,
		@DtaNascto = DtaNascto,
		@CPF = CPF
	FROM inserted

	DECLARE
		@ValoresInseridos varchar(900) = concat(@Matricula,';',@Nome,';', @Email,';',@DtaNascto ,';',@CPF)


    insert into Log (
		DtaHora,
		TipoExecucao,
		NomeUsuario,
		HostName,
		ValoresInseridos,
		ValoresExcluidos
		) 
		Values(
		@DtaHora,
		@TipoExecucao,
		@NomeUsuario,
		@HostName,
		@ValoresInseridos,
		@ValoresExcluidos
		)
END
go





