drop database ForumFoto;

create database ForumFoto;

use ForumFoto;

create table PROVINCIA (
  ID int not null AUTO_INCREMENT,
	Nome varchar(50) not null,
	Sigla varchar(2) not null,
	primary key (ID)
) engine=INNODB;

create table CITTA (
  ID int not null AUTO_INCREMENT,
	Nome varchar(50) not null,
	ID_Provincia int not null,
	primary key (ID),
	foreign key (ID_Provincia) references PROVINCIA (ID)
) engine=INNODB;

create table LUOGO (
  ID int not null AUTO_INCREMENT,
  Via varchar(50) not null,
	ID_Citta int not null,
	primary key (ID),
  foreign key (ID_Citta) references CITTA (ID)
) engine=INNODB;


create table STUDIO (
	ID int not null AUTO_INCREMENT,
	Nome varchar(50) not null,
	primary key (ID)
) engine=INNODB;


create table RISIEDE (
	ID_Studio int not null,
  ID_Luogo int not null,
  NumeroCivico int not null,
  primary key (ID_Studio, ID_Luogo),
  foreign key (ID_Luogo) references LUOGO (ID),
  foreign key (ID_Studio) references STUDIO (ID)
) engine=INNODB;


create table UTENTE (
  ID int not null AUTO_INCREMENT,
	Nome varchar(50) not null,
	Cognome varchar(50) not null,
	Data date,
	Email varchar(50) not null,
	Cellulare varchar(50),
	ID_Studio int not null,
	primary key (ID),
	foreign key (ID_Studio) references STUDIO (ID)
) engine=INNODB;


create table ALBUM (
  ID int not null AUTO_INCREMENT,
	NomeAlbum varchar(50) not null,
  Data date,
	ID_Utente int not null,
	primary key (ID),
	foreign key (ID_Utente) references UTENTE (ID)
) engine=INNODB;

create table CATEGORIA (
  ID int not null AUTO_INCREMENT,
	Nome varchar(50) not null,
  Descrizione varchar(50) not null,
	primary key (ID)
) engine=INNODB;

create table MARCA (
  ID int not null AUTO_INCREMENT,
  Nome varchar(50) not null,
  Stato varchar(50) not null,
	primary key (ID)
) engine=INNODB;

create table MACCHINA (
  ID int not null AUTO_INCREMENT,
	Modello varchar(50) not null,
  Sensore int not null,
  Peso int not null,
	MaxISO int not null,
  ID_Marca int not null,
	primary key (ID),
	foreign key (ID_Marca) references MARCA (ID)
) engine=INNODB;

create table OBIETTIVO (
  ID int not null AUTO_INCREMENT,
	Modello varchar(50) not null,
  OIS bit not null,
  AF bit not null,
  Zoom int not null,
  ID_Marca int not null,
	primary key (ID),
	foreign key (ID_Marca) references MARCA (ID)
) engine=INNODB;

create table COMPATTA (
	ID_Macchina int not null,
  ID_Obiettivo int not null,
  ZoomDigitale int not null,
  StabilizzazioneDigitale bit not null,
	primary key (ID_Macchina, ID_Obiettivo),
  foreign key (ID_Macchina) references MACCHINA (ID),
	foreign key (ID_Obiettivo) references OBIETTIVO (ID)
) engine=INNODB;

create table REFLEX (
	ID_Macchina int not null,
  MotoreAF bit not null,
	primary key (ID_Macchina),
  foreign key (ID_Macchina) references MACCHINA (ID)
) engine=INNODB;

create table MONTA (
	ID_Macchina int not null,
	ID_Obiettivo int not null,
  Attacco varchar(10) not null,
	primary key (ID_Macchina, ID_Obiettivo),
  foreign key (ID_Macchina) references REFLEX (ID_Macchina),
	foreign key (ID_Obiettivo) references OBIETTIVO (ID)
) engine=INNODB;

create table FOTOGRAFIA (
	ID int not null AUTO_INCREMENT,
  Descrizione varchar(140) not null,
	Data date,
	ID_Album int not null,
	ID_Categoria int not null,
	ID_Luogo int not null,
	ID_Macchina int not null,
	ID_Obiettivo int not null,
	LunghezzaFocale float not null,
	Angolo int not null,
	Diaframma float not null,
	Esposizione float not null,
	ISO int not null,
	Risoluzione int not null,
	primary key (ID),
  foreign key (ID_Album) references ALBUM (ID),
	foreign key (ID_Categoria) references CATEGORIA (ID),
  foreign key (ID_Luogo) references LUOGO (ID),
	foreign key (ID_Macchina) references MACCHINA (ID),
	foreign key (ID_Obiettivo) references OBIETTIVO (ID)
) engine=INNODB;

create table VOTO (
	ID int not null AUTO_INCREMENT,
	ID_Utente int not null,
	ID_Foto int not null,
	Voto int not null,
	Descrizione varchar(140),
	primary key (ID),
  foreign key (ID_Utente) references ALBUM (ID),
	foreign key (ID_Foto) references FOTOGRAFIA (ID)
) engine=INNODB;

SOURCE C://Users/andre/Desktop/InsertMySQLForumFoto.sql;

insert into PROVINCIA (Nome, Sigla) value ("Viterbo", "VT");
insert into PROVINCIA (Nome, Sigla) value ("Roma", "RM");
insert into PROVINCIA (Nome, Sigla) value ("Latina", "LT");

insert into CITTA (Nome, ID_Provincia) value ("Vetralla", 1);
insert into CITTA (Nome, ID_Provincia) value ("Viterbo", 1);
insert into CITTA (Nome, ID_Provincia) value ("Roma", 2);
insert into CITTA (Nome, ID_Provincia) value ("Tivoli", 2);
insert into CITTA (Nome, ID_Provincia) value ("Latina", 3);

