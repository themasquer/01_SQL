-- JOIN: �ki veya daha fazla tablonun verilerini birle�tirerek tek bir tabloymu� gibi sonu� olarak getirmemizi sa�lar.
-- Join sorgular�nda bir tablonun primary key s�tunu ile di�er tablodaki foreign key kar��l��� olan s�tun e�itlenir.

-- 1) INNER JOIN: Birle�tirilen tablolarda sadece id'ler �zerinden e�le�en kay�tlar� getirir.
-- Kullan�m: select s�tunlar from tablo1 inner join tablo2 on tablo1.tablo2id = tablo2.id
-- A�a��daki �rnekte hem s�tun adlar� hem de tablo adlar� alias kullan�larak sorguda de�i�tirilmi�tir.
-- �rne�in Film tablosu f olarak k�salt�lm��t�r, f.id s�tunu ise Film ID olarak sorguda de�i�tirilmi�tir.

use Filmler

-- Film ve Yonetmen tablolar�n� inner join ile birle�tirelim: * ile birle�tirilen tablolardaki t�m s�tunlar d�ner.
-- Sorgu sonucunda 5 sat�r d�ner.
select *
from Film f inner join Yonetmen y on f.yonetmenId = y.Id

-- Film, Yonetmen ve Tur tablolar�n� inner join ile birle�tirelim:
-- Join sorgular�ndan sonra where kullan�larak kay�tlar filtrelenebilir, order by ile de s�ralanabilir.
-- T�r� Aksiyon, film gi�esi de 50000 ile 700000 aras�nda olan kay�tlar� film yap�m y�l�na g�re artan s�ralayarak getir.
select f.Id as [Film ID], f.adi as [Film Ad�], f.yapimyili as [Film Yap�m Y�l�], f.gisesi as [Film Gi�esi],
y.Id as [Y�netmen ID], y.adi + ' ' + y.soyadi as [Y�netmen], y.dogumtarihi as [Y�netmen Do�um Tarihi], t.adi as [T�r]
from Film f inner join Yonetmen y on f.yonetmenId = y.Id
inner join FilmTur ft on f.Id = ft.filmId
inner join Tur t on ft.turId = t.Id
where t.adi = 'Aksiyon' and f.gisesi >= 50000 and f.gisesi <= 700000
order by f.yapimyili

-- Inner join ile birle�tirilen Film, Yonetmen ve Tur tablolar� �zerinden film ad� ve y�netmen ad� ile soyad�n� birle�tirerek
-- getir ve �oklayan sat�rlar� teke d���r.
select distinct f.adi as [Film], y.adi + ' ' + y.soyadi as [Y�netmen]
from Film f inner join Yonetmen y on f.yonetmenId = y.Id
inner join FilmTur ft on f.Id = ft.filmId
inner join Tur t on ft.turId = t.Id

-- 2) LEFT OUTER JOIN: Birle�tirilen tablolarda hem id'ler �zerinden e�le�en kay�tlar� hem de tablolar�n yaz�m s�ras�na g�re
-- soldaki tablonun t�m kay�tlar� ile sa�daki tabloda e�le�meyen kar��l�klar� null olacak �ekilde getirir.
-- Kullan�m: select s�tunlar from tablo1 left outer join tablo2 on tablo1.tablo2id = tablo2.id

-- Film, FilmDetay ve Yonetmen tablolar�n� left outer join ile birle�tirelim:
-- A�a��daki sorgu sonucunda Avatar filminin y�netmen id'si null
-- oldu�u i�in y�netmen tablosundan �ekilen Y�netmen ID, Y�netmen ve Y�netmen Do�um Tarihi verileri null gelecektir.
-- Dolays�yla join kullan�larak soldaki tablonun t�m verileri getirilmek isteniyorsa
-- ve sa�daki tabloda kay�tlar e�le�se de e�le�mese de gelsin isteniyorsa left outer join kullan�lmal�d�r.
-- Ayn� durum FilmDetay tablosu i�in de ge�erlidir.
-- Sorgu sonucunda 6 sat�r d�ner.
select f.Id as [Film ID], f.adi as [Film Ad�], f.yapimyili as [Film Yap�m Y�l�], f.gisesi as [Film Gi�esi],
fd.Maliyeti, fd.Aciklamasi as A��klamas�,
y.Id as [Y�netmen ID], y.adi + ' ' + y.soyadi as [Y�netmen], y.dogumtarihi as [Y�netmen Do�um Tarihi]
from Film f left outer join FilmDetay fd on f.Id = fd.FilmId left outer join Yonetmen y on f.yonetmenId = y.Id

