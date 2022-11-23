-- GROUP BY: select sorgular�nda ihtiyaca g�re bir veya daha fazla s�tun gruplanarak
-- gruplanan s�tun ile birlikte say�sal veri tipindeki di�er bir veya daha fazla s�tun
-- �zerinde SUM, MIN, MAX, AVG ve COUNT aggregate function'lar� �al��t�r�labilir.
-- Tarih tipindeki veriler i�in de MAX, MIN ve COUNT aggregate function'lar� �al��t�r�labilir.
-- Aggregate function'larla kullan�lan s�tunlar d���nda select yan�na yaz�lan t�m s�tunlar
-- group by'dan sonra yaz�lmal�d�r.

-- 1) COUNT: Gruplanan s�tun veya s�tunlara g�re kay�t say�s�n� ba�ka bir s�tunda getirir.
use Filmler
select yapimyili, COUNT(*) sayi from Film group by yapimyili
-- Yap�m y�l�na g�re film say�s�n� getiren sorgu.

-- group by join sorgular�ndan sonra da kullan�labilir.
-- count(*) genelde kay�t say�s�n� getirmek i�in kullan�l�r ancak null verilerin say�l�p say�lmayaca��na g�re
-- count(s�tun ad�) da kullan�labilir.
select y.adi, y.soyadi, count(f.Id) filmsayisi
from Yonetmen y inner join Film f on y.Id = f.yonetmenId
group by y.adi, y.soyadi
-- �rne�imizde her bir y�netmen i�in bir film kayd� olu�turdu�umuzdan her bir y�netmen i�in film say�s� 1 olarak gelecektir.

-- HAVING: group by'dan sonra herhangi bir aggregate function (COUNT, SUM, MIN, MAX, AVG) kullan�lan s�tun �zerinden 
-- filtreleme yap�lmas�n� sa�lar.
select y.adi, y.soyadi, count(f.Id) filmsayisi
from Yonetmen y inner join Film f on y.Id = f.yonetmenId
group by y.adi, y.soyadi
having count(f.Id) > 1
-- �rne�imizde her bir y�netmen i�in bir film kayd� olu�turdu�umuzdan her bir y�netmen i�in film say�s� 1 olarak gelecektir,
-- bu y�zden having filtresi ile kay�t say�s� 1'den b�y�k olan kay�tlar� getir dedi�imizden sonu� d�nmeyecektir.

select t.adi as turadi, count(*) filmsayisi 
from tur t inner join filmtur ft on t.Id = ft.turId
inner join film f on ft.filmId = f.Id
group by t.adi
-- T�r ad�na g�re film say�s�n� getiren sorgu.

-- 2) SUM: Gruplanan s�tun veya s�tunlara g�re ba�ka bir s�tunun toplam sonucunun hesaplanmas� i�in kullan�l�r.
select f.yapimyili, sum(f.gisesi) as toplamgise, sum(fd.maliyeti) as toplammaliyet from Film f left outer join FilmDetay fd on f.Id = fd.FilmId
group by f.yapimyili
-- Yap�m y�l�na g�re filmlerin toplam gi�esini ve maliyetini getiren sorgu.

select t.adi as turadi, sum(f.gisesi) as filmtoplamgise 
from tur t left outer join filmtur ft on t.Id = ft.turId
left outer join film f on ft.filmId = f.Id
group by t.adi
having sum(f.gisesi) >= 1000000.00 and sum(f.gisesi) <= 2000000.00
-- T�r ad�na g�re filmlerin toplam gi�elerini 1000000 ile 2000000 aras�nda olacak �ekilde filtreleyerek getiren sorgu.

-- 3) MAX: Gruplanan s�tun veya s�tunlara g�re ba�ka bir s�tunun maksimum sonucunun hesaplanmas� i�in kullan�l�r.
select emeklimi, max(dogumtarihi) maksimumdogumtarihi from yonetmen where emeklimi is not null group by emeklimi
-- Y�netmen tablosunda emekli verisi null olmayan kay�tlar �zerinden emeklimi s�tununa g�re gruplama yap ve 
-- bu gruplamaya g�re maksimum emeklilik tarihlerini getir.

-- 4) MIN: Gruplanan s�tun veya s�tunlara g�re ba�ka bir s�tunun minimum sonucunun hesaplanmas� i�in kullan�l�r.
select yapimyili Yap�mY�l�, min(gisesi) Gi�esi from film group by yapimyili having yapimyili < 2000
-- Film tablosunda yap�m y�l�na g�re minimum gi�eye sahip filmlerin yap�m y�l� ve gi�elerini 2000 y�l�ndan �ncesi olarak getirir.

-- 5) AVG: Gruplanan s�tun veya s�tunlara g�re ba�ka bir s�tunun ortalama sonucunun hesaplanmas� i�in kullan�l�r.
select t.Id as turid, t.adi as turadi, AVG(f.gisesi) as filmortalamagise 
from tur t inner join filmtur ft on t.Id = ft.turId
inner join film f on ft.filmId = f.Id
where t.Id in (2, 3, 4) -- bilim kurgu, aksiyon, dram
group by t.Id, t.adi
-- T�r� bilim kurgu, aksiyon ve dram olan film t�r join sorgusu sonucu �zerinden t�r id ve t�r ad� s�tunlar�na 
-- g�re gruplama yaparak film gi�elerinin ortalama sonucunu getirir.