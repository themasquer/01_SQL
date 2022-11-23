-- DATA MANIPULATION LANGUAGE (DML): Veritaban�nda Data Definition Language (DDL) ile olu�turdu�umuz yap�larda, 
-- �rne�in s�tunlar �zerinden tablolarda, yeni kay�t ekleme, mevcut bir kayd� g�ncelleme ve silme vb. veri i�lemleri i�in kullan�l�r.

-- SQL veri tipleri ve veri �rnekleri:
-- Say�sal veri tipleri (Tam say�):
-- 1 byte = 8 bit

-- bigint: 123
-- 64 bit b�y�kl���nde -9,223,372,036,854,775,808 ile 9,223,372,036,854,775,807 aras�nda de�er tutabilen tam say� veri tipidir.

-- int: -321
-- 32 bit b�y�kl���nde -2,147,483,648 ile 2,147,483,647 aras�nda de�er tutabilen tam say� veri tipidir.

-- smallint: -98
-- 16 bit b�y�kl���nde -32,768 ile 32,767 aras�nda de�er tutabilen tam say� veri tipidir.

-- tinyint: 89
-- 8 bit b�y�kl���nde 0 ile 255 aras�nda de�er tutabilen tam say� veri tipidir.

-- bit: 1
-- 8 bit b�y�kl���nde 0 ile 1 aras�nda de�er tutabilen tam say� veri tipidir.

-- Say�sal veri tipleri (Ondal�k say�):
-- float: 57.35
-- -1.79E+308 ile 1.79E+308 aras�nda de�er tutabilen ondal�k say� veri tipidir.

-- decimal(9, 2): -12345.6
-- -10^38 + 1 ile 10^38 - 1 aras�nda de�er tutabilen ondal�k say� veri tipidir.
-- Bu �rnekte 9 ondal�k i�areti dahil toplam maksimum hane say�s�n�, 2 ise ondal�k i�aretinden sonraki maksimum hane say�s�n� belirtir.

-- numeric (18, 3): 987654321.123
-- -10^38 + 1 ile 10^38 - 1 aras�nda de�er tutabilen ondal�k say� veri tipidir.
-- Bu �rnekte 18 ondal�k i�areti dahil toplam maksimum hane say�s�n�, 3 ise ondal�k i�aretinden sonraki maksimum hane say�s�n� belirtir.

-- money: 100.50
-- -922,337,203,685,477.5808 ile +922,337,203,685,477.5807 aras�nda de�er tutabilen ondal�k say� veri tipidir.

-- smallmoney: 100.50
-- -214,748.3648 ile +214,748.3647 aras�nda de�er tutabilen ondal�k say� veri tipidir.

-- Metinsel veri tipleri: Metinsel veriler i�in a�a��daki maksimum karakter say�lar� Microsoft SQL Server 2019 i�in ge�erlidir.
-- text: 'T�rkiye, �ankaya, Ankara'
-- Maksimum 2,147,483,647 karakter metinsel veri tutabilir. Tutulan verinin boyutu girilen karakter say�s�na g�re de�i�ir.

-- varchar(10): 'Bilge Adam'
-- varchar(max) ile maksimum 8000 karakter metinsel veri tutabilir. Tutulan verinin boyutu girilen karakter say�s�na g�re de�i�ir.

-- char(4): '2021'
-- char(max) ile maksimum 8000 karakter metinsel veri tutabilir. Tutulan verinin boyutu tan�mlanan karakter say�s� �zerinden sabittir.
-- Y�l verisi sabit 4 karakter oldu�u i�in char veri tipi kullan�labilir.
-- �rne�in sadece '1' verisini char(4) veri tipindeki bir s�tuna eklesek veri s�tunda '   1' olarak saklanacakt�r.

-- ntext: N'T�rkiye, �ankaya, Ankara'
-- Unicode karakter k�mesi kulland��� i�in (T�rk�e karakterler de bu veri k�mesine dahildir) 
-- maksimum 1,073,741,823 karakter metinsel veri tutabilir.

-- nvarchar(10): N'Bilge Adam'
-- Unicode karakter k�mesi kulland��� i�in nvarchar(max) ile maksimum 4000 karakter metinsel veri tutabilir.

-- nchar: N'2021'
-- Unicode karakter k�mesi kulland��� i�in nchar(max) ile maksimum 4000 karakter metinsel veri tutabilir.

-- Di�er veri tipleri:
-- datetime: '2021-09-08 18:55.44.135'
-- Ocak 1, 1753 ile	Aral�k 31, 9999 aras�nda 'y�l-ay-g�n saat:dakika:saniye.milisaniye' �zel format�nda de�er tutabilen veri tipidir.

-- smalldatetime: '2021-09-08 18:55.44.135'
-- Ocak 1, 1900 ile	Haziran 6, 2079 aras�nda 'y�l-ay-g�n saat:dakika:saniye.milisaniye' �zel format�nda de�er tutabilen veri tipidir.

