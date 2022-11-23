-- SQL: Structured Query Language: Veritaban�nda sorgular �zerinden veritaban� i�lemleri yapabildi�imiz dildir.
-- T-SQL: Transact Structured Query Language: Microsoft SQL Server'�n kulland��� �zelle�tirilmi� SQL'dir.

-- T-SQL'de yorum sat�rlar� -- ... ile ... olan yer i�in tek sat�r olarak veya /* ... */ ile ... olan yer i�in birden �ok
-- sat�r �eklinde yaz�l�r.

-- DATA DEFINITION LANGUAGE (DDL): Veritaban�nda veriyi saklad���m�z veya kulland���m�z yap�lar� olu�turmak, de�i�tirmek 
-- veya silmek i�in kullan�l�r.

-- �rnek olarak database (veritaban�), table (tablo), column(s�tun) ve view'ler (dinamik g�r�n�mler) i�in 
-- DDL sorgular� �al��t�r�labilir.

-- DDL sorgular� kullan�lmadan da Microsoft SQL Server design sayfalar� �zerinden veritaban�, tablo, tablolar aras� ili�kiler
-- vb. i�lemleri yap�labilir.

-- master: Sunucudaki veritabanlar�m�z�n yap�lar�yla ilgili verilerin sakland��� veritaban�d�r.

-- �ki �al��t�r�lan SQL sorgusu aras�na go konularak mutlaka birincinin i�leminin bitmesi sa�lanabilir, daha sonra di�eri �al���r.

-- Yeni bir veritaban� olu�turulurken �nce master veritaban� �zerinden olu�turuca��m�z veritaban� (Filmler) var m� kontrol� yap�l�r,
-- e�er varsa bu veritaban� drop database Filmler sorgusu ile silinir.

-- create database Filmler ile yeni veritaban� olu�turulur.

-- use Filmler ile Filmler veritaban�n�n kullan�lmas� sa�lan�r, sonras�nda sorgular Filmler veritaban� �zerinde �al��acakt�r.

-- create table Film ile yeni tablo olu�turulur. Bu tablo Yonetmen ile 1 to many, Tur ile many to many ili�kilidir.

-- primary key (birincil anahtar): Bir tablodaki her bir sat�rda tan�mland��� s�tun i�in tekil veri tutulmas�n� sa�lar.

-- identity(1, 1): identity ile bu verinin soldaki 1 de�eri ile 1'den ba�lamas�, sa�daki 1 de�eri ile de birer birer artmas� sa�lan�r.
-- E�er veritaban�n�n bu veriyi otomatik artt�rmas� istenmiyorsa identity(1, 1) yazmaya gerek yoktur.

-- foreign key (yabanc�l anahtar): Bir tabloya ili�kili oldu�u ba�ka tablodan ta��nan ve ta��nd��� tabloda primary key olan s�tundur.

-- bigint, int, smallint, tinyint ve bit saklayabildikleri de�erler bak�m�ndan b�y�kten k����e do�ru tam say� verilerinin 
-- tutulmas� i�in kullan�lan veri tipleridir.

-- varchar, char ve text metinsel verilerin tutulmas� i�in kullan�lan veri tipleridir.

-- varchar(uzunluk) ve char(uzunluk) ile parantez i�inde maksimum ka� karakter metinsel veri tutulabilece�i yani uzunluk belirtilir.
-- varchar(max) ve char(max) ile SQL Server'da tan�ml� olan ve versiyonlara g�re de�i�en maksimum karakter say�s� tan�mlanabilir.
-- text i�in max tan�mlamaya gerek yoktur, bu veri tipi �ok b�y�k metinsel verilerin tutulmas� i�in kullan�l�r.

-- Tutulan varchar verisinin uzunlu�u girilen veriye g�re de�i�irken char verinin uzunlu�u sabittir, 
-- veri girilmeyen karakterler bo�luk olarak tutulur.

-- E�er veritaban�n�n collation'� (verileri saklamak i�in kulland��� dil) T�rk�e (TURKISH_CI_AS) olarak tan�mlanmam��sa metinsel
-- veri tiplerinin ba��na n konularak (nvarchar, nchar, ntext) bu verilerin unicode karakter k�mesi kullan�larak saklanmas� 
-- sa�lan�r ki T�rk�e veriler i�in bir sorun olmas�n. Bu �ekilde tan�mlanan s�tunlara veri girilirken de ba��na N eklenir.

-- null: Veri giri�i yap�lan s�tunda hi� bir verinin saklanmamas� i�in kullan�l�r, �zel bir bo� veri olarak d���n�lebilir.

-- Ondal�k veriler i�in genel olarak float veri tipi kullan�l�r.

-- Ondal�k say�larda tam k�s�m ile ondal�kl� k�s�m �zelle�tirmeleri i�in decimal veri tipi kullan�labilir.
-- �rne�in decimal(9, 2) bize say�n�n nokta ile beraber 9 hane olaca��n�, 2 ise noktadan sonraki hane say�s�n� belirtir.

-- Para verisi de ondal�k say� oldu�undan money veri tipi ile �zelle�tirilmi� ve kullan�m�m�za sunulmu�tur.

-- Tarih verilerinde sadece tarih i�in date veri tipi, tarih ve saat i�inse datetime veri tipi tan�mlanabilir.
-- T-SQL tarih format�: y�l-ay-g�n saat:dakika:saniye.milisaniye (�rnek: 2021-09-07 17:25:50.123)

