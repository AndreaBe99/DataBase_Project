create database ForumFoto;

use ForumFoto;

create table PROVINCIA (
	Nome varchar(50) not null,
	Sigla varchar(2) not null,
	primary key (Nome)
) engine=INNODB;

create table CITTA (
	Nome varchar(50) not null,
	Provincia varchar(50) not null,
	primary key (Nome, Provincia),
	foreign key (Provincia) references PROVINCIA (Nome)
) engine=INNODB;

create table LUOGO (
	Via varchar(50) not null,
	Citta varchar(50) not null,
  Provincia varchar(50) not null,
	primary key (Via, Citta, Provincia),
	foreign key (Provincia) references CITTA (Provincia),
  foreign key (Citta) references CITTA (Nome)
) engine=INNODB;


create table STUDIO (
	ID int not null AUTO_INCREMENT,
	Nome varchar(50) not null,
	primary key (ID)
) engine=INNODB;


create table RISIEDE (
	ID_Studio int not null,
  Via varchar(50) not null,
  Citta varchar(50) not null,
  Provincia varchar(50) not null,
  primary key (ID_Studio, Via, Citta, Provincia),
  foreign key (Provincia) references LUOGO (Provincia),
  foreign key (Citta) references LUOGO (Citta),
  foreign key (Via) references LUOGO (Via),
  foreign key (ID_Studio) references STUDIO (ID)
) engine=INNODB;


create table UTENTE (
	NomeUtente varchar(50) not null,
	Nome varchar(50) not null,
	Cognome varchar(50) not null,
	Data date,
	Email varchar(50) not null,
	Cellulare varchar(50),
	ID_Studio int not null,
	primary key (NomeUtente),
	foreign key (ID_Studio) references STUDIO (ID)
) engine=INNODB;


create table ALBUM (
	NomeAlbum varchar(50) not null,
	Utente varchar(50) not null,
  Data date,
	primary key (NomeAlbum, Utente),
	foreign key (Utente) references UTENTE (NomeUtente)
) engine=INNODB;

create table CATEGORIA (
	Nome varchar(50) not null,
  Descrizione varchar(50) not null,
	primary key (Nome)
) engine=INNODB;

create table MARCA (
  Nome varchar(50) not null,
	primary key (Nome)
) engine=INNODB;

create table MACCHINA (
	Modello varchar(50) not null,
	Marca varchar(50) not null,
  Sensore int not null,
  Peso int not null,
	MaxISO int not null,
	primary key (Modello, Marca),
	foreign key (Marca) references MARCA (Nome)
) engine=INNODB;

create table OBIETTIVO (
	Modello varchar(50) not null,
  Marca varchar(50) not null,
  OIS bit not null,
  AF bit not null,
  Zoom int not null,
	primary key (Modello, Marca),
	foreign key (Marca) references MARCA (Nome)
) engine=INNODB;

create table COMPATTA (
	Macchina varchar(50) not null,
	MarcaMacchina varchar(50) not null,
  Obiettivo varchar(50) not null,
	MarcaObiettivo varchar(50) not null,
  ZoomDigitale int not null,
  StabilizzazioneDigitale bit not null,
	primary key (Macchina, MarcaMacchina, Obiettivo, MarcaObiettivo),
  foreign key (Macchina) references MACCHINA (Modello),
  foreign key (MarcaMacchina) references MACCHINA (Marca),
	foreign key (Obiettivo) references OBIETTIVO (Modello),
  foreign key (MarcaObiettivo) references OBIETTIVO (Marca)
) engine=INNODB;

create table REFLEX (
	Macchina varchar(50) not null,
	Marca varchar(50) not null,
  MotoreAF bit not null,
	primary key (Macchina, Marca),
  foreign key (Macchina) references MACCHINA (Modello),
  foreign key (Marca) references MACCHINA (Marca)
) engine=INNODB;

create table MONTA (
	Macchina varchar(50) not null,
	MarcaMacchina varchar(50) not null,
	Obiettivo varchar(50) not null,
	MarcaObiettivo varchar(50) not null,
  Attacco varchar(10) not null,
	primary key (Macchina, MarcaMacchina, Obiettivo, MarcaObiettivo),
  foreign key (Macchina) references REFLEX (Macchina),
	foreign key (MarcaMacchina) references REFLEX (Marca),
	foreign key (Obiettivo) references OBIETTIVO (Modello),
  foreign key (MarcaObiettivo) references OBIETTIVO (Marca)
) engine=INNODB;

