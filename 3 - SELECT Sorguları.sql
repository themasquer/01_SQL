-- SELECT: Bir veritaban�ndaki bir veya daha fazla tablo �zerinden veri sorgulamak ve getirmek i�in kullan�l�r.

use Filmler -- Filmler veritaban�n� kullan

-- *: t�m s�tunlar, select: nelerin d�nece�i, from: hangi tablodan
select * from Film

select Id, adi, yapimyili, yonetmenId, gisesi from Film

-- SQL sorgular�nda sadece ihtiyac�m�z olan s�tunlar� getirmekte fayda var.

-- select ile getirilen bir s�tun ad� as veya as kullanmadan ge�ici olarak de�i�tirilebilir (alias). Bu i�leme aliasing denir.
-- S�tunlara alias tan�mlayabildi�imiz gibi alias'lar� tablolara da tan�mlayabiliriz, yani sorguda kulland���m�z
-- isimlerini ge�ici olarak de�i�tirebiliriz.
-- E�er arada bo�luk karakteri ile alias tan�mlanmak isteniyorsa [] aras�na s�tun ad� yaz�lmal�d�r.
select Id as [Film ID], adi as [Film Adi], yapimyili [Yapim Yili], yonetmenId YonetmenID, gisesi [Gisesi] from Film

-- SQL'de metinsel ifadeler tek t�rnakla ifade edilir. Burada adi ile soyadi s�tunlar�n� arada bo�luk ile 
-- birle�tiriyoruz (concatenation), yonetmenadisoyadi isimli bir s�tuna alias vererek dogumtarihi ile birlikte �ekiyoruz.
select adi + ' ' + soyadi as yonetmenadisoyadi, dogumtarihi from Yonetmen

-- select ile �ekilen veriler bir veya birden �ok s�tun �zerinden order by kullan�larak s�ralanabilir. 
-- order by ile asc, ascending yani artan veya desc, descending yani azalan s�ralama yap�labilir.
-- Default'u yani yaz�lmad���nda varsay�lan� ascending (asc)'dir.
select * from Yonetmen order by adi -- artan s�ralama
select * from Yonetmen order by adi desc -- azalan s�ralama

select * from Yonetmen order by adi, soyadi 
-- �nce adi s�tununa g�re artan s�ralama yapar, sonra adi s�tununa g�re s�ralad�klar�n� soyadi s�tununa g�re artan s�ralar.

select * from Yonetmen order by adi, soyadi desc
-- �nce adi s�tununa g�re artan s�ralama yapar, sonra adi s�tununa g�re s�ralad�klar�n� soyadi s�tununa g�re azalan s�ralar.

-- Bir tablodaki kay�t (sat�r) say�s�n� getirmek i�in SQL'in count fonksiyonu kullan�l�r.
select COUNT(*) from Film
select COUNT(adi) as toplamfilm from Film -- count(*) yerine count(s�tun ad�) da kullan�labilir.
select COUNT(dogumtarihi) from Yonetmen -- count(s�tun ad�): NULL olanlar� saymaz.

-- Bir tablodaki say�sal veri tipindeki bir s�tunun maksimum de�eri max fonksiyonu ile getirilebilir.
select MAX(gisesi) as [En Cok Gise] from Film -- MAX(s�tun ad�): o s�tundaki verilerden en b�y�k de�eri ver.

-- Bir tablodaki say�sal veri tipindeki bir s�tunun minimum de�eri min fonksiyonu ile getirilebilir.
select MIN(gisesi) as [En Az Gise] from Film -- MIN(s�tun ad�): o s�tundaki verilerden en k���k de�eri ver.

-- Bir tablodaki say�sal veri tipindeki bir s�tunun verilerinin toplam� sum fonksiyonu ile getirilebilir.
select SUM(gisesi) as [Toplam Gise] from Film -- SUM(s�tun ad�): o s�tundaki verilerin toplam�n� ver.

-- Bir tablodaki say�sal veri tipindeki bir s�tunun verilerinin ortalamas� avg fonksiyonu ile getirilebilir.
select AVG(gisesi) as [Ortalama Gise] from Film -- AVG(s�tun ad�): o s�tundaki verilerin ortalama de�erini ver.

-- Bir tablodaki veriler top ile s�ralamaya g�re ba�tan ka� kay�t �ekilece�i belirtilerek getirilebilir.
select top 3 * from Yonetmen -- TOP say� s�tun ad�: ilk �� kayd� getirir.

select top 3 * from Yonetmen order by Id desc -- order by desc'den dolay� son �� kayd� getirir.

select top 1 * from Film order by Id -- film tablosundaki ilk kayd� getirir.
select top 1 * from Film order by Id desc -- film tablosundaki son kayd� getirir.

-- E�er ba�ka bir veritaban� �zerinden �al���l�yorsa, �rne�in master, Filmler veritaban�ndaki Film tablosuna
-- veritaban�.dbo.tablo �eklinde ula��labilir, dbo tablonun �emas�d�r (schema).
use master
select * from Filmler.dbo.Film