insert into LUOGO (Via, ID_Citta) value ("AB", 1);
insert into LUOGO (Via, ID_Citta) value ("CA", 2);
insert into LUOGO (Via, ID_Citta) value ("BB", 3);
insert into LUOGO (Via, ID_Citta) value ("AB", 4);
insert into LUOGO (Via, ID_Citta) value ("BB", 5);

insert into STUDIO (Nome) value ("StudioVT");
insert into STUDIO (Nome) value ("StudioRM1");
insert into STUDIO (Nome) value ("StudioRM2");

insert into RISIEDE (ID_Studio, ID_Luogo, NumeroCivico) value (1, 1, 21);
insert into RISIEDE (ID_Studio, ID_Luogo, NumeroCivico) value (1, 2, 3);
insert into RISIEDE (ID_Studio, ID_Luogo, NumeroCivico) value (2, 3, 4);
insert into RISIEDE (ID_Studio, ID_Luogo, NumeroCivico) value (3, 4, 65);
insert into RISIEDE (ID_Studio, ID_Luogo, NumeroCivico) value (2, 5, 121);

insert into UTENTE (Nome, Cognome, Data, Email, Cellulare, ID_Studio) value ("Andrea",  "Bernini", '1999-01-24', "andreabe99@gmail.com",  "3342130932", 1);
insert into UTENTE (Nome, Cognome, Data, Email, Cellulare, ID_Studio) value ("Marco",   "Rossi",   '1999-04-29', "marcoro99@gmail.com",   "3353498763", 1);
insert into UTENTE (Nome, Cognome, Data, Email, Cellulare, ID_Studio) value ("Giacomo", "Verdi",   '1992-11-12', "giacomove92@gmail.com", "3319303549", 2);
insert into UTENTE (Nome, Cognome, Data, Email, Cellulare, ID_Studio) value ("Matteo",  "Gialli",  '1993-09-02', "matteogi93@gmail.com",  "3330382384", 2);
insert into UTENTE (Nome, Cognome, Data, Email, Cellulare, ID_Studio) value ("Luca",    "Neri",    '1996-02-24', "lucane96@gmail.com",    "3339412345", 3);

insert into ALBUM (NomeAlbum, Data, ID_Utente) value ("Paesaggi", '2019-02-22', 1);
insert into ALBUM (NomeAlbum, Data, ID_Utente) value ("Animali",  '2019-04-02', 1);
insert into ALBUM (NomeAlbum, Data, ID_Utente) value ("Ritratti", '2018-02-22', 2);
insert into ALBUM (NomeAlbum, Data, ID_Utente) value ("Citta",    '2019-06-10', 2);
insert into ALBUM (NomeAlbum, Data, ID_Utente) value ("Ritratti", '2019-01-23', 3);
insert into ALBUM (NomeAlbum, Data, ID_Utente) value ("Edifici",  '2019-11-01', 4);
insert into ALBUM (NomeAlbum, Data, ID_Utente) value ("Paesaggi", '2019-12-22', 5);

insert into CATEGORIA (Nome, Descrizione) value ("Natura", "abcd");
insert into CATEGORIA (Nome, Descrizione) value ("Persone", "efgh");
insert into CATEGORIA (Nome, Descrizione) value ("Oggetti", "ilmn");

insert into MARCA (Nome, Stato) value ("Nikon", "Giappone");
insert into MARCA (Nome, Stato) value ("Sony", "Giappone");
insert into MARCA (Nome, Stato) value ("Leica", "Germania");

insert into MACCHINA (Modello, Sensore, Peso, MaxISO, ID_Marca) value ("ni12", 43, 280, 6400, 1);
insert into MACCHINA (Modello, Sensore, Peso, MaxISO, ID_Marca) value ("ni34", 28, 230, 5000, 1);
insert into MACCHINA (Modello, Sensore, Peso, MaxISO, ID_Marca) value ("sn07", 43, 300, 4000, 2);
insert into MACCHINA (Modello, Sensore, Peso, MaxISO, ID_Marca) value ("sn12", 21, 200, 5000, 2);
insert into MACCHINA (Modello, Sensore, Peso, MaxISO, ID_Marca) value ("Le32", 54, 400, 6400, 3);

insert into OBIETTIVO (Modello, OIS, AF, Zoom, ID_Marca) value ("Obiettivo1", 0, 1, 50,  1);
insert into OBIETTIVO (Modello, OIS, AF, Zoom, ID_Marca) value ("Obiettivo2", 1, 1, 100, 2);
insert into OBIETTIVO (Modello, OIS, AF, Zoom, ID_Marca) value ("Obiettivo3", 1, 0, 100, 3);
insert into OBIETTIVO (Modello, OIS, AF, Zoom, ID_Marca) value ("Obiettivo4", 0, 1, 50,  2);
insert into OBIETTIVO (Modello, OIS, AF, Zoom, ID_Marca) value ("Obiettivo5", 1, 1, 100, 1);

insert into COMPATTA (ID_Macchina, ID_Obiettivo, ZoomDigitale, StabilizzazioneDigitale) value (3, 2, 100, 1);
insert into COMPATTA (ID_Macchina, ID_Obiettivo, ZoomDigitale, StabilizzazioneDigitale) value (5, 3, 100, 0);

insert into REFLEX (ID_Macchina, MotoreAF) value (1, 0);
insert into REFLEX (ID_Macchina, MotoreAF) value (2, 1);
insert into REFLEX (ID_Macchina, MotoreAF) value (4, 1);