create table FOTOGRAFIA (
	ID int not null AUTO_INCREMENT,
  Descrizione varchar(140) not null,
	Data date,
	NomeAlbum varchar(30) not null,
	NomeUtente varchar(30) not null,
	ID_Categoria varchar(30) not null,
	Via varchar(30) not null,
	Citta varchar(30) not null,
	Provincia varchar(30) not null,
	Macchina varchar(50) not null,
	MarcaMacchina varchar(50) not null,
	Obiettivo varchar(50) not null,
	MarcaObiettivo varchar(50) not null,
	LunghezzaFocale float not null,
	Angolo int not null,
	Diaframma float not null,
	Esposizione float not null,
	ISO int not null,
	Risoluzione int not null,
	primary key (ID),
  foreign key (NomeAlbum) references ALBUM (NomeAlbum),
  foreign key (NomeUtente) references ALBUM (Utente),
	foreign key (ID_Categoria) references CATEGORIA (Nome),
  foreign key (Via) references LUOGO (Via),
  foreign key (Citta) references LUOGO (Citta),
  foreign key (Provincia) references LUOGO (Provincia),
	foreign key (Macchina) references MACCHINA (Modello),
	foreign key (Obiettivo) references OBIETTIVO (Modello)
) engine=INNODB;

create table VOTO (
	NomeUtente varchar(30) not null,
	ID_Foto int not null,
	Voto int not null,
	Descrizione varchar(30),
	primary key (NomeUtente, ID_Foto),
  foreign key (NomeUtente) references ALBUM (Utente),
	foreign key (ID_Foto) references FOTOGRAFIA (ID)
) engine=INNODB;

insert into PROVINCIA value ("Viterbo", "VT");
insert into PROVINCIA value ("Roma", "RM");
insert into PROVINCIA value ("Latina", "LT");

insert into CITTA value ("Vetralla", "Viterbo");
insert into CITTA value ("Viterbo", "Viterbo");
insert into CITTA value ("Roma", "Roma");
insert into CITTA value ("Tivoli", "Roma");
insert into CITTA value ("Latina", "Latina");


insert into LUOGO value ("AB", "Vetralla", "Viterbo");
insert into LUOGO value ("CA", "Viterbo", "Viterbo");
insert into LUOGO value ("BB", "Roma", "Roma");
insert into LUOGO value ("AB", "Tivoli", "Roma");
insert into LUOGO value ("BB", "Latina", "Latina");

insert into STUDIO (Nome) value ("StudioVT");
insert into STUDIO (Nome) value ("StudioRM1");
insert into STUDIO (Nome) value ("StudioRM2");

insert into RISIEDE value (1, "AB", "Vetralla", "Viterbo");
insert into RISIEDE value (1, "CA", "Viterbo", "Viterbo");
insert into RISIEDE value (2, "BB", "Roma", "Roma");
insert into RISIEDE value (3, "AB", "Tivoli", "Roma");
insert into RISIEDE value (2, "BB", "Latina", "Latina");

insert into UTENTE value ("AndBer", "Andrea", "Bernini", '1999-01-24', "andreabe99@gmail.com", "3342130932", 1);
insert into UTENTE value ("MarRos", "Marco", "Rossi", '1999-04-29', "marcoro99@gmail.com", "3353498763", 1);
insert into UTENTE value ("GiaVer", "Giacomo", "Verdi", '1992-11-12', "giacomove92@gmail.com", "3319303549", 2);
insert into UTENTE value ("MatGia", "Matteo", "Gialli", '1993-09-02', "matteogi93@gmail.com", "3330382384", 2);
insert into UTENTE value ("LucNer", "Luca", "Neri", '1996-02-24', "lucane96@gmail.com", "33394123452", 3);

insert into ALBUM value ("Paesaggi", "AndBer", '2019-02-22');
insert into ALBUM value ("Animali", "AndBer", '2019-04-02');
insert into ALBUM value ("Ritratti", "MarRos", '2018-02-22');
insert into ALBUM value ("Citta", "MarRos", '2019-06-10');
insert into ALBUM value ("Ritratti", "GiaVer", '2019-01-23');
insert into ALBUM value ("Edifici", "MatGia", '2019-11-01');
insert into ALBUM value ("Paesaggi", "LucNer", '2019-12-22');