-- WHERE: Sorgu i�in ko�ul (�art) veya ko�ullar (�artlar) belirtmek i�in kullan�l�r. Belirtilen ko�ul veya ko�ullara uyan sat�rlar etkilenir.
-- Update, delete ve select sorgular�nda kullan�l�r. Birden �ok ko�ul i�in and (ve) ile or (veya) operat�rleri kullan�labilir.
-- Bir ko�ulun de�ilini almak i�in de not operat�r� kullan�l�r.
-- Where ko�ulundaki s�tunlar ile =, !=, >, <, >= ve <= operat�rleri kullan�labilir.

use Filmler
select * from Film where Id = 5 -- id'si 5 olan filmi getir.
select * from Film where Id != 5 -- id'si 5 olmayan filmleri getir.
select * from Film where not Id = 5 -- id'si 5 olmayan filmleri getir.
select * from Film where Id < 4 order by Id desc -- id'si 4'ten k���k olan filmleri id'ye g�re azalan �ekilde getir.
select * from Film where Id > 4 -- id'si 4'ten b�y�k olan filmleri id'ye g�re artan �ekilde getir.

-- id'ye g�re artan s�ralama i�in order by id yazmaya gerek yoktur 
-- ��nk� id primary key ve index oldu�undan otomatikman id'ye g�re artan s�ral� gelir.

select * from Yonetmen where Id >= 2 and Id <= 4 -- id'si 2 ile 2'den b�y�k ve 4 ile 4'den k���k y�netmenleri getir.

-- id'si 2'den k���k veya 4'ten b�y�k y�netmenleri getir.
select * from Yonetmen where Id < 2 or Id > 4 -- 1. sorgu
select * from Yonetmen where not (Id >= 2 and Id <= 4) -- 2. sorgu
-- �stteki iki sorgu ayn� sonucu verir ��nk� 1. sorgu 2. sorgunun de�il operat�r� parantez i�erisindeki ko�ullara da��t�lm�� halidir.

-- WHERE ile birden �ok ko�ul kullan�m�:
-- A�a��daki sorgularda parantez i�inde Ko�ul 1 ve Ko�ul 2, parantez d���nda da and'den sonra aranan veriler yaz�lm��t�r.

select Id from Yonetmen where (Id >= 2 and Id <= 4)

select Id from Yonetmen where (Id >= 2 and Id <= 4) and Id = 2 -- *
select Id from Yonetmen where (Id >= 2 and Id <= 4) and Id = 3 -- *
select Id from Yonetmen where (Id >= 2 and Id <= 4) and Id = 4 -- *

select Id from Yonetmen where (Id >= 2 and Id <= 4) and Id = 5 -- **

select Id from Yonetmen where (Id >= 2 and Id <= 4) and Id = 1 -- ***

select Id from Yonetmen where (Id > 4 and Id < 2) and Id = 3 -- ****

/*
Ko�ul 1 		and			Ko�ul 2				Sonu� Ko�ulu		Yonetmen Tablosunda Aranan Veriler (id)		Yonetmen Tablosundan D�nen Sonu� Verileri (id)
id >= 2						id <= 4
1 (true)					1 (true)			1 (true)			2, 3, 4	*									2, 3, 4
1 (true)					0 (false)			0 (false)			5 **										Veri d�nmez
0 (false)					1 (true)			0 (false)			1 ***										Veri d�nmez
id > 4						id < 2
0 (false)					0 (false)			0 (false)			3 ****										Veri d�nmez
*/

select Id from Yonetmen where (Id >= 2 or Id <= 4)

select Id from Yonetmen where (Id >= 2 or Id <= 4) and Id = 2 -- *
select Id from Yonetmen where (Id >= 2 or Id <= 4) and Id = 3 -- *
select Id from Yonetmen where (Id >= 2 or Id <= 4) and Id = 4 -- *

select Id from Yonetmen where (Id >= 2 or Id <= 4) and Id = 5 -- **

select Id from Yonetmen where (Id >= 2 or Id <= 4) and Id = 1 -- ***

select Id from Yonetmen where (Id > 4 or Id < 2) and Id = 3 -- ****

/*
Ko�ul 1 		or			Ko�ul 2				Sonu� Ko�ulu		Yonetmen Tablosunda Aranan Veriler (id)		Yonetmen Tablosundan D�nen Sonu� Verileri (id)
id >= 2						id <= 4
1 (true)					1 (true)			1 (true)			2, 3, 4	*									2, 3, 4
1 (true)					0 (false)			1 (true)			5 **										5
0 (false)					1 (true)			1 (true)			1 ***										1
id > 4						id < 2
0 (false)					0 (false)			0 (false)			3 ****										Veri d�nmez
*/

-- SELECT sorgu �rnekleri:
select * from Yonetmen where adi = 'James' and soyadi = 'Cameron' and dogumtarihi = '1954-08-16'
-- ad� James ve soyad� Cameron ve do�um tarihi 06.08.1954 olan y�netmenleri getir.