-- Metinsel olmayan yani ikilik sistemde olu�turulmu� imaj gibi veriler image, varbinary(uzunluk) veya binary(uzunluk) veri tipleriyle saklanabilir.

-- alter komutu veritaban� dahil herhangi bir veritaban� yap�s�n�n de�i�tirilmesi i�in kullan�l�r.
-- �rne�in database, table, column ve view'ler i�in kullan�labilir.

-- drop komutu veritaban� dahil herhangi bir veritaban� yap�s�n�n silinmesi i�in kullan�l�r.
-- �rne�in database, table, column ve view'ler i�in kullan�labilir.

use master
go
if exists (select name from sys.databases where name = 'Filmler')
begin
	alter database Filmler set single_user with rollback immediate -- veritaban� ba�lant�s�n� koparmak i�in �zel sorgu
	drop database Filmler -- veritaban�n� silen esas sorgu
end
go
create database Filmler
go
use Filmler
go
create table Film -- Yonetmen ile 1 to many tablosu, Tur ile many to many tablosu, FilmDetay ile 1 to 1 tablosu
(
	Id int primary key identity(1, 1), -- 1. primary key tan�mlama y�ntemi
	Adi varchar(300) not null,
	YapimYili char(4),
	YonetmenId int null, -- null: Herhangi bir filmin y�netmeni olmayabilir, not null: Her filmin bir y�netmeni olmal�d�r.
						 -- Yonetmen tablosundan ta��nd��� i�in foreign key'dir.
						 -- E�er s�tunda null verilere izin verilecekse null yazmaya gerek yoktur.
	Gisesi money,
	HataliSutun int -- �rnek i�in silinecek s�tun
)
create table FilmDetay -- Film ile 1 to 1 tablosu
(
	FilmId int primary key,
	Maliyeti decimal(9, 2) not null,
	Aciklamasi varchar(MAX)
)
create table Yonetmen
(
	Id int primary key identity(1, 1),
	Adi varchar(50) not null,
	Soyadi varchar(50) not null,
	DogumTarihi date,
	EmekliMi bit
)
create table Tur
(
	Id int primary key identity(1, 1),
	Adi varchar(1) -- �rnek i�in d�zeltilecek s�tun
)
create table FilmTur -- Film ve Tur i�in many to many tablosu
(
	FilmId int not null, -- Film tablosundan ta��nd��� i�in foreign key'dir.
	TurId int not null, -- Tur tablosundan ta��nd��� i�in foreign key'dir.
	constraint PK_FilmTur PRIMARY KEY (FilmId, TurId) -- 2. primary key tan�mlama y�ntemi, 
													  -- burada oldu�u gibi birden �ok s�tun primary key olarak tan�mlanabilir.
)
create table Hatalitablo -- �rnek i�in silinecek tablo
(
	Id int primary key
)

alter table Tur alter column Adi varchar(25) not null -- �rnek i�in Tur tablosundaki adi s�tununun veri tipini 
												      -- null girilemeyecek �ekilde varchar(25) olarak de�i�tiriyoruz.
alter table Film drop column HataliSutun -- �rnek i�in Film tablosundaki hatal� s�tunu siliyoruz.

drop table Hatalitablo -- �rnek i�in hatal� olu�turdu�umuz tabloyu siliyoruz.

-- Tablolar aras� ili�kiler:

-- Film ile Yonetmen aras�ndaki 1 to many ili�ki i�in Film tablosuna bir foreign key constraint (k�s�tlama) ekleyerek
-- bu constraint'in Film tablosundaki yonetmenid ile Yonetmen tablosundaki id s�tunlar� i�in oldu�unu belirtiyoruz.
alter table Film add constraint FK_Film_Yonetmen foreign key (YonetmenId) references Yonetmen(Id)

-- Dolay�s�yla Film ile Yonetmen tablolar� aras�nda 1 to many ili�ki olu�turmu� oluyoruz.

-- Film ile FilmTur aras�ndaki 1 to many ili�ki i�in FilmTur tablosuna bir foreign key constraint ekleyerek
-- bu constraint'in FilmTur tablosundaki filmid ile Film tablosundaki id s�tunlar� i�in oldu�unu belirtiyoruz.
alter table FilmTur add constraint FK_FilmTur_Film foreign key (FilmId) references Film(Id)

-- Tur ile FilmTur aras�ndaki 1 to many ili�ki i�in FilmTur tablosuna bir foreign key constraint ekleyerek
-- bu constraint'in FilmTur tablosundaki turid ile Tur tablosundaki id s�tunlar� i�in oldu�unu belirtiyoruz.
alter table FilmTur add constraint FK_FilmTur_Tur foreign key (TurId) references Tur(Id)

-- Dolay�s�yla Film ile Tur tablolar� aras�nda many to many ili�ki olu�turmu� oluyoruz.

-- Film ile FilmDetay aras�ndaki 1 to 1 ili�ki i�in FilmDetay tablosuna bir foreign key constraint ekleyerek
-- bu constraint'in Film tablosundaki id ile FilmDetay tablosundaki filmid s�tunlar� i�in oldu�unu belirtiyoruz.
alter table FilmDetay add constraint FK_FilmDetay_Film foreign key (FilmId) references Film(Id)