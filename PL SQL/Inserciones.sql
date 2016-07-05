select * from l_paises;
select * from l_autores;


DESCRIBE L_GENEROS;

INSERT INTO L_GENEROS
VALUES (secuencia.nextVal, 'Intriga');
INSERT INTO L_GENEROS
VALUES (secuencia.nextVal, 'Fotografía');
INSERT INTO L_GENEROS
VALUES (secuencia.nextVal, 'Ciencia ficción');
INSERT INTO L_GENEROS
VALUES (secuencia.nextVal, 'Programación');
INSERT INTO L_GENEROS
VALUES (secuencia.nextVal, 'Aventuras');
INSERT INTO L_GENEROS
VALUES (secuencia.nextVal, 'Bases de datos');


INSERT INTO L_AUTORES
VALUES (secuencia.nextVal, 'Edgar', 'Allan Poe', null, null, null, null, null);

INSERT INTO L_AUTORES
VALUES (secuencia.nextVal, 'Robert Louis', 'Stevenson', 1784, null, 284, 'Siempre intrigante y polémico');

INSERT INTO L_AUTORES
VALUES (secuencia.nextVal, 'Naomi', 'Klein', null, 1970, null, 329, 'Born in Montreal in 1970, Naomi Klein is an award-winning journalist');

INSERT INTO L_AUTORES
VALUES (secuencia.nextVal, 'John', 'Dos Passos', 1896, 1970, null, 'Nació en Chicago en 1896, cuando Estados Unidos entró en la primera guerra mundial, se encontraba en España estudiando arquitectura');

INSERT INTO L_GENEROS
VALUES (secuencia.nextVal, 'Aventuras');

INSERT INTO L_GENEROS
VALUES (secuencia.nextVal, 'Intriga');


INSERT INTO L_EDITORIALES
VALUES (secuencia.nextVal, 'Anagrama');

INSERT INTO L_EDITORIALES
VALUES (secuencia.nextVal, 'Scholastic Press');



INSERT INTO L_IDIOMAS
VALUES (secuencia.nextVal, 'Español');

INSERT INTO L_IDIOMAS
VALUES (secuencia.nextVal, 'Inglés');

INSERT INTO L_PAISES
VALUES (secuencia.nextVal, 'España');
INSERT INTO L_PAISES
VALUES (secuencia.nextVal, 'Inglaterra');
INSERT INTO L_PAISES
VALUES (secuencia.nextVal, 'Alemania');
INSERT INTO L_PAISES
VALUES (secuencia.nextVal, 'Polonia');


SELECT * FROM L_EDICIONES;

SELECT * FROM V_LIBROS;

SELECT * FROM L_AUTORES;

update l_autores set biografia = 'Nacido en Nueva Inglaterra en el siglo XVIII'
where idautor = 13;

SELECT * FROM L_LIBROS;


SELECT * FROM L_EDITORIALES;

SELECT * FROM L_GENEROS;

SELECT * FROM L_IDIOMAS;

SELECT * FROM L_AUTORES;

EXEC INSERTAR_LIBRO ('123-456', 'El diablo de la botella', 41, 2, 21, 1980, 'Tercera', 52, 'Relatos de intriga y misterio');




COMMIT;

INSERT INTO L_LIBROS VALUES ('234-4567', 'MsDos', 2,  2, 2, null, default);

SELECT * FROM V_LIBROS;









