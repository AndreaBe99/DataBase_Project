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