insert into MONTA (ID_Macchina, ID_Obiettivo, Attacco) value (1, 1, "BF");
insert into MONTA (ID_Macchina, ID_Obiettivo, Attacco) value (1, 5, "BF");
insert into MONTA (ID_Macchina, ID_Obiettivo, Attacco) value (2, 1, "BF");
insert into MONTA (ID_Macchina, ID_Obiettivo, Attacco) value (2, 5, "BF");
insert into MONTA (ID_Macchina, ID_Obiettivo, Attacco) value (4, 2, "CS");


insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("a", '2019-01-01', 1, 1, 1, 1, 5, 52, 70,  2.0, 10, 200,  1080);
insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("b", '2019-03-02', 2, 1, 2, 1, 1, 44, 110, 2.5, 80, 1000, 1440);
insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("c", '2019-02-03', 2, 2, 3, 3, 4, 48, 24,  2.3, 80, 1200, 720);
insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("d", '2019-06-04', 3, 3, 1, 2, 1, 44, 70,  2.2, 40, 1300, 1440);
insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("e", '2019-06-04', 4, 3, 4, 2, 5, 52, 120, 2.1, 30, 800,  1080);
insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("f", '2019-04-05', 4, 3, 5, 2, 5, 52, 16,  1.8, 20, 200,  1440);
insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("g", '2019-01-06', 5, 1, 1, 4, 2, 72, 70,  1.7, 40, 100,  1080);
insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("h", '2019-01-06', 5, 2, 2, 4, 2, 72, 70,  1.4, 60, 300,  720);
insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("i", '2019-08-07', 6, 2, 5, 5, 3, 52, 120, 1.9, 90, 700,  1440);
insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("l", '2019-08-07', 6, 2, 3, 5, 3, 52, 180, 1.8, 10, 1200, 720);
insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("m", '2019-11-08', 7, 2, 1, 3, 4, 48, 44,  2.2, 60, 2200, 1440);
insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("n", '2019-12-09', 7, 1, 3, 2, 5, 52, 70,  2.0, 30, 2600, 1440);

insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (1, 1, 8,   "abcdefg");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (1, 5, 6,   "jfhldsdg");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (1, 6, 8,   "abcdefg");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (1, 7, 7,   "jfhldsdg");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (1, 8, 5,   "abcdefg");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (1, 9, 6,   "jfhldsdg");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (2, 10, 7,  "gfhgfhsfhf");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (2, 11, 5,  "dfhfdffd");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (2, 10, 10, "dfhfdffd");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (2, 8, 7,   "gfhgfhsfhf");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (3, 1, 8,   "fdfdhfhf");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (3, 2, 7,   "dfhhghsfreh");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (3, 3, 8,   "fdfdhfhf");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (3, 6, 7,   "dfhhghsfreh");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (4, 7, 6,   "bnbnhytery");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (4, 8, 5,   "cuyowcieui");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (4, 1, 6,   "bnbnhytery");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (4, 2, 8,   "cuyowcieui");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (5, 1, 9,   "dey7398hce");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (5, 5, 7,   "cbuebcuooe");
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (5, 6, 4,   "eqvuicoie");





/********************** QUERY **********************/

/*	1 Mostrare il numero di foto per ogni categoria	*/
SELECT CATEGORIA.Nome, COUNT(*) as NumeroFoto
FROM FOTOGRAFIA, CATEGORIA
WHERE FOTOGRAFIA.ID_Categoria = CATEGORIA.ID
GROUP BY CATEGORIA.Nome;

CREATE INDEX index_categoria ON CATEGORIA (Nome);
DROP INDEX index_categoria ON CATEGORIA;


/*	2 Mostrare il numero di utenti registrati raggruppandoli per anno di
		nascita	*/
SELECT YEAR(UTENTE.Data) as Anno, COUNT(UTENTE.ID) as NumeroUtenti
FROM UTENTE
GROUP BY YEAR(UTENTE.Data);

CREATE INDEX index_nascita ON UTENTE (Data);
DROP INDEX index_nascita ON UTENTE;


/* 3 Mostrare gli utenti nati dopo il 1995	*/
SELECT UTENTE.ID, UTENTE.Nome, UTENTE.Cognome, UTENTE.Data
FROM UTENTE
WHERE YEAR(UTENTE.Data) >= 1995;



/* 4 Mostrare gli utenti che lavorano per gli studi che hanno almeno una sede nella
	 provincia di Roma */
SELECT UTENTE.ID, UTENTE.Nome, UTENTE.Cognome
FROM UTENTE, STUDIO, RISIEDE, LUOGO, CITTA, PROVINCIA
WHERE UTENTE.ID_Studio = STUDIO.ID and RISIEDE.ID_Studio=STUDIO.ID and
    RISIEDE.ID_Luogo = LUOGO.ID and LUOGO.ID_Citta = CITTA.ID and
    CITTA.ID_Provincia = PROVINCIA.ID and PROVINCIA.Nome = "Roma";


Calcolo Relazionale:
    {u.ID, u.Nome, u.Cognome |
      u(UTENTE), s(STUDIO), r(RISIEDE), l(LUOGO), c(CITTA), p(PROVINCIA) |
      u.ID_Studio = s.ID ∧ r.ID_Studio = s.ID ∧ r.ID_Luogo = l.ID ∧
        l.ID_Citta = c.ID ∧ c.ID_Provincia = p.ID ∧ p.Nome ="Roma"}



/* 5 Mostrare il numero di studi presenti nella provincia di Roma */
SELECT COUNT(*) as NumeroStudiRoma
FROM RISIEDE, LUOGO, CITTA, PROVINCIA
WHERE RISIEDE.ID_Luogo = LUOGO.ID and LUOGO.ID_Citta = CITTA.ID and
    CITTA.ID_Provincia = PROVINCIA.ID and PROVINCIA.Nome = "Roma";