-- E�er a�a��daki �rneklerde oldu�u gibi birden �ok and ve or operat�r� kullan�ld���nda
-- mutlaka �ncelikli ko�ul veya ko�ullar i�in parantez kullan�lmal�d�r.
select * from Yonetmen where (adi = 'James' and soyadi = 'Cameron') or adi = 'Ridley'
-- ad� James ve soyad� Cameron olan veya ad� Ridley olan y�netmenleri getir.

select * from Yonetmen where (adi = 'James' and soyadi = 'Cameron') or (adi = 'Ridley' and soyadi = 'Scott')
-- ad� James ve soyad� Cameron olan veya ad� Ridley ve soyad� Scott olan y�netmenleri getir.

select * from Yonetmen where ((adi = 'James' and soyadi = 'Cameron') or (adi = 'Ridley' and soyadi = 'Scott')) and dogumtarihi > '1950-01-01'
-- ad� James ve soyad� Cameron olan veya ad� Ridley ve soyad� Scott olan ve do�um tarihi 01.01.1950'den b�y�k olan y�netmenleri getir.

select * from Tur where Id = 1 or Id = 3 or Id = 5
select * from Tur where Id in (1, 3, 5)
-- in (de�erler): k�me i�erisinden se�im yapar, de�erleri parantez i�indeki parametreler olanlar� getir.
-- id'si 1 veya 3 veya 5 olan t�rleri getir.
-- id'si 1, 3, 5 k�mesi i�erisinde olan t�rleri getir.

select * from Tur where Id not in (1, 3, 5)
-- not in (de�erler): k�me d���ndan se�im yapar, de�erleri parantez d���ndaki parametreler olanlar� getir.
-- id'si 1 ve 3 ve 5 olmayan t�rleri getir.
-- id'si 1, 3, 5 k�mesi d���nda olan t�rleri getir.

select * from Tur where Id between 2 and 4
-- id'si 2 (dahil) ve 4 (dahil) aras�ndaki t�rleri getir.

select * from Film where yapimyili is NULL
-- yap�m y�l� null olan filmleri getir. where ko�ulunda yapimyili = null yaz�lmaz.

select * from Film where yapimyili is not null
-- yap�m y�l� null olmayan filmleri getir. where ko�ulunda yapimyili != null yaz�lmaz.

select * from Film where adi = 'avatar'
-- ad� avatar olan filmleri getir. 
-- Veritaban� collation'� TURKISH_CI_AS 
-- yani TURKISH: T�rk�e, CI: case insensitive, b�y�k k���k harf duyars�z ve AS: accent sensitive, aksan duyarl� (bizim i�in �nemsiz)
-- oldu�undan Avatar veya avatar ko�ulu ayn� sonucu d�ner.

select * from Film where adi like 'avatar'
-- i�erisinde tamamen avatar ge�en filmleri getir. adi = 'avatar' ile ayn� sonucu d�ner yani like = operat�r� gibi davran�r.

select * from Film where adi like 'a%'
-- ad� a ile ba�layan sonu ne olursa olsun filmleri getir. % yerine herhangi bir veya daha fazla karakter gelebilir demektir.

select * from Film where adi like '%ata%'
-- i�inde ata ge�en filmleri getir, ba�� ve sonu �nemli de�il. ata ba��nda veya sonunda ge�se de veri d�ner.

select * from Film where adi like '%ar'
-- sonu ar ile biten filmleri getir.

select * from Film where adi not like '%ar'
-- sonu ar ile bitmeyen filmleri getir.

select distinct yapimyili from Film where yapimyili is not null order by yapimyili desc
-- null olmayan yap�m y�llar�n� yap�m y�l�na g�re azalan s�rada �oklayan sat�rlar� teke d���rerek getir.

select '�a��l' + ' ' + 'Alsa�' Ad�Soyad�
-- �a��l Alsa� Ad�Soyad� s�tununu d�ner.
-- select her zaman bir tablo ile kullan�lmaz, istenilen veriler yaz�l�p ihtiyaca g�re �zerinde i�lemler yap�larak �ekilebilir.
-- Burada oldu�u gibi from ile herhangi bir tablo kullan�lmadan da select ile istenilen veri d�n�lebilir.

select 1 + 2 + 3 as Toplam
-- 6 Toplam s�tununu d�ner.

select adi, soyadi, 'Y�netmen' [Tablo Ad�] from yonetmen 
-- adi ve soyadi ile birlikte 'Y�netmen' metinsel verisini de tablo ad� olarak getir.
-- yonetmen: SQL sorgular�nda tablo adlar� ile s�tun adlar� b�y�k k���k harf duyars�z �ekilde yaz�labilir.
-- Ancak i harfine dikkat etmek gerekir. �rne�in e�er s�tun ad� Id tan�mland�ysa id ile select sorgusu yazmak hata verir.