-- date: '2021-09-08'
-- Ocak 1, 1753 ile	Aral�k 31, 9999 aras�nda 'y�l-ay-g�n' �zel format�nda de�er tutabilen veri tipidir.

-- binary: �rne�in binary(1000) olarak tan�mlan�r.
-- ��erisine ikilik say� sistemi yap�s�nda veri alabilir. Tutulan verinin boyutu tan�mlanan byte uzunlu�u �zerinden sabittir.
-- �rne�in imaj verisi, mp3 verisi, Word veya Excel d�k�man� verisi tutulabilir. 
-- binary(max) ile maksimum 8000 byte uzunlu�unda veri tutabilir.

-- varbinary: �rne�in varbinary(4000) olarak tan�mlan�r.
-- ��erisine binary gibi ikilik say� sistemi yap�s�nda veri alabilir. Tutulan verinin boyutu girilen verinin byte uzunlu�una g�re de�i�ir.
-- varbinary(max) ile maksimum 8000 byte uzunlu�unda veri tutabilir.

-- image:
-- Maksimum 2,147,483,647 byte uzunlu�unda veri tutabilen ve imaj verileri i�in kullan�lan �zel bir varbinary veri tipidir.

-- 1) INSERT: Bir tabloya s�tunlar �zerinden yeni bir sat�r olarak verileri eklemek i�in kullan�l�r.

-- Bir tabloya kay�t ekleme i�leminden �nce e�er tabloda foreign key varsa tablonun foreign key �zerinden ili�kili oldu�u 
-- di�er tabloya �nce veriler eklenir ki kay�t ekleme i�lemini yapt���m�z tablo foreign key �zerinden di�er tabloyla ili�ki kurabilsin.

use Filmler
go

-- 1. kullan�m: �stenilen s�tun adlar� values'dan �nce parantez i�inde belli bir s�rada yaz�l�r, de�erler ise values'dan sonra
-- ayn� s�rayla parantez i�inde girilir. Bu �rnekte dogumtarihi ve emeklimi s�tun verileri null girilecektir.
insert into Yonetmen (Adi, Soyadi, DogumTarihi, EmekliMi) values ('James', 'Cameron', '1954-08-16', 0) -- id otomatik olarak verilir: 1

-- 2. kullan�m: values'dan �nce parantez ile s�tun adlar� yaz�lmaz, de�erler ise values'dan sonra tablonun s�tunlar� s�ras�yla
-- parantez i�inde girilir. Bu kullan�mda e�er null de�ere izin veren bir s�tun varsa ve null de�er girilmek isteniyorsa
-- parantez i�inde a�a��daki �rnekte oldu�u gibi bu s�tun i�in null veri girilmelidir.
insert into Yonetmen values ('Guy', 'Ritchie', null, 0) -- id otomatik olarak verilir: 2

-- Bu �rnekte dogumtarihi ve emeklimi s�tun verileri null olacakt�r.
insert into Yonetmen (Adi, Soyadi) values ('F. Gary', 'Gray') -- id otomatik olarak verilir: 3

insert into Yonetmen values ('Ridley', 'Scott', null, 1) -- �rnek i�in d�zeltilecek, id otomatik olarak verilir: 4
insert into Yonetmen values ('David', 'Fincher', '1962-08-28', 0) -- id otomatik olarak verilir: 5
insert into Yonetmen values ('Hatal� Giri� Ad', 'Hatal� Giri� Soyad', null, null) -- �rnek i�in silinecek, id otomatik olarak verilir: 6
insert into Yonetmen values ('David', 'Lynch', null, 0) -- id otomatik olarak verilir: 7

go

insert into Film values ('Hatal� Giri�', 'Hata', 1, 1000000) -- �rnek i�in d�zeltilecek, id otomatik olarak verilir: 1
insert into Film (Adi, YonetmenId, Gisesi) values ('Sherlock Holmes', 2, 50000) -- id otomatik olarak verilir: 2
insert into Film (Adi, YonetmenId) values ('Hatal� Giri�', 1) -- �rnek i�in silinecek, id otomatik olarak verilir: 3
insert into Film (Adi, YapimYili, YonetmenId, Gisesi) values ('Adalet Pe�inde', '2009', null, 30000) -- �rnek i�in d�zeltilecek, id otomatik olarak verilir: 4
insert into Film values ('Yarat�k', '1979', 4, 1000000) -- id otomatik olarak verilir: 5
insert into Film values ('Yarat�k 2', '1986', 1, 700000) -- id otomatik olarak verilir: 6
insert into Film values ('Yarat�k 3', '1992', 5, 400000) -- id otomatik olarak verilir: 7