/* 6 Mostrare il numero di studi presenti in ciascuna provincia*/
SELECT PROVINCIA.Nome, COUNT(*) as NumeroStudi
FROM RISIEDE, LUOGO, CITTA, PROVINCIA
WHERE RISIEDE.ID_Luogo = LUOGO.ID and LUOGO.ID_Citta = CITTA.ID and
    CITTA.ID_Provincia = PROVINCIA.ID
GROUP BY PROVINCIA.ID;



/* 7 Mostrare il numero di album pubblicati da ogni utente in ordine decrescente */
SELECT UTENTE.ID, UTENTE.Nome, UTENTE.Cognome, COUNT(ALBUM.ID) as NumeroAlbum
FROM ALBUM, UTENTE
WHERE ALBUM.ID_Utente = UTENTE.ID
GROUP BY ALBUM.ID_Utente
ORDER BY COUNT(ALBUM.ID) DESC;



/* 8 Mostrare il numero di fotografie scattate da ciascuna macchina con il TOTALE Finale*/
SELECT COALESCE(FOTOGRAFIA.ID_Macchina, 'TOTALE') as ID_Macchina,  MARCA.Nome as Marca, MACCHINA.Modello as Modello, COUNT(*) as NumFoto
FROM FOTOGRAFIA, MACCHINA, MARCA
WHERE FOTOGRAFIA.ID_Macchina = MACCHINA.ID and MACCHINA.ID_Marca = MARCA.ID
GROUP BY FOTOGRAFIA.ID_Macchina WITH rollup;



/*	9 Stampare gli utenti che hanno il numero di cellulare che inizia per 334 */
CREATE INDEX index_cellulare ON UTENTE (Cellulare);
SELECT UTENTE.ID, UTENTE.Nome, UTENTE.Cognome, UTENTE.Cellulare
FROM UTENTE
WHERE UTENTE.Cellulare like "334%";
DROP INDEX index_cellulare ON UTENTE;


/* 10 Per ogni utente fare una media dei voti delle prorie foto */
SELECT UTENTE.ID, UTENTE.Nome, UTENTE.Cognome, AVG(VOTO.Voto) as MediaVoti
FROM UTENTE, VOTO
WHERE VOTO.ID_Utente = UTENTE.ID
GROUP BY UTENTE.ID
ORDER BY AVG(VOTO.Voto);



/* 11 Stampare l'album con la media voti minore */
SELECT ALBUM.ID as ID_Album, ALBUM.NomeAlbum, UTENTE.ID as ID_Utente, UTENTE.Nome, UTENTE.Cognome, AVG(VOTO.Voto) as MediaVoti
FROM VOTO, FOTOGRAFIA, ALBUM, UTENTE
WHERE VOTO.ID_Foto = FOTOGRAFIA.ID and FOTOGRAFIA.ID_Album = ALBUM.ID and
      ALBUM.ID_Utente = UTENTE.ID
GROUP BY FOTOGRAFIA.ID_Album
ORDER BY AVG(VOTO.Voto) LIMIT 1;

CREATE INDEX index_voto ON VOTO (Voto);
DROP INDEX index_voto ON VOTO;


/* 12 Stampare l'album con piu voti */
SELECT ALBUM.ID as ID_Album, ALBUM.NomeAlbum, UTENTE.ID as ID_Utente, UTENTE.Nome, UTENTE.Cognome, COUNT(VOTO.Voto) as NumeroVoti
FROM VOTO, FOTOGRAFIA, ALBUM, UTENTE
WHERE VOTO.ID_Foto = FOTOGRAFIA.ID and FOTOGRAFIA.ID_Album = ALBUM.ID and
      ALBUM.ID_Utente = UTENTE.ID
GROUP BY FOTOGRAFIA.ID_Album
ORDER BY COUNT(VOTO.Voto) DESC LIMIT 1;



/*	13 Stampare il modello di macchina più usato*/
SELECT FOTOGRAFIA.ID_Macchina,  MARCA.Nome as Marca, MACCHINA.Modello as Modello, COUNT(*) as NumFoto
FROM FOTOGRAFIA, MACCHINA, MARCA
WHERE FOTOGRAFIA.ID_Macchina = MACCHINA.ID and MACCHINA.ID_Marca = MARCA.ID
GROUP BY FOTOGRAFIA.ID_Macchina
ORDER BY COUNT(*) DESC LIMIT 1;



/* 14 Stampare le macchine compatibili solo con l'Obiettivo5 */
SELECT MONTA.Attacco, MACCHINA.Modello, MARCA.Nome as Marca
FROM MONTA, OBIETTIVO, MACCHINA, MARCA
WHERE MACCHINA.ID_Marca = MARCA.ID and MONTA.ID_Macchina = MACCHINA.ID and
    MONTA.ID_Obiettivo = OBIETTIVO.ID and OBIETTIVO.Modello = "Obiettivo5";



/* 15 Trovare gli utenti che hanno pubblicato un album dopo il giorno in cui
    l'utente con ID=1 ha pubblicato l'album Animali */
SELECT UTENTE.ID as ID_Utente, UTENTE.Nome, UTENTE.Cognome, ALBUM.ID as ID_Album, ALBUM.NomeAlbum, ALBUM.Data
FROM UTENTE, ALBUM, ALBUM as A
WHERE ALBUM.ID_Utente = UTENTE.ID and ALBUM.Data > A.Data and
A.NomeAlbum = "Animali" and A.ID_Utente = 1;