insert into CATEGORIA value ("Natura", "abcd");
insert into CATEGORIA value ("Persone", "efgh");
insert into CATEGORIA value ("Oggetti", "ilmn");

insert into MARCA value ("Nikon");
insert into MARCA value ("Sony");
insert into MARCA value ("Leica");

/* modello, marca, SensoreDiagonale, peso, MaxISO*/
insert into MACCHINA value ("ni12", "Nikon", 43, 280, 6400);
insert into MACCHINA value ("ni34", "Nikon", 28, 230, 5000);
insert into MACCHINA value ("sn07", "Sony", 43, 300, 4000);
insert into MACCHINA value ("sn12", "Sony", 21, 200, 5000);
insert into MACCHINA value ("Le32", "Leica", 54, 400, 6400);

/*modello, marca, OIS, AF, ZoomX */
insert into OBIETTIVO value ("Obiettivo1", "Nikon", 0, 1, 50);
insert into OBIETTIVO value ("Obiettivo2", "Sony", 1, 1, 100);
insert into OBIETTIVO value ("Obiettivo3", "Leica", 1, 0, 100);
insert into OBIETTIVO value ("Obiettivo4", "Sony", 0, 1, 50);
insert into OBIETTIVO value ("Obiettivo5", "Nikon", 1, 1, 100);

/* macchina, MarcaMacchina, obiettivo, MarcaObiettivo, ZoomDigitale, StabilizzazioneDigitale*/
insert into COMPATTA value ("sn07", "Sony", "Obiettivo4", "Sony", 100, 1);
insert into COMPATTA value ("Le32", "Leica", "Obiettivo3", "Leica", 100, 1);

/* macchina, MarcaMacchina, motoreAF*/
insert into REFLEX value ("ni12", "Nikon", 0);
insert into REFLEX value ("ni34", "Nikon", 1);
insert into REFLEX value ("sn12", "Sony", 1);

/*macchina, MarcaMacchina, obiettivo, MarcaObiettivo, Attacco*/
insert into MONTA value ("ni12", "Nikon", "Obiettivo1", "Nikon", "BF");
insert into MONTA value ("ni12", "Nikon", "Obiettivo5", "Nikon", "BF");
insert into MONTA value ("ni34", "Nikon", "Obiettivo1", "Nikon", "BF");
insert into MONTA value ("ni34", "Nikon", "Obiettivo5", "Nikon", "BF");
insert into MONTA value ("sn12", "Sony", "Obiettivo2",  "Sony", "CS");