insert into Tur values ('Hatal� Giri�') -- �rnek i�in d�zeltilecek, id otomatik olarak verilir: 1
insert into Tur values ('Bilim Kurgu') -- id otomatik olarak verilir: 2
insert into Tur values ('Aksiyon') -- id otomatik olarak verilir: 3
insert into Tur values ('Dram') -- id otomatik olarak verilir: 4
insert into Tur values ('Gizem') -- id otomatik olarak verilir: 5
insert into Tur values ('Su�') -- id otomatik olarak verilir: 6
insert into Tur values ('Macera') -- id otomatik olarak verilir: 7
insert into Tur values ('Korku') -- id otomatik olarak verilir: 8
insert into Tur values ('Uzay') -- id otomatik olarak verilir: 9

-- Film ve Tur verilerini girdikten sonra Film ve Tur aras�ndaki many to many ili�kiyi sa�layan FilmTur
-- ara tablosuna film id ve t�r id �zerinden ili�ki verilerini girebiliriz.
insert into FilmTur values (1, 1)
insert into FilmTur values (1, 2)
insert into FilmTur values (1, 3)
insert into FilmTur values (2, 1)	
insert into FilmTur values (2, 4)	
insert into FilmTur values (2, 3)	
insert into FilmTur values (2, 6)
insert into FilmTur values (5, 7)
insert into FilmTur values (5, 8)
insert into FilmTur values (5, 2)
insert into FilmTur values (5, 9)
insert into FilmTur values (6, 3)
insert into FilmTur values (6, 8)
insert into FilmTur values (6, 2)
insert into FilmTur values (6, 9)
insert into FilmTur values (7, 1)
insert into FilmTur values (7, 3)
insert into FilmTur values (7, 2)
insert into FilmTur values (7, 9)
insert into FilmTur values (4, 3)
insert into FilmTur values (4, 4)

insert into FilmDetay values (2, 60000, 'Sherlock Holmes ve Dr. Watson''�n maceralar�.') 
insert into FilmDetay values (5, 200000, 'Yarat�k serisinin ilk filmi.') 

-- 2) UPDATE: Bir tablodaki bir veya daha fazla sat�r�n s�tunlar�ndaki verilerin belli bir ko�ul k�mesine g�re veya ko�ul olmadan 
-- g�ncellenmesi i�in kullan�l�r.

-- E�er update i�leminde bir foreign key s�tun verisi g�ncellenmek isteniyorsa foreign key �zerinden ili�kili olan di�er tabloda
-- g�ncellenecek id verisinin bulunup bulunmad��� kontrol edilmelidir. E�er yoksa hata al�nacakt�r.

--update Film set yonetmenid = 3 
-- E�er bu �ekilde sorgu �al��t�r�l�rsa Film tablosundaki t�m yonetmen id'ler 3 olarak g�ncellenir.

update Film set YonetmenId = 3 where Adi = 'Adalet Pe�inde' 
-- E�er bu �ekilde sorgu �al��t�r�l�rsa Film tablosunda sadece ad� Adalet Pe�inde olan filmin y�netmen id'si 3 olarak g�ncellenir.

-- WHERE: Sorgu i�in ko�ul (�art) veya ko�ullar (�artlar) belirtmek i�in kullan�l�r. Belirtilen ko�ul veya ko�ullara uyan sat�rlar etkilenir.
-- Update, delete ve select sorgular�nda kullan�l�r. Birden �ok ko�ul i�in and (ve) ile or (veya) operat�rleri kullan�labilir.
-- Bir ko�ulun de�ilini almak i�in de not operat�r� kullan�l�r.
-- Where ko�ulundaki s�tunlar ile =, !=, >, <, >= ve <= operat�rleri kullan�labilir.
-- Select konusunda kullan�m� daha detayl� g�sterilecektir.

-- update ile birden �ok s�tun virg�l ile ayr�larak g�ncellenebilir.
update Film set Adi = 'Avatar', YapimYili = '2009', YonetmenId = null where Id = 1 -- id'si 1 olan filmin ad�n� Avatar, yap�m y�l�n� 2009 ve y�netmen id'sini null olarak g�nceller.

update Yonetmen set DogumTarihi = '1937-11-30' where Id = 4 -- id'si 4 olan y�netmenin do�um tarihini 30.11.1937 olarak g�nceller.

update Tur set Adi = 'Gerilim' where Id = 1 -- id'si 1 olan t�r�n ad�n� Gerilim olarak g�nceller.

-- 3) DELETE: Bir tablodaki bir veya daha fazla sat�r�n belli bir ko�ul k�mesine g�re veya ko�ul olmadan 
-- silinmesi i�in kullan�l�r.
--delete from Film 
-- E�er bu �ekilde sorgu �al��t�r�l�rsa Film tablosundaki t�m sat�rlar silinir.

delete from Film where Id = 3
-- E�er bu �ekilde sorgu �al��t�r�l�rsa film tablosunda sadece id'si 3 olan sat�r silinir.

delete from Yonetmen where Adi = 'Hatal� Giri� Ad' -- ad� Hatal� Giri� Ad olan sat�r y�netmen tablosundan silinir.

delete from FilmTur where FilmId = 4 -- film id'si 4 olan sat�rlar film t�r tablosundan silinir.