/* 16 Trovare gli utenti che hanno messo lo stesso voto dell'utente 1 alla foto con ID=7 */
SELECT UTENTE.ID as ID_Utente, UTENTE.Nome, UTENTE.Cognome, VOTO.Voto
FROM UTENTE, VOTO, VOTO as V
WHERE VOTO.ID_Utente = UTENTE.ID and VOTO.ID_Foto = V.ID_Foto and
VOTO.Voto = V.Voto and V.ID_Utente = 1 and V.ID_Foto=8;



/* 17 Mostrare tutte le foto (e da chi sono scattate) che hanno angolo superiore
	alla foto con ID=2*/
SELECT UTENTE.ID as ID_Utente, UTENTE.Nome, UTENTE.Cognome, FOTOGRAFIA.ID as ID_Foto, ALBUM.NomeAlbum, FOTOGRAFIA.Angolo
FROM UTENTE, ALBUM, FOTOGRAFIA, FOTOGRAFIA as F
WHERE ALBUM.ID_Utente = UTENTE.ID and FOTOGRAFIA.ID_Album = ALBUM.ID and FOTOGRAFIA.Angolo > F.Angolo and F.ID=2;

π[UTENTE.ID, UTENTE.Nome, UTENTE.Cognome, FOTOGRAFIA.ID, ALBUM.NomeAlbum, FOTOGRAFIA.Angolo] (
  UTENTE |X| [ID = ID_Utente] (ALBUM |X| [ID = ID_Album]
  ( σ[F.Angolo > FOTOGRAFIA.Angolo] ( p[F ⇽ FOTOGRAFIA] ( (σ[FOTOGRAFIA.ID = 2] FOTOGRAFIA) ) )


/* 18 Mostrare tutte le foto pubblicate tra il 2019-06-01 e il 2019-09-01 e da chi*/
SELECT UTENTE.Nome, UTENTE.Cognome, ALBUM.NomeAlbum, FOTOGRAFIA.ID as ID_Foto, FOTOGRAFIA.Data
FROM FOTOGRAFIA, ALBUM, UTENTE
WHERE ALBUM.ID_Utente = UTENTE.ID and FOTOGRAFIA.ID_Album = ALBUM.ID and
  FOTOGRAFIA.Data between '2019-06-01' and '2019-09-01';

CREATE INDEX index_data ON FOTOGRAFIA (Data);
DROP INDEX index_data ON FOTOGRAFIA;


/* 19 Mostrare tutte le foto pubblicate nel mese di giugno di qulasiasi anno*/
SELECT UTENTE.ID as ID_Utente, UTENTE.Nome, UTENTE.Cognome, ALBUM.NomeAlbum, FOTOGRAFIA.ID as ID_Foto, FOTOGRAFIA.Data
FROM FOTOGRAFIA, ALBUM, UTENTE
WHERE ALBUM.ID_Utente = UTENTE.ID and FOTOGRAFIA.ID_Album = ALBUM.ID and
      MONTH(FOTOGRAFIA.Data) = 6;



/* 20 Stampare tutti gli utenti che hanno scattato foto nelle stesse Citta in cui ha
scattato l'utente Andrea Bernini */
SELECT DISTINCT UTENTE1.ID as ID_Utente, UTENTE1.Nome, UTENTE1.Cognome, CITTA.Nome
FROM UTENTE, ALBUM, FOTOGRAFIA, LUOGO, CITTA, UTENTE as UTENTE1,
      ALBUM as ALBUM1, FOTOGRAFIA as FOTOGRAFIA1, LUOGO as LUOGO1,
      CITTA as CITTA1
WHERE  ALBUM1.ID_Utente = UTENTE1.ID and FOTOGRAFIA1.ID_Album = ALBUM1.ID and
  FOTOGRAFIA1.ID_Luogo = LUOGO1.ID and LUOGO1.ID_Citta = CITTA.ID and
  LUOGO.ID_Citta = CITTA.ID and FOTOGRAFIA.ID_Luogo = LUOGO.ID and
  FOTOGRAFIA.ID_Album = ALBUM.ID and ALBUM.ID_Utente = UTENTE.ID and
  UTENTE.Nome = "Andrea" and UTENTE.Cognome = "Bernini";


/* 21 Stampare l'obiettivo usato più volte insieme alla macchina ni34 */
SELECT FOTOGRAFIA.ID_Obiettivo, OBIETTIVO.Modello as ModelloObiettivo,  COUNT(FOTOGRAFIA.ID_Obiettivo) as UsatoNUM, MARCA.Nome as Marca
FROM FOTOGRAFIA, MACCHINA, OBIETTIVO, MARCA
WHERE OBIETTIVO.ID_Marca = MARCA.ID and FOTOGRAFIA.ID_Obiettivo = OBIETTIVO.ID and
      FOTOGRAFIA.ID_Macchina = MACCHINA.ID and MACCHINA.Modello = "ni34"
GROUP BY FOTOGRAFIA.ID_Obiettivo
ORDER BY COUNT(FOTOGRAFIA.ID_Obiettivo) DESC LIMIT 1;



/* 22 Stampare la macchina più usata nella provincia di Roma */
SELECT FOTOGRAFIA.ID_Macchina, MACCHINA.Modello as ModelloMacchina, MARCA.Nome as Marca, COUNT(FOTOGRAFIA.ID_Macchina) as UsatoNUM
FROM FOTOGRAFIA, MACCHINA, LUOGO, CITTA, PROVINCIA, MARCA
WHERE MACCHINA.ID_Marca = MARCA.ID and FOTOGRAFIA.ID_Macchina = MACCHINA.ID and FOTOGRAFIA.ID_Luogo = LUOGO.ID
  and LUOGO.ID_Citta = CITTA.ID and CITTA.ID_Provincia = PROVINCIA.ID and
  PROVINCIA.Nome = "Roma"
GROUP BY FOTOGRAFIA.ID_Macchina
ORDER BY COUNT(FOTOGRAFIA.ID_Macchina) DESC LIMIT 1;


/* 23 Visualizzare tutti i commenti di una determinata foto */
SELECT VOTO.Voto, VOTO.Descrizione, UTENTE.Nome, UTENTE.Cognome
FROM VOTO, UTENTE
WHERE VOTO.ID_Utente = UTENTE.ID and VOTO.ID_Foto = 2;



/* 24 Visualizzare quanti modelli di macchine produce ogni paese */
SELECT MARCA.Stato, COUNT(*) as NumModelli
FROM MARCA, MACCHINA
WHERE MACCHINA.ID_Marca = MARCA.ID
GROUP BY MARCA.Stato;




/********************** TRIGGER **********************/

DELIMITER //
CREATE TRIGGER TR_UTENTE_Email
	BEFORE INSERT ON UTENTE
	FOR EACH ROW
	BEGIN
		IF NEW.Email not like "%@gmail.com" OR "%@outlook.com" OR "%@yahoo.com" OR "%@hotmail.com" THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Dominio Email non riconosciuto';
		END IF;
	END;//
DELIMITER ;
DROP TRIGGER TR_UTENTE_Email;
insert into UTENTE (Nome, Cognome, Data, Email, Cellulare, ID_Studio) value ("Luca",    "Neri",    '1996-02-24', "ProvaErrata@gnail.com",    "3339412345", 3);



DELIMITER //
CREATE TRIGGER TR_UTENTE_Cellulare
	BEFORE INSERT ON UTENTE
	FOR EACH ROW
	BEGIN
		IF LENGTH(NEW.Cellulare) != 10 THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Numero di cellulare non valido (lunghezza non valida)';
    ELSEIF NEW.Cellulare NOT REGEXP '^[0-9]+$' THEN SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Numero di cellulare non valido (sono presenti caratteri)';
		END IF;
	END;//
DELIMITER ;
DROP TRIGGER TR_UTENTE_Cellulare;
insert into UTENTE (Nome, Cognome, Data, Email, Cellulare, ID_Studio) value ("Luca",    "Neri",    '1996-02-24', "lucane96@gmail.com",    "334213r932", 3);



DELIMITER //
CREATE TRIGGER TR_UTENTE_Data
	BEFORE INSERT ON UTENTE
	FOR EACH ROW
	BEGIN
		IF ADDDATE(NEW.Data,INTERVAL 18 YEAR) >= CURRENT_DATE() THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Utente ancora non maggiorenne';
		END IF;
	END;//
DELIMITER ;
DROP TRIGGER TR_UTENTE_Data;
insert into UTENTE (Nome, Cognome, Data, Email, Cellulare, ID_Studio) value ("Luca",    "Neri",    '2004-02-24', "lucane96@gmail.com",    "3342130932", 3);



DELIMITER //
CREATE TRIGGER TR_VOTO_Voto
	BEFORE INSERT ON VOTO
	FOR EACH ROW
	BEGIN
		IF NEW.Voto > 10 THEN
			SET NEW.Voto = 10;
		ELSEIF NEW.Voto < 0 THEN
			SET NEW.Voto = 0;
			END IF;
	END;//
DELIMITER ;
DROP TRIGGER TR_VOTO_Voto;
insert into VOTO (ID_Utente, ID_Foto, Voto, Descrizione) value (3, 4, 12, "eqvuicoie");



DELIMITER //
CREATE TRIGGER TR_ALBUM_Data
	BEFORE INSERT ON ALBUM
	FOR EACH ROW
	BEGIN
		IF NEW.Data > CURRENT_DATE() THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Data inserita errata';
		END IF;
	END;//
DELIMITER ;
DROP TRIGGER TR_ALBUM_Data;
insert into ALBUM (NomeAlbum, Data, ID_Utente) value ("Paesaggi", '2033-12-22', 5);




DELIMITER //
CREATE TRIGGER TR_FOTO_Data
	BEFORE INSERT ON FOTOGRAFIA
	FOR EACH ROW
	BEGIN
		IF NEW.Data > CURRENT_DATE() THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Data inserita errata';
		END IF;
	END;//
DELIMITER ;
DROP TRIGGER TR_FOTO_Data;
insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("provaTriggerAngolo", '2021-12-09', 7, 1, 3, 2, 5, 52, 300,  2.0, 30, 2600, 1440);




DELIMITER //
CREATE TRIGGER TR_FOTO_Angolo
	BEFORE INSERT ON FOTOGRAFIA
	FOR EACH ROW
	BEGIN
		IF NEW.Angolo > 220 THEN
			SET NEW.Voto = 220;
		ELSEIF NEW.Voto < 2 THEN
			SET NEW.Voto = 2;
			END IF;
	END;//
DELIMITER ;
DROP TRIGGER TR_FOTO_Angolo;
insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("provaTriggerAngolo", '2019-12-09', 7, 1, 3, 2, 5, 52, 300,  2.0, 30, 2600, 1440);



DELIMITER //
CREATE TRIGGER TR_FOTO_LunghezzFocale
	BEFORE INSERT ON FOTOGRAFIA
	FOR EACH ROW
	BEGIN
			SET New.Angolo =
				(		SELECT DISTINCT DEGREES(2*ATAN((MACCHINA.Sensore)/ (2*NEW.LunghezzaFocale))) as Angolo
						FROM MACCHINA
						WHERE NEW.Macchina = MACCHINA.Modello
						and NEW.MarcaMacchina = MACCHINA.Marca
				);
	END;//
DELIMITER ;
DROP TRIGGER TR_FOTO_LunghezzFocale;
insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Diaframma, Esposizione, ISO, Risoluzione) value ("provaTriggerLunghezzaFocale", '2019-12-09', 7, 1, 3, 2, 5, 52,  2.0, 30, 2600, 1440);
/* Angolo = 360/pGreco * arctan(DimensioneSensore/ 2*LunghezzaFocale)

SELECT DISTINCT DEGREES(2*ATAN((MACCHINA.Sensore)/ (2*FOTOGRAFIA.LunghezzaFocale))) as Angolo
FROM MACCHINA, FOTOGRAFIA
WHERE FOTOGRAFIA.Macchina = MACCHINA.Modello
		and FOTOGRAFIA.MarcaMacchina = MACCHINA.Marca and
		FOTOGRAFIA.Macchina = "ni34" and FOTOGRAFIA.MarcaMacchina = "Nikon";
*/



DELIMITER //
CREATE TRIGGER TR_FOTO_Diaframma
	BEFORE INSERT ON FOTOGRAFIA
	FOR EACH ROW
	BEGIN
		IF NEW.Diaframma > 45 THEN
			SET NEW.Diaframma = 45;
		ELSEIF NEW.Diaframma < 45 AND NEW.Diaframma > 32 THEN
			SET NEW.Diaframma = 32;
		ELSEIF NEW.Diaframma < 32 AND NEW.Diaframma > 22 THEN
			SET NEW.Diaframma = 22;
		ELSEIF NEW.Diaframma < 22 AND NEW.Diaframma > 16 THEN
			SET NEW.Diaframma = 16;
		ELSEIF NEW.Diaframma < 16 AND NEW.Diaframma > 11 THEN
			SET NEW.Diaframma = 11;
		ELSEIF NEW.Diaframma < 11 AND NEW.Diaframma > 8 THEN
			SET NEW.Diaframma = 8;
		ELSEIF NEW.Diaframma < 8 AND NEW.Diaframma > 5.6 THEN
			SET NEW.Diaframma = 5.6;
		ELSEIF NEW.Diaframma < 5.6 AND NEW.Diaframma > 4 THEN
			SET NEW.Diaframma = 4;
		ELSEIF NEW.Diaframma < 4 AND NEW.Diaframma > 2.8 THEN
			SET NEW.Diaframma = 2.8;
		ELSEIF NEW.Diaframma < 2.8 AND NEW.Diaframma > 2 THEN
			SET NEW.Diaframma = 2;
		ELSEIF NEW.Diaframma < 2 AND NEW.Diaframma > 1.4 THEN
			SET NEW.Diaframma = 1.4;
		ELSEIF NEW.Diaframma < 1.4 AND NEW.Diaframma > 1 THEN
			SET NEW.Diaframma = 1;
		ELSEIF NEW.Diaframma < 1 THEN
			SET NEW.Diaframma = 1;
			END IF;
	END;//
DELIMITER ;
DROP TRIGGER TR_FOTO_Diaframma;
insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("provaTriggerDiaframma", '2019-12-09', 7, 1, 3, 2, 5, 52, 300,  2.7, 30, 2600, 1440);



DELIMITER //
CREATE TRIGGER TR_FOTO_MaxISO
	BEFORE INSERT ON FOTOGRAFIA
	FOR EACH ROW
	BEGIN
			IF New.ISO >
				(		SELECT DISTINCT MACCHINA.MaxISO
						FROM MACCHINA
						WHERE NEW.Macchina = MACCHINA.Modello
						and NEW.MarcaMacchina = MACCHINA.Marca
				) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ISO superiori rispetto alla capacità della macchina';
			ELSEIF NEW.ISO < 100 THEN SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = 'ISO inferiori rispetto alla capacità della macchina';
				END IF;
	END;//
DELIMITER ;
insert into FOTOGRAFIA (Descrizione, Data, ID_Album, ID_Categoria, ID_Luogo, ID_Macchina, ID_Obiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("provaTriggerMAXISO", '2019-12-09', 7, 1, 3, 2, 5, 52, 300,  2.0, 30, 10000, 1440);
/*
SELECT DISTINCT MACCHINA.MaxISO
		FROM MACCHINA, FOTOGRAFIA
		WHERE FOTOGRAFIA.Macchina = MACCHINA.Modello
		and FOTOGRAFIA.MarcaMacchina = MACCHINA.Marca and FOTOGRAFIA.Macchina="ni34";
	*/






/********************** STORED PROCEEDURE **********************/

DROP PROCEDURE IF EXISTS FotoCitta;
DELIMITER //
CREATE PROCEDURE FotoCitta(IN citta VARCHAR(255))
	BEGIN
	  SELECT FOTOGRAFIA.* FROM FOTOGRAFIA, LUOGO, CITTA WHERE FOTOGRAFIA.ID_Luogo = LUOGO.ID and LUOGO.ID_Citta = CITTA.ID and CITTA.Nome = citta;
	END //
DELIMITER ;
CALL FotoCitta ("Viterbo");



DROP PROCEDURE IF EXISTS proceduraAngolo;
DELIMITER //
CREATE PROCEDURE proceduraAngolo(IN LunghezzaFocale float, IN DimensioneSensore float, OUT Angolo float)
	BEGIN
			SET Angolo = DEGREES(2*ATAN((DimensioneSensore)/ (2*LunghezzaFocale)));
	END //
DELIMITER ;
CALL proceduraAngolo(32, 43, @angolo);
SELECT @angolo;



DROP PROCEDURE IF EXISTS trovaUtente;
DELIMITER //
CREATE PROCEDURE trovaUtente(IN nome VARCHAR(20), cognome VARCHAR(20), OUT id VARCHAR(20))
BEGIN
   DECLARE appoggio VARCHAR(20);
   DECLARE cercaUtente CURSOR FOR SELECT UTENTE.ID FROM UTENTE WHERE UTENTE.Nome = nome and UTENTE.Cognome = cognome;
   OPEN cercaUtente;
   FETCH cercaUtente INTO appoggio;
   CLOSE cercaUtente;
   SET id = appoggio;
END;//
DELIMITER ;
CALL trovaUtente("Andrea", "Bernini", @idUtente);
SELECT @idUtente;



DROP PROCEDURE IF EXISTS contaTipiFoto;
delimiter //
CREATE PROCEDURE contaTipiFoto(OUT Macro INT, OUT Ritratto INT, OUT Normale INT, OUT Grandangolo INT, OUT FishEye INT)
BEGIN
   SET Macro = (	SELECT COUNT(*)
									FROM FOTOGRAFIA
									WHERE FOTOGRAFIA.Angolo <= 8);
	 SET Ritratto = (	SELECT COUNT(*)
										FROM FOTOGRAFIA
										WHERE FOTOGRAFIA.Angolo <= 24 and FOTOGRAFIA.Angolo > 8);
	 SET Normale = (	SELECT COUNT(*)
							 			FROM FOTOGRAFIA
							 			WHERE FOTOGRAFIA.Angolo <= 48 and FOTOGRAFIA.Angolo > 24);
   SET Grandangolo = (	SELECT COUNT(*)
								 				FROM FOTOGRAFIA
								 				WHERE FOTOGRAFIA.Angolo <= 84 and FOTOGRAFIA.Angolo > 48);
	 SET FishEye = (	SELECT COUNT(*)
										FROM FOTOGRAFIA
										WHERE FOTOGRAFIA.Angolo > 84);
END;//
delimiter ;
CALL contaTipiFoto(@Macro, @Ritratto, @Normale, @Grandangolo, @FishEye);
SELECT @Macro, @Ritratto, @Normale, @Grandangolo, @FishEye;







/********************** VIEW **********************/

/* Vista per calcolare la media dei voti per ogni album */
CREATE VIEW MediaVotiAlbum AS (Media_NomeAlbum, Media_NomeUtente, Media_MediaVoti)
SELECT ALBUM.ID as ID_Album, ALBUM.NomeAlbum, UTENTE.ID as ID_Utente, UTENTE.Nome, UTENTE.Cognome, AVG(VOTO.Voto) as MediaVoti
FROM VOTO, FOTOGRAFIA, ALBUM, UTENTE
WHERE VOTO.ID_Foto = FOTOGRAFIA.ID and FOTOGRAFIA.ID_Album = ALBUM.ID and
      ALBUM.ID_Utente = UTENTE.ID
GROUP BY FOTOGRAFIA.ID_Album;

/* Vista per calcolare la media dei voti per ogni utente */
CREATE VIEW MediaVotiAlbum AS (Media_NomeUtente, Media_MediaVoti)
SELECT UTENTE.ID as ID_Utente, UTENTE.Nome, UTENTE.Cognome, AVG(VOTO.Voto) as MediaVoti
FROM VOTO, FOTOGRAFIA, ALBUM, UTENTE
WHERE ALBUM.ID_Utente = UTENTE.ID and FOTOGRAFIA.ID_Album = ALBUM.ID and
      VOTO.ID_Foto = FOTOGRAFIA.ID
GROUP BY UTENTE.ID;

/* Vista che per ogni macchina mostra tutti gli obiettivi compatibili */
CREATE VIEW ObiettiviCompatibili AS (Media_NomeUtente, Media_MediaVoti)
SELECT MACCHINA.Modello, MarcaM.Nome, OBIETTIVO.Modello, MarcaO.Nome, MONTA.Attacco
FROM MACCHINA, OBIETTIVO, MONTA, MARCA as MarcaM, MARCA as MarcaO
WHERE MACCHINA.ID_Marca = MarcaM.ID and OBIETTIVO.ID_Marca = MarcaO.ID and
 MONTA.ID_Macchina = MACCHINA.ID and MONTA.ID_Obiettivo = OBIETTIVO.ID;










/************** MONGO DB *************/

/*	Mostrare il numero di foto per ogni categoria	*/
SELECT CATEGORIA.Nome, COUNT(*) as NumeroFoto
FROM FOTOGRAFIA, CATEGORIA
WHERE FOTOGRAFIA.ID_Categoria = CATEGORIA.ID
GROUP BY CATEGORIA.Nome;

db.Fotografia.explain("executionStats").aggregate([{"$group":{"_id":"$_id_Categoria", "count":{"$sum":1}}}])

/*	Mostrare il numero di utenti registrati raggruppandoli per anno di
		nascita	*/
SELECT YEAR(UTENTE.Data) as Anno, COUNT(UTENTE.ID) as NumeroUtenti
FROM UTENTE
GROUP BY YEAR(UTENTE.Data);

db.Utente.explain("executionStats").aggregate({"$group":{"_id": { $substr: [ "$Data", 0, 4 ]}, "count":{"$sum":1}}}).explain("executionStats")


/* Mostrare gli utenti nati dopo il 1995	*/
SELECT UTENTE.ID, UTENTE.Nome, UTENTE.Cognome, UTENTE.Data
FROM UTENTE
WHERE YEAR(UTENTE.Data) >= 1995;

db.Utente.find( {  Data : { $regex : /^1995/} }, { Nome:1, Cognome:1, Data:1}  ).explain("executionStats")



SELECT UTENTE.ID, UTENTE.Nome, UTENTE.Cognome, UTENTE.Cellulare
FROM UTENTE
WHERE UTENTE.Cellulare like "334%";

db.Utente.find({ Cellulare : { $regex : /^334/} } , {Nome:1, Cognome:1, Cellulare:1} ).explain("executionStats")
