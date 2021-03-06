USE [OnlineNarucivanje]
GO
/****** Object:  User [aca]    Script Date: 6/10/2020 6:19:39 PM ******/
CREATE USER [aca] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [aca98]    Script Date: 6/10/2020 6:19:39 PM ******/
CREATE USER [aca98] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [aca981]    Script Date: 6/10/2020 6:19:39 PM ******/
CREATE USER [aca981] FOR LOGIN [aca981] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [test]    Script Date: 6/10/2020 6:19:39 PM ******/
CREATE USER [test] FOR LOGIN [test] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [aca]
GO
ALTER ROLE [db_owner] ADD MEMBER [aca98]
GO
ALTER ROLE [db_owner] ADD MEMBER [aca981]
GO
ALTER ROLE [db_owner] ADD MEMBER [test]
GO
/****** Object:  Table [dbo].[Proizvod]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proizvod](
	[id_proizvod] [int] IDENTITY(1,1) NOT NULL,
	[naziv] [nchar](50) NOT NULL,
	[sastojci] [nvarchar](200) NOT NULL,
	[cena] [int] NOT NULL,
	[obrisano] [bit] NULL,
 CONSTRAINT [PK_Proizvod] PRIMARY KEY CLUSTERED 
(
	[id_proizvod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[func_FiltrirajProizvode]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_FiltrirajProizvode](@filter nvarchar(50))
returns table
as return(
SELECT * FROM Proizvod where naziv like '%'+@filter+'%'

)
GO
/****** Object:  Table [dbo].[Zaposleni]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zaposleni](
	[username] [nvarchar](30) NOT NULL,
	[password] [nvarchar](30) NOT NULL,
	[ime] [nvarchar](30) NOT NULL,
	[prezime] [nvarchar](30) NOT NULL,
	[adresa] [nvarchar](100) NOT NULL,
	[telefon] [nvarchar](30) NOT NULL,
	[obrisano] [bit] NULL,
	[dat_zap] [datetime] NULL,
	[dat_otkaza] [datetime] NULL,
 CONSTRAINT [PK_Zaposleni] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Zaposleni]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Zaposleni]
AS
SELECT        username, password, ime, prezime, adresa, telefon, obrisano, dat_zap, dat_otkaza
FROM            dbo.Zaposleni
WHERE        (obrisano = 0)
GO
/****** Object:  UserDefinedFunction [dbo].[func_NadjiZaposlenog]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_NadjiZaposlenog](@username nvarchar(50))
returns table
as return(
select * from Zaposleni where username = @username and obrisano = 0

)
GO
/****** Object:  UserDefinedFunction [dbo].[func_NadjiZaposlenog_i_Otpustenog]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_NadjiZaposlenog_i_Otpustenog](@username nvarchar(50))
returns table
as return(
select * from Zaposleni where username = @username

)
GO
/****** Object:  View [dbo].[View_Zaposleni_i_Otpusteni]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Zaposleni_i_Otpusteni]
AS
SELECT        username, password, ime, prezime, adresa, telefon, obrisano, dat_zap, dat_otkaza
FROM            dbo.Zaposleni
GO
/****** Object:  Table [dbo].[ProizvodKolicina]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProizvodKolicina](
	[id_kolicina] [int] NOT NULL,
	[id_proizvod] [int] NOT NULL,
	[kolicina] [int] NOT NULL,
 CONSTRAINT [PK_ProizvodKolicina_1] PRIMARY KEY CLUSTERED 
(
	[id_kolicina] ASC,
	[id_proizvod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[func_Vrati_ProizvodKolicina]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_Vrati_ProizvodKolicina](@id int)
returns table
as return(
select * from ProizvodKolicina where id_kolicina = @id
)
GO
/****** Object:  UserDefinedFunction [dbo].[func_Vrati_Proizvod]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_Vrati_Proizvod](@obrisano int)
returns table
as return(
select * from Proizvod where obrisano = @obrisano
)
GO
/****** Object:  UserDefinedFunction [dbo].[func_Nadji_Proizvod]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_Nadji_Proizvod](@id_proizvod int)
returns table
as return(
select * from Proizvod where id_proizvod = @id_proizvod
)
GO
/****** Object:  Table [dbo].[Narudzbina]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Narudzbina](
	[id_narudzbina] [int] IDENTITY(1,1) NOT NULL,
	[ime] [nvarchar](30) NOT NULL,
	[prezime] [nvarchar](30) NOT NULL,
	[adresa] [nvarchar](100) NOT NULL,
	[id_kolicina] [int] NULL,
	[preuzeto] [int] NOT NULL,
 CONSTRAINT [PK_Narudzbina] PRIMARY KEY CLUSTERED 
(
	[id_narudzbina] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Narudzbina]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Narudzbina]
AS
SELECT        id_narudzbina, ime, prezime, adresa, id_kolicina, preuzeto
FROM            dbo.Narudzbina
WHERE        (preuzeto = 0)
GO
/****** Object:  Table [dbo].[Preuzeto]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Preuzeto](
	[username] [nvarchar](30) NOT NULL,
	[id_narudzbina] [int] NOT NULL,
	[datum_preuzeto] [datetime] NULL,
 CONSTRAINT [PK_Preuzeto] PRIMARY KEY CLUSTERED 
(
	[username] ASC,
	[id_narudzbina] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_PreuzeteNarudzbine]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_PreuzeteNarudzbine]
AS
SELECT        dbo.Preuzeto.username, dbo.Narudzbina.id_narudzbina, dbo.Preuzeto.datum_preuzeto, dbo.Narudzbina.ime, dbo.Narudzbina.prezime, dbo.Narudzbina.adresa, dbo.Narudzbina.id_kolicina, dbo.Narudzbina.preuzeto
FROM            dbo.Preuzeto INNER JOIN
                         dbo.Narudzbina ON dbo.Preuzeto.id_narudzbina = dbo.Narudzbina.id_narudzbina
GO
/****** Object:  UserDefinedFunction [dbo].[func_PreuzeteNarudzbineZaposlenog]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_PreuzeteNarudzbineZaposlenog](@username nvarchar(50))
returns table
as return(
Select * from view_PreuzeteNarudzbine where username = @username
)
GO
/****** Object:  Table [dbo].[Isporuceno]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Isporuceno](
	[id_isporuceno] [int] NOT NULL,
	[username] [nvarchar](30) NOT NULL,
	[ime] [nvarchar](30) NOT NULL,
	[prezime] [nvarchar](30) NOT NULL,
	[adresa] [nvarchar](100) NOT NULL,
	[id_kolicina] [int] NOT NULL,
	[preuzeto] [int] NOT NULL,
	[vreme_Preuzimanja] [datetime] NULL,
	[vreme_Predaje] [datetime] NULL,
 CONSTRAINT [PK_Isporuceno_1] PRIMARY KEY CLUSTERED 
(
	[id_isporuceno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_Isporuceno]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Isporuceno]
AS
SELECT        dbo.Zaposleni.username, dbo.Zaposleni.password, dbo.Zaposleni.ime AS zapime, dbo.Zaposleni.prezime AS zapprezime, dbo.Zaposleni.adresa AS zapadresa, dbo.Zaposleni.telefon AS zaptelefon, dbo.Zaposleni.dat_zap, 
                         dbo.Zaposleni.dat_otkaza, dbo.Isporuceno.id_isporuceno, dbo.Isporuceno.ime, dbo.Isporuceno.prezime, dbo.Isporuceno.adresa, dbo.Isporuceno.id_kolicina, dbo.Isporuceno.vreme_Preuzimanja, dbo.Isporuceno.vreme_Predaje, 
                         dbo.Isporuceno.preuzeto
FROM            dbo.Zaposleni INNER JOIN
                         dbo.Isporuceno ON dbo.Zaposleni.username = dbo.Isporuceno.username
GO
/****** Object:  UserDefinedFunction [dbo].[func_NadjiIsporuceno]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_NadjiIsporuceno](@id_isporuceno int)
returns table
as return(
select * from view_Isporuceno where id_isporuceno = @id_isporuceno
)
GO
INSERT [dbo].[Isporuceno] ([id_isporuceno], [username], [ime], [prezime], [adresa], [id_kolicina], [preuzeto], [vreme_Preuzimanja], [vreme_Predaje]) VALUES (6, N'aca98', N'Miric', N'Mirkovic', N'Beograd', 6, 1, CAST(N'2020-06-09T15:24:16.783' AS DateTime), CAST(N'2020-06-09T15:24:19.350' AS DateTime))
INSERT [dbo].[Isporuceno] ([id_isporuceno], [username], [ime], [prezime], [adresa], [id_kolicina], [preuzeto], [vreme_Preuzimanja], [vreme_Predaje]) VALUES (7, N'aca98', N'Aleksa', N'Milosevic', N'Beograd', 7, 1, CAST(N'2020-06-09T15:24:17.520' AS DateTime), CAST(N'2020-06-09T15:24:19.883' AS DateTime))
INSERT [dbo].[Isporuceno] ([id_isporuceno], [username], [ime], [prezime], [adresa], [id_kolicina], [preuzeto], [vreme_Preuzimanja], [vreme_Predaje]) VALUES (8, N'aca98', N'Marko', N'Markovic', N'Beograd', 8, 1, CAST(N'2020-06-10T14:46:18.823' AS DateTime), CAST(N'2020-06-10T14:48:13.163' AS DateTime))
SET IDENTITY_INSERT [dbo].[Narudzbina] ON 

INSERT [dbo].[Narudzbina] ([id_narudzbina], [ime], [prezime], [adresa], [id_kolicina], [preuzeto]) VALUES (9, N'Veljko', N'Petrovic', N'Beograd', 9, 0)
INSERT [dbo].[Narudzbina] ([id_narudzbina], [ime], [prezime], [adresa], [id_kolicina], [preuzeto]) VALUES (10, N'Mirko', N'Marijanovic', N'Beograd', 10, 0)
SET IDENTITY_INSERT [dbo].[Narudzbina] OFF
SET IDENTITY_INSERT [dbo].[Proizvod] ON 

INSERT [dbo].[Proizvod] ([id_proizvod], [naziv], [sastojci], [cena], [obrisano]) VALUES (1, N'Pica                                              ', N'Sunka,Kecap,So,Pecurk', 100, 1)
INSERT [dbo].[Proizvod] ([id_proizvod], [naziv], [sastojci], [cena], [obrisano]) VALUES (2, N'Krem pita                                         ', N'Sećer, Mleko, Jaje', 60, 0)
INSERT [dbo].[Proizvod] ([id_proizvod], [naziv], [sastojci], [cena], [obrisano]) VALUES (3, N'Pica                                              ', N'Sunka,Kecap,So,Pecurke', 90, 0)
INSERT [dbo].[Proizvod] ([id_proizvod], [naziv], [sastojci], [cena], [obrisano]) VALUES (4, N'Sendvic                                           ', N'Sunka,Hleb,Kackavalj', 100, 0)
SET IDENTITY_INSERT [dbo].[Proizvod] OFF
INSERT [dbo].[ProizvodKolicina] ([id_kolicina], [id_proizvod], [kolicina]) VALUES (6, 1, 2)
INSERT [dbo].[ProizvodKolicina] ([id_kolicina], [id_proizvod], [kolicina]) VALUES (6, 2, 1)
INSERT [dbo].[ProizvodKolicina] ([id_kolicina], [id_proizvod], [kolicina]) VALUES (7, 1, 2)
INSERT [dbo].[ProizvodKolicina] ([id_kolicina], [id_proizvod], [kolicina]) VALUES (7, 2, 2)
INSERT [dbo].[ProizvodKolicina] ([id_kolicina], [id_proizvod], [kolicina]) VALUES (8, 3, 1)
INSERT [dbo].[ProizvodKolicina] ([id_kolicina], [id_proizvod], [kolicina]) VALUES (9, 2, 1)
INSERT [dbo].[ProizvodKolicina] ([id_kolicina], [id_proizvod], [kolicina]) VALUES (9, 3, 3)
INSERT [dbo].[ProizvodKolicina] ([id_kolicina], [id_proizvod], [kolicina]) VALUES (9, 4, 1)
INSERT [dbo].[ProizvodKolicina] ([id_kolicina], [id_proizvod], [kolicina]) VALUES (10, 2, 2)
INSERT [dbo].[ProizvodKolicina] ([id_kolicina], [id_proizvod], [kolicina]) VALUES (10, 4, 1)
INSERT [dbo].[Zaposleni] ([username], [password], [ime], [prezime], [adresa], [telefon], [obrisano], [dat_zap], [dat_otkaza]) VALUES (N'aca98', N'123', N'Aleksandar', N'Ignjatovic', N'Beograd', N'0698625734', 0, CAST(N'2020-06-09T11:53:29.410' AS DateTime), NULL)
INSERT [dbo].[Zaposleni] ([username], [password], [ime], [prezime], [adresa], [telefon], [obrisano], [dat_zap], [dat_otkaza]) VALUES (N'ivan92', N'123', N'Ivan', N'Milkov', N'Beograd', N'0698376347', 0, CAST(N'2020-06-10T18:08:38.553' AS DateTime), NULL)
INSERT [dbo].[Zaposleni] ([username], [password], [ime], [prezime], [adresa], [telefon], [obrisano], [dat_zap], [dat_otkaza]) VALUES (N'mirko97', N'123', N'Mirko', N'Miric', N'Beograd', N'0692638462', 0, CAST(N'2020-06-10T18:08:52.680' AS DateTime), NULL)
ALTER TABLE [dbo].[Narudzbina] ADD  CONSTRAINT [DF_Narudzbina_preuzeto]  DEFAULT ((0)) FOR [preuzeto]
GO
ALTER TABLE [dbo].[Proizvod] ADD  CONSTRAINT [DF_Proizvod_obrisano]  DEFAULT ((0)) FOR [obrisano]
GO
ALTER TABLE [dbo].[Zaposleni] ADD  CONSTRAINT [DF_Zaposleni_obrisano]  DEFAULT ((0)) FOR [obrisano]
GO
ALTER TABLE [dbo].[Isporuceno]  WITH CHECK ADD  CONSTRAINT [FK_Isporuceno_Zaposleni] FOREIGN KEY([username])
REFERENCES [dbo].[Zaposleni] ([username])
GO
ALTER TABLE [dbo].[Isporuceno] CHECK CONSTRAINT [FK_Isporuceno_Zaposleni]
GO
ALTER TABLE [dbo].[Preuzeto]  WITH CHECK ADD  CONSTRAINT [FK_Preuzeto_Narudzbina] FOREIGN KEY([id_narudzbina])
REFERENCES [dbo].[Narudzbina] ([id_narudzbina])
GO
ALTER TABLE [dbo].[Preuzeto] CHECK CONSTRAINT [FK_Preuzeto_Narudzbina]
GO
ALTER TABLE [dbo].[Preuzeto]  WITH CHECK ADD  CONSTRAINT [FK_Preuzeto_Zaposleni] FOREIGN KEY([username])
REFERENCES [dbo].[Zaposleni] ([username])
GO
ALTER TABLE [dbo].[Preuzeto] CHECK CONSTRAINT [FK_Preuzeto_Zaposleni]
GO
ALTER TABLE [dbo].[ProizvodKolicina]  WITH CHECK ADD  CONSTRAINT [FK_ProizvodKolicina_Proizvod] FOREIGN KEY([id_proizvod])
REFERENCES [dbo].[Proizvod] ([id_proizvod])
GO
ALTER TABLE [dbo].[ProizvodKolicina] CHECK CONSTRAINT [FK_ProizvodKolicina_Proizvod]
GO
/****** Object:  StoredProcedure [dbo].[proc_Dodaj_Proizvod]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[proc_Dodaj_Proizvod](@naziv nvarchar(30),@sastojci nvarchar(30),@cena int)
as begin

if(@naziv = '' or @sastojci = '' or @cena < 0)begin
return -2
end
begin tran
INSERT INTO Proizvod(naziv,sastojci,cena,obrisano) VALUES(@naziv,@sastojci,@cena,0)

if(@@ERROR > 0)begin
rollback
return -1
end else begin 
commit
return 1
end

end
GO
/****** Object:  StoredProcedure [dbo].[proc_DodajNarudzbinu]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[proc_DodajNarudzbinu](@ime nvarchar(50),@prezime nvarchar(50),@adresa nvarchar(100))
as begin
if(@ime = '' or @prezime = '' or @adresa = '')begin
return -2
end
INSERT INTO Narudzbina(ime,prezime,adresa,preuzeto) VALUES(@ime,@prezime,@adresa,0)

if(@@ERROR > 0)begin
rollback
return -1
end else begin 
commit
return 1
end

end
GO
/****** Object:  StoredProcedure [dbo].[proc_DodajProizvodKolicina]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[proc_DodajProizvodKolicina](@id_proizvod int,@kolicina int)
as begin

declare @id_kolicina int;
select @id_kolicina = MAX(id_narudzbina) FROM Narudzbina

INSERT INTO ProizvodKolicina(id_kolicina,id_proizvod,kolicina)
VALUES(@id_kolicina,@id_proizvod,@kolicina)

UPDATE Narudzbina
set id_kolicina = @id_kolicina
where id_narudzbina = @id_kolicina

end
GO
/****** Object:  StoredProcedure [dbo].[proc_DodajZaposlenog]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[proc_DodajZaposlenog](@username nvarchar(50),@password nvarchar(50),@ime nvarchar(50),
@prezime nvarchar(50),@adresa nvarchar(50),@telefon nvarchar(50))
as begin

begin tran


INSERT INTO Zaposleni(username,password,ime,prezime,adresa,telefon,obrisano,dat_zap)
VALUES(@username,@password,@ime,@prezime,@adresa,@telefon,0,GETDATE())

if (@@ERROR > 0)begin
rollback
return -1
end else begin
commit
return 1
end

end
GO
/****** Object:  StoredProcedure [dbo].[proc_Isporuceno]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[proc_Isporuceno](@id_narudzbina int)
as begin 

begin tran

DELETE FROM Preuzeto where id_narudzbina = @id_narudzbina

if(@@ERROR > 0)begin
rollback
return -1
end else begin
commit
return 1
end

end
GO
/****** Object:  StoredProcedure [dbo].[proc_ObrisiProizvod]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[proc_ObrisiProizvod](@id_proizvod int)
as begin

tran begin
UPDATE Proizvod 
set obrisano = 1
where id_proizvod = @id_proizvod
if @@ERROR > 0 begin
rollback
return -1
end else begin
commit
return 1
end
end
GO
/****** Object:  StoredProcedure [dbo].[proc_ObrisiZaposlenog]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[proc_ObrisiZaposlenog](@username nvarchar(50))
as begin

begin tran

UPDATE Zaposleni set obrisano = 1, dat_otkaza = GETDATE() where username = @username


if( @@ERROR > 0)begin
rollback
return -1
end else begin
commit
return 1
end


end
GO
/****** Object:  StoredProcedure [dbo].[proc_PreuzmiNarudzbinu]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[proc_PreuzmiNarudzbinu](@id_narudzbina int,@username nvarchar(30))
as begin
begin tran
UPDATE Narudzbina set preuzeto = 1 where id_narudzbina = @id_narudzbina

INSERT INTO Preuzeto(id_narudzbina,username,datum_preuzeto)
VALUES(@id_narudzbina,@username,GETDATE())
if @@ERROR > 0 begin
rollback
return -1
end else begin
commit
return 1
end 
end
GO
/****** Object:  StoredProcedure [dbo].[proc_PromeniProizvod]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[proc_PromeniProizvod](@id_proizvod int,@naziv nvarchar(50),@sastojci nvarchar(50),@cena int)
as begin

begin tran
UPDATE Proizvod set naziv = @naziv, sastojci = @sastojci, cena = @cena where id_proizvod = @id_proizvod

if(@@ERROR > 0)begin
rollback
return -1
end else begin
commit
return 1
end

end
GO
/****** Object:  StoredProcedure [dbo].[proc_VratiProizvod]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[proc_VratiProizvod](@id_proizvod int)
as begin

tran begin
UPDATE Proizvod 
set obrisano = 0
where id_proizvod = @id_proizvod
if @@ERROR > 0 begin
rollback
return -1
end else begin
commit
return 1
end
end
GO
/****** Object:  Trigger [dbo].[trig_ObrisiPreuzeto]    Script Date: 6/10/2020 6:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[trig_ObrisiPreuzeto] on [dbo].[Preuzeto]
after DELETE as
begin
declare @username nvarchar(30)
declare @id_narudzbina nvarchar(30)
declare @vreme_Preuzimanja datetime

select @username = username, @id_narudzbina = id_narudzbina, @vreme_Preuzimanja = datum_preuzeto  FROM deleted
print @username
print  @id_narudzbina

INSERT INTO Isporuceno(id_isporuceno,username,ime,prezime,adresa,id_kolicina,preuzeto,vreme_Preuzimanja,vreme_Predaje)
select id_narudzbina as id_isporuceno,@username,ime,prezime,adresa,id_kolicina,preuzeto,@vreme_Preuzimanja,GETDATE() as vreme_Predaje
from Narudzbina where id_narudzbina = @id_narudzbina

DELETE FROM Narudzbina where id_narudzbina = @id_narudzbina

end
GO
ALTER TABLE [dbo].[Preuzeto] ENABLE TRIGGER [trig_ObrisiPreuzeto]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Zaposleni"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Isporuceno"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 438
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_Isporuceno'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_Isporuceno'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Narudzbina"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Narudzbina'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Narudzbina'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Preuzeto"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 213
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Narudzbina"
            Begin Extent = 
               Top = 6
               Left = 251
               Bottom = 136
               Right = 421
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_PreuzeteNarudzbine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_PreuzeteNarudzbine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Zaposleni"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Zaposleni'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Zaposleni'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Zaposleni"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Zaposleni_i_Otpusteni'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Zaposleni_i_Otpusteni'
GO