-- Film, Yonetmen ve Tur tablolar�n� left outer join ile birle�tirelim:
-- A�a��daki sorgu sonucunda Adalet Pe�inde filminin herhangi bir film t�r kayd� 
-- olmad��� i�in t�r tablosundan �ekilen T�r verisi null olarak gelecektir,
-- Avatar filminin de y�netmen id'si null oldu�u i�in y�netmen tablosundan �ekilen 
-- Y�netmen ID, Y�netmen ve Y�netmen Do�um Tarihi verileri null olarak gelecektir.
select f.Id as [Film ID], f.adi as [Film Ad�], f.yapimyili as [Film Yap�m Y�l�], f.gisesi as [Film Gi�esi],
y.Id as [Y�netmen ID], y.adi + ' ' + y.soyadi as [Y�netmen], y.dogumtarihi as [Y�netmen Do�um Tarihi],
t.adi as [T�r]
from Film f left outer join Yonetmen y on f.yonetmenId = y.Id
left outer join FilmTur ft on f.Id = ft.filmId
left outer join Tur t on ft.turId = t.Id
order by f.adi -- film ad�na g�re artan s�ralama

-- 3) RIGHT OUTER JOIN: Birle�tirilen tablolarda hem id'ler �zerinden e�le�en kay�tlar� hem de tablolar�n yaz�m s�ras�na g�re
-- sa�daki tablonun t�m kay�tlar� ile soldaki tabloda e�le�meyen kar��l�klar� null olacak �ekilde getirir.
-- Kullan�m: select s�tunlar from tablo1 right outer join tablo2 on tablo1.tablo2id = tablo2.id

-- Film, FilmDetay ve Yonetmen tablolar�n� right outer join ile birle�tirelim:
-- A�a��daki sorgu sonucunda Avatar filminin y�netmen id'si null
-- oldu�u i�in y�netmen tablosundan �ekilen Y�netmen ID, Y�netmen ve Y�netmen Do�um Tarihi verileri null gelecektir.
-- Dolays�yla join kullan�larak sa�daki tablonun t�m verileri getirilmek isteniyorsa
-- ve soldaki tabloda kay�tlar e�le�se de e�le�mese de gelsin isteniyorsa right outer join kullan�lmal�d�r.
-- Ayn� durum FilmDetay tablosu i�in de ge�erlidir.
-- Sorgu sonucunda 6 sat�r d�ner.
select f.Id as [Film ID], f.adi as [Film Ad�], f.yapimyili as [Film Yap�m Y�l�], f.gisesi as [Film Gi�esi],
fd.Maliyeti, fd.Aciklamasi as A��klamas�,
y.Id as [Y�netmen ID], y.adi + ' ' + y.soyadi as [Y�netmen], y.dogumtarihi as [Y�netmen Do�um Tarihi]
from Yonetmen y right outer join Film f on y.Id = f.yonetmenId right outer join FilmDetay fd on f.Id = fd.FilmId

-- Film, Yonetmen ve Tur tablolar�n� right outer join ile birle�tirelim:
-- A�a��daki sorgu sonucunda Adalet Pe�inde filminin herhangi bir film t�r kayd� 
-- olmad��� i�in t�r tablosundan �ekilen T�r verisi null olarak gelecektir.
select f.Id as [Film ID], f.adi as [Film Ad�], f.yapimyili as [Film Yap�m Y�l�], f.gisesi as [Film Gi�esi],
y.Id as [Y�netmen ID], y.adi + ' ' + y.soyadi as [Y�netmen], y.dogumtarihi as [Y�netmen Do�um Tarihi],
t.adi as [T�r]
from Tur t right outer join FilmTur ft on t.Id = ft.turId
right outer join Film f on ft.filmId = f.Id
right outer join Yonetmen y on f.yonetmenId = y.Id
order by f.adi -- film ad�na g�re artan s�ralama

-- Sorgulanmak istenen veriye g�re bazen inner join, left outer join ve right outer join ayn� sorguda kullan�labilir.