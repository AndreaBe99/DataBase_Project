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
