-- VIEW: E�er istenirse herhangi bir select sonucu veritaban�nda dinamik bir g�r�n�mde saklanabilir ve
-- bu g�r�n�m �zerinden select yap�larak �zellikle join ve group by sorgular�n�n tekrar tekrar yaz�lmas�n�n �n�ne ge�ilir.

use Filmler

-- Film, Yonetmen ve Tur tablolar�n� inner join ile birle�tirelim ve vFilmTurYonetmen adl� view'da sorguyu saklayal�m:
-- A�a��daki �rnekte create view'�n ba��ndan itibaren sorgu se�ilerek �al��t�r�lmal�d�r 
-- ��nk� create view sorgusu her zaman ilk sat�r olarak �al��t�r�lmal�d�r.
create view vFilmTurYonetmen
as
select f.Id as [Film ID], f.adi as [Film Ad�], f.yapimyili as [Film Yap�m Y�l�], f.gisesi as [Film Gi�esi],
y.Id as [Y�netmen ID], y.adi + ' ' + y.soyadi as [Y�netmen], y.dogumtarihi as [Y�netmen Do�um Tarihi], t.adi as [T�r]
from Film f inner join Yonetmen y on f.yonetmenId = y.Id
inner join FilmTur ft on f.Id = ft.filmId
inner join Tur t on ft.turId = t.Id

-- vFilmTurYonetmen view'�n� olu�turduktan sonra istedi�imiz zaman a�a��daki gibi view i�erisindeki 
-- sorgu �zerinden sorgulama yapabiliriz. Ayr�ca bu view �zerinden where, group by ve order by da kullanabiliriz. 
select * from vFilmTurYonetmen where [Film Yap�m Y�l�] is not null order by [Film Ad�]

-- �stenirse bir view'�n sorgusu alter ile de�i�tirilebilir:
-- A�a��daki �rnekte sorgudan film id'sini ��kard�k. 
-- alter view da create view gibi ilk sat�r olarak �al��t�r�lmal�d�r.
alter view vFilmTurYonetmen
as
select f.adi as [Film Ad�], f.yapimyili as [Film Yap�m Y�l�], f.gisesi as [Film Gi�esi],
y.Id as [Y�netmen ID], y.adi + ' ' + y.soyadi as [Y�netmen], y.dogumtarihi as [Y�netmen Do�um Tarihi], t.adi as [T�r]
from Film f inner join Yonetmen y on f.yonetmenId = y.Id
inner join FilmTur ft on f.Id = ft.filmId
inner join Tur t on ft.turId = t.Id

-- �stenirse bir view drop ile silinebilir:
drop view vFilmTurYonetmen