/*IDauotinc, Descrizione, Data, NomeAlbum, NomeUtente, Categoria, via, citta, provincia, macchina, obiettivo, LunghezzaFocale, angolo, diaframma, esposizione, ISO, Risoluzione*/
insert into FOTOGRAFIA (Descrizione, Data, NomeAlbum, NomeUtente, ID_Categoria, Via, Citta, Provincia, Macchina, MarcaMacchina, Obiettivo, MarcaObiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("a", '2019-01-01', "Paesaggi", "AndBer", "Natura",  "AB", "Vetralla", "Viterbo",  "ni12", "Nikon", "Obiettivo5", "Nikon", 52, 70,  2.0, 10, 200,  1080);
insert into FOTOGRAFIA (Descrizione, Data, NomeAlbum, NomeUtente, ID_Categoria, Via, Citta, Provincia, Macchina, MarcaMacchina, Obiettivo, MarcaObiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("b", '2019-03-02', "Animali",  "AndBer", "Natura",  "CA", "Viterbo",  "Viterbo",  "ni12", "Nikon", "Obiettivo1", "Nikon", 44, 110, 2.5, 80, 1000, 1440);
insert into FOTOGRAFIA (Descrizione, Data, NomeAlbum, NomeUtente, ID_Categoria, Via, Citta, Provincia, Macchina, MarcaMacchina, Obiettivo, MarcaObiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("c", '2019-02-03', "Animali",  "AndBer", "Natura",  "BB", "Roma",     "Roma",     "sn07", "Sony",  "Obiettivo4", "Sony",  48, 60,  2.3, 80, 1200, 720);
insert into FOTOGRAFIA (Descrizione, Data, NomeAlbum, NomeUtente, ID_Categoria, Via, Citta, Provincia, Macchina, MarcaMacchina, Obiettivo, MarcaObiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("d", '2019-06-04', "Ritratti", "MarRos", "Persone", "AB", "Vetralla", "Viterbo",  "ni34", "Nikon", "Obiettivo1", "Nikon", 44, 70,  2.2, 40, 1300, 1440);
insert into FOTOGRAFIA (Descrizione, Data, NomeAlbum, NomeUtente, ID_Categoria, Via, Citta, Provincia, Macchina, MarcaMacchina, Obiettivo, MarcaObiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("e", '2019-06-04', "Citta",    "MarRos", "Oggetti", "AB", "Tivoli",   "Roma",     "ni34", "Nikon", "Obiettivo5", "Nikon", 52, 120, 2.1, 30, 800,  1080);
insert into FOTOGRAFIA (Descrizione, Data, NomeAlbum, NomeUtente, ID_Categoria, Via, Citta, Provincia, Macchina, MarcaMacchina, Obiettivo, MarcaObiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("f", '2019-04-05', "Citta",    "MarRos", "Oggetti", "BB", "Latina",   "Latina",   "ni34", "Nikon", "Obiettivo5", "Nikon", 52, 60,  1.8, 20, 200,  1440);
insert into FOTOGRAFIA (Descrizione, Data, NomeAlbum, NomeUtente, ID_Categoria, Via, Citta, Provincia, Macchina, MarcaMacchina, Obiettivo, MarcaObiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("g", '2019-01-06', "Ritratti", "GiaVer", "Persone", "AB", "Tivoli",   "Viterbo",  "sn12", "Sony",  "Obiettivo2", "Sony",  72, 70,  1.7, 40, 100,  1080);
insert into FOTOGRAFIA (Descrizione, Data, NomeAlbum, NomeUtente, ID_Categoria, Via, Citta, Provincia, Macchina, MarcaMacchina, Obiettivo, MarcaObiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("h", '2019-01-06', "Ritratti", "GiaVer", "Oggetti", "CA", "Viterbo",  "Viterbo",  "sn12", "Sony",  "Obiettivo2", "Sony",  72, 70,  1.4, 60, 300,  720);
insert into FOTOGRAFIA (Descrizione, Data, NomeAlbum, NomeUtente, ID_Categoria, Via, Citta, Provincia, Macchina, MarcaMacchina, Obiettivo, MarcaObiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("i", '2019-08-07', "Edifici",  "MatGia", "Oggetti", "BB", "Latina",   "Latina",   "le32", "Leica", "Obiettivo3", "Leica", 52, 120, 1.9, 90, 700,  1440);
insert into FOTOGRAFIA (Descrizione, Data, NomeAlbum, NomeUtente, ID_Categoria, Via, Citta, Provincia, Macchina, MarcaMacchina, Obiettivo, MarcaObiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("l", '2019-08-07', "Edifici",  "MatGia", "Oggetti", "CA", "Viterbo",  "Viterbo",  "le32", "Leica", "Obiettivo3", "Leica", 52, 180, 1.8, 10, 1200, 720);
insert into FOTOGRAFIA (Descrizione, Data, NomeAlbum, NomeUtente, ID_Categoria, Via, Citta, Provincia, Macchina, MarcaMacchina, Obiettivo, MarcaObiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("m", '2019-11-08', "Paesaggi", "LucNer", "Natura",  "AB", "Vetralla", "Viterbo",  "sn07", "Sony",  "Obiettivo4", "Sony",  48, 50,  2.2, 60, 2200, 1440);
insert into FOTOGRAFIA (Descrizione, Data, NomeAlbum, NomeUtente, ID_Categoria, Via, Citta, Provincia, Macchina, MarcaMacchina, Obiettivo, MarcaObiettivo, LunghezzaFocale, Angolo, Diaframma, Esposizione, ISO, Risoluzione) value ("n", '2019-12-09', "Paesaggi", "LucNer", "Natura",  "BB", "Roma",     "Roma",     "ni34", "Nikon", "Obiettivo5", "Nikon", 52, 70,  2.0, 30, 2600, 1440);

/* NomeUtente, ID_Foto, Voto, Descrizione*/
insert into VOTO value ("AndBer", 1, 8, "abcdefg");
insert into VOTO value ("AndBer", 5, 6, "jfhldsdg");
insert into VOTO value ("AndBer", 6, 8, "abcdefg");
insert into VOTO value ("AndBer", 7, 7, "jfhldsdg");
insert into VOTO value ("AndBer", 8, 5, "abcdefg");
insert into VOTO value ("AndBer", 9, 6, "jfhldsdg");
insert into VOTO value ("MarRos", 10, 7, "gfhgfhsfhf");
insert into VOTO value ("MarRos", 11, 5, "dfhfdffd");
insert into VOTO value ("MarRos", 12, 10, "dfhfdffd");
insert into VOTO value ("MarRos", 8, 7, "gfhgfhsfhf");
insert into VOTO value ("GiaVer", 1, 8, "fdfdhfhf");
insert into VOTO value ("GiaVer", 2, 7, "dfhhghsfreh");
insert into VOTO value ("GiaVer", 3, 8, "fdfdhfhf");
insert into VOTO value ("GiaVer", 6, 7, "dfhhghsfreh");
insert into VOTO value ("MatGia", 7, 6, "bnbnhytery");
insert into VOTO value ("MatGia", 8, 5, "cuyowcieui");
insert into VOTO value ("MatGia", 1, 6, "bnbnhytery");
insert into VOTO value ("MatGia", 2, 8, "cuyowcieui");
insert into VOTO value ("LucNer", 1, 9, "dey7398hce");
insert into VOTO value ("LucNer", 5, 7, "cbuebcuooe");
insert into VOTO value ("LucNer", 6, 4, "eqvuicoie");




/*	Mostrare il numero di foto per ogni categoria	*/
SELECT CATEGORIA.Nome, COUNT(*) as NumeroFoto
FROM FOTOGRAFIA, CATEGORIA
WHERE FOTOGRAFIA.ID_Categoria = CATEGORIA.Nome
GROUP BY CATEGORIA.Nome;



/*	Mostrare il numero di utenti registrati raggruppandoli per anno di
		nascita	*/
SELECT YEAR(UTENTE.Data) as Anno, COUNT(UTENTE.NomeUtente) as NumUtenti
FROM UTENTE
GROUP BY YEAR(UTENTE.Data);



/* Mostrare gli utenti nati dopo il 1995	*/
SELECT UTENTE.NomeUtente, UTENTE.Nome, UTENTE.Cognome
FROM UTENTE
WHERE YEAR(UTENTE.Data) >= 1995;



/* Mostrare gli utenti che lavorano per gli studi che hanno sedi nella
	 provincia di Roma */
SELECT UTENTE.NomeUtente, UTENTE.Nome, UTENTE.Cognome
FROM UTENTE, STUDIO, RISIEDE
WHERE UTENTE.ID_Studio = STUDIO.ID and RISIEDE.ID_Studio=STUDIO.ID and
		RISIEDE.Provincia = "Roma";



/* Mostrare il numero di studi presenti nella provincia di Roma */
SELECT COUNT(*) as NumeroStudi
FROM RISIEDE
WHERE RISIEDE.Provincia = "Roma";



/* Mostrare il numero di studi presenti in ciascuna provincia*/
SELECT RISIEDE.Provincia, COUNT(*) as NumeroStudi
FROM RISIEDE
GROUP BY RISIEDE.Provincia;



/* Mostrare il numero di album pubblicati da ogni utente in ordine decrescente */
SELECT ALBUM.Utente, COUNT(ALBUM.NomeAlbum) as NumeroAlbum
FROM ALBUM
GROUP BY ALBUM.Utente
ORDER BY COUNT(ALBUM.NomeAlbum) DESC;



/* Mostrare il numero di fotografie scattate da ciascuna macchina in
	ordine ascendente con il TOTALE Finale*/
SELECT COALESCE(FOTOGRAFIA.Macchina, 'TotaleFoto') as Modello, MarcaMacchina, COUNT(*) as NumFoto
FROM FOTOGRAFIA
GROUP BY FOTOGRAFIA.Macchina WITH rollup
ORDER BY COUNT(*);



/*	Stampare gli utenti che hanno il numero di cellulare che inizia per 334 */
SELECT UTENTE.NomeUtente, UTENTE.Nome, UTENTE.Cognome, UTENTE.Cellulare
FROM UTENTE
WHERE UTENTE.Cellulare like "334%";



/* Per ogni utente fare una media dei voti delle prorie foto */
SELECT UTENTE.NomeUtente, UTENTE.Nome, UTENTE.Cognome, AVG(VOTO.Voto) as MediaVoti
FROM UTENTE, VOTO
WHERE VOTO.NomeUtente = UTENTE.NomeUtente
GROUP BY UTENTE.NomeUtente
ORDER BY AVG(VOTO.Voto);



/* Stampare l'album con la media voti minore */
/*** NIDIFICATA ****/
SELECT T1.NomeAlbum, T1.NomeUtente, MIN(T1.NumeroVoti) as MaxVoti
FROM (
	SELECT FOTOGRAFIA.NomeAlbum, FOTOGRAFIA.NomeUtente, AVG(VOTO.Voto) as MediaVoti
	FROM VOTO, FOTOGRAFIA
	WHERE VOTO.ID_Foto = FOTOGRAFIA.ID
	GROUP BY FOTOGRAFIA.NomeAlbum, FOTOGRAFIA.NomeUtente) as T1;
/*** NORMALE ****/
SELECT FOTOGRAFIA.NomeAlbum, FOTOGRAFIA.NomeUtente, AVG(VOTO.Voto) as MediaVoti
FROM VOTO, FOTOGRAFIA
WHERE VOTO.ID_Foto = FOTOGRAFIA.ID
GROUP BY FOTOGRAFIA.NomeAlbum, FOTOGRAFIA.NomeUtente
ORDER BY AVG(VOTO.Voto) LIMIT 1;



/* Stampare l'album con piu voti */
/*** NIDIFICATA ****/
SELECT T1.NomeAlbum, T1.NomeUtente, MAX(T1.NumeroVoti) as MaxVoti
FROM (
	SELECT FOTOGRAFIA.NomeAlbum, FOTOGRAFIA.NomeUtente, COUNT(VOTO.Voto) as NumeroVoti
	FROM VOTO, FOTOGRAFIA
	WHERE VOTO.ID_Foto = FOTOGRAFIA.ID
	GROUP BY FOTOGRAFIA.NomeAlbum, FOTOGRAFIA.NomeUtente) as T1;
/*** NORMALE ****/
SELECT FOTOGRAFIA.NomeAlbum, FOTOGRAFIA.NomeUtente, COUNT(VOTO.Voto) as NumeroVoti
FROM VOTO, FOTOGRAFIA
WHERE VOTO.ID_Foto = FOTOGRAFIA.ID
GROUP BY FOTOGRAFIA.NomeAlbum, FOTOGRAFIA.NomeUtente
ORDER BY COUNT(VOTO.Voto) DESC LIMIT 1;



/*	Stampare il modello di macchina più usato*/
SELECT FOTOGRAFIA.Macchina, FOTOGRAFIA.MarcaMacchina, COUNT(*) as Usato
FROM FOTOGRAFIA
GROUP BY FOTOGRAFIA.Macchina
ORDER BY COUNT(*) DESC LIMIT 1;



/* Stampare le macchine compatibili solo con l'Obiettivo5 */
SELECT MONTA.Attacco, MONTA.Macchina, MONTA.MarcaMacchina
FROM MONTA
WHERE MONTA.Obiettivo = "Obiettivo5";



/* Trovare gli utenti che hanno pubblicato un album dopo il giorno in cui AndBer
 		ha pubblicato l'album Animali */
SELECT UTENTE.NomeUtente, UTENTE.Nome, UTENTE.Cognome, ALBUM.NomeAlbum, ALBUM.Data
FROM UTENTE, ALBUM, ALBUM as A
WHERE ALBUM.Utente = UTENTE.NomeUtente and ALBUM.Data > A.Data and
A.NomeAlbum = "Animali" and A.Utente = "AndBer";



/* Trovare gli utenti che hanno messo lo stesso voto di AndBer alla foto con ID=8 */
SELECT UTENTE.NomeUtente, UTENTE.Nome, UTENTE.Cognome, VOTO.Voto
FROM UTENTE, VOTO, VOTO as V
WHERE VOTO.NomeUtente = UTENTE.NomeUtente and VOTO.ID_Foto = V.ID_Foto and
VOTO.Voto = V.Voto and V.NomeUtente = "AndBer" and V.ID_Foto=8;



/* Mostrare tutte le foto (e da chi sono scattate) che hanno angolo superiore
	alla foto con ID=2*/
SELECT UTENTE.NomeUtente, UTENTE.Nome, UTENTE.Cognome, FOTOGRAFIA.ID, FOTOGRAFIA.NomeAlbum, FOTOGRAFIA.Angolo
FROM UTENTE, ALBUM, FOTOGRAFIA, FOTOGRAFIA as F
WHERE ALBUM.Utente = UTENTE.NomeUtente and FOTOGRAFIA.NomeAlbum = ALBUM.NomeAlbum and FOTOGRAFIA.NomeUtente = ALBUM.Utente and
FOTOGRAFIA.Angolo > F.Angolo and F.ID=2;



/* Mostrare tutte le foto pubblicate tra il 2019-06-01 e il 2019-09-01*/
SELECT FOTOGRAFIA.NomeUtente, FOTOGRAFIA.NomeAlbum, FOTOGRAFIA.Data
FROM FOTOGRAFIA
WHERE FOTOGRAFIA.Data between '2019-06-01' and '2019-09-01';



/* Mostrare tutte le foto pubblicate nel mese di giugno di qulasiadi anno*/
SELECT FOTOGRAFIA.NomeUtente, FOTOGRAFIA.NomeAlbum, FOTOGRAFIA.Data
FROM FOTOGRAFIA
WHERE MONTH(FOTOGRAFIA.Data) = 6;



/* Stampare tutti gli utenti che hanno scattato foto nelle stesse Citta in cui ha
scattato AndBer */
SELECT UTENTE.NomeUtente, UTENTE.Nome, UTENTE.Cognome, FOTOGRAFIA.Citta
FROM UTENTE, ALBUM, FOTOGRAFIA, FOTOGRAFIA as F
WHERE ALBUM.Utente = UTENTE.NomeUtente and FOTOGRAFIA.NomeUtente = ALBUM.Utente
and FOTOGRAFIA.NomeAlbum = ALBUM.NomeAlbum and FOTOGRAFIA.Citta = F.Citta
and F.NomeUtente = "AndBer";



/* Stampare l'obiettivo usato più volte insieme alla macchina ni34 */
SELECT FOTOGRAFIA.Obiettivo, COUNT(FOTOGRAFIA.OBIETTIVO) as UsatoNUM, FOTOGRAFIA.MarcaObiettivo
FROM FOTOGRAFIA
WHERE FOTOGRAFIA.Macchina = "ni34"
GROUP BY FOTOGRAFIA.Obiettivo
ORDER BY COUNT(FOTOGRAFIA.Obiettivo) DESC LIMIT 1;







delimiter //
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
delimiter ;
DROP TRIGGER TR_VOTO_Voto;
insert into VOTO value ("LucNer", 4, 12, "eqvuicoie");



delimiter //
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
delimiter ;
DROP TRIGGER TR_FOTO_Angolo;



delimiter //
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
delimiter ;

Angolo = 360/pGreco * arctan(DimensioneSensore/ 2*LunghezzaFocale)
DROP TRIGGER TR_FOTO_LunghezzFocale;
insert into FOTOGRAFIA (Descrizione, Data, NomeAlbum, NomeUtente, ID_Categoria, Via, Citta, Provincia, Macchina, MarcaMacchina, Obiettivo, MarcaObiettivo, LunghezzaFocale, Diaframma, Esposizione, ISO, Risoluzione) value ("n", '2019-12-09', "Paesaggi", "LucNer", "Natura",  "BB", "Roma", "Roma", "ni34", "Nikon", "Obiettivo5", "Nikon", 52,  2.0, 30, 2600, 1440);
/*
SELECT DISTINCT DEGREES(2*ATAN((MACCHINA.Sensore)/ (2*FOTOGRAFIA.LunghezzaFocale))) as Angolo
FROM MACCHINA, FOTOGRAFIA
WHERE FOTOGRAFIA.Macchina = MACCHINA.Modello
		and FOTOGRAFIA.MarcaMacchina = MACCHINA.Marca and
		FOTOGRAFIA.Macchina = "ni34" and FOTOGRAFIA.MarcaMacchina = "Nikon";
*/




delimiter //
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
delimiter ;
DROP TRIGGER TR_FOTO_Diaframma;



delimiter //
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
delimiter ;
insert into FOTOGRAFIA (Descrizione, Data, NomeAlbum, NomeUtente, ID_Categoria, Via, Citta, Provincia, Macchina, MarcaMacchina, Obiettivo, MarcaObiettivo, LunghezzaFocale, Diaframma, Esposizione, ISO, Risoluzione) value ("n", '2019-12-09', "Paesaggi", "LucNer", "Natura",  "BB", "Roma", "Roma", "ni34", "Nikon", "Obiettivo5", "Nikon", 52,  2.0, 30, 7000, 1440);

/*
SELECT DISTINCT MACCHINA.MaxISO
		FROM MACCHINA, FOTOGRAFIA
		WHERE FOTOGRAFIA.Macchina = MACCHINA.Modello
		and FOTOGRAFIA.MarcaMacchina = MACCHINA.Marca and FOTOGRAFIA.Macchina="ni34";
	*/






DELIMITER //
CREATE PROCEDURE FotoCitta(IN citta VARCHAR(255))
	BEGIN
	  SELECT * FROM FOTOGRAFIA WHERE FOTOGRAFIA.Citta = citta;
	END //
DELIMITER ;
CALL FotoCitta ("Viterbo");
SELECT @a;



delimiter //
CREATE PROCEDURE proceduraAngolo(IN LunghezzaFocale float, DimensioneSensore float, OUT Angolo float)
	BEGIN
			SET Angolo = DEGREES(2*ATAN((DimensioneSensore)/ (2*LunghezzaFocale)))
	END;//
delimiter ;



DROP PROCEDURE IF EXISTS trovaUtente;
delimiter //
CREATE PROCEDURE trovaUtente(IN nome VARCHAR(20), cognome VARCHAR(20), OUT nomeUtente VARCHAR(20))
BEGIN
   DECLARE appoggio VARCHAR(20);
   DECLARE cercaUtente CURSOR FOR SELECT UTENTE.NomeUtente FROM UTENTE WHERE UTENTE.Nome = nome and UTENTE.Cognome = cognome;
   OPEN cercaUtente;
   FETCH cercaUtente INTO appoggio;
   CLOSE cercaUtente;
   SET nomeUtente = appoggio;
END;//
delimiter ;
CALL trovaUtente("Andrea", "Bernini", @a);
SELECT @a;



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









/* Vista per calcolare la media dei voti per ogni album */
CREATE VIEW MediaVotiAlbum AS (Media_NomeAlbum, Media_NomeUtente, Media_MediaVoti)
SELECT FOTOGRAFIA.NomeAlbum, FOTOGRAFIA.NomeUtente, AVG(VOTO.Voto) as MediaVoti
FROM VOTO, FOTOGRAFIA
WHERE VOTO.ID_Foto = FOTOGRAFIA.ID
GROUP BY FOTOGRAFIA.NomeAlbum, FOTOGRAFIA.NomeUtente;

/* Vista per calcolare la media dei voti per ogni utente */
CREATE VIEW MediaVotiAlbum AS (Media_NomeUtente, Media_MediaVoti)
SELECT FOTOGRAFIA.NomeUtente, AVG(VOTO.Voto) as MediaVoti
FROM VOTO, FOTOGRAFIA
WHERE VOTO.ID_Foto = FOTOGRAFIA.ID
GROUP BY FOTOGRAFIA.NomeUtente;

/* Vista che data una macchina mostra tutti gli obiettivi compatibili */
CREATE VIEW ObiettiviCompatibili AS (Media_NomeUtente, Media_MediaVoti)
SELECT MONTA.Macchina, MONTA.MarcaMacchina, MONTA.Obiettivo, MONTA.MarcaObiettivo, MONTA.Attacco
FROM MONTA;
