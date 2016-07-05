create or replace
PROCEDURE INSERTAR_LIBRO 
( ISBN IN VARCHAR2, TITULO IN VARCHAR2, 
  AUTOR IN INTEGER, GENERO IN INTEGER, 
  EDITORIAL IN INTEGER, FECHAPUBLIC IN NUMBER,
  EDICION IN INTEGER, IDIOMA IN INTEGER, SINOPSIS IN VARCHAR2) 
AS
BEGIN
    
  INSERT INTO L_LIBROS
    VALUES (isbn, titulo, autor, genero, editorial, fechapublic, edicion, idioma, sinopsis, default);
  
  COMMIT;

END INSERTAR_LIBRO;

create or replace procedure mostrar
as begin
  select table_name from user_tables;
end mostrar;

/* siguiente */

create or replace
PROCEDURE devolver_id_autor
(Nombre L_AUTORES.NOMBRE%type, Apellidos L_AUTORES.APELLIDOS%type, IdAutor OUT INTEGER)
AS BEGIN

  SELECT AUT.IdAutor
  INTO   IdAutor
  FROM   L_AUTORES AUT
  WHERE  AUT.nombre = nombre 
  AND    AUT.APELLIDOS = apellidos;

END devolver_id_autor;


/* siguiente */

create or replace
FUNCTION Devolver_codigo_autor
(Nombre L_AUTORES.NOMBRE%type, Apellidos L_AUTORES.APELLIDOS%type)
RETURN INTEGER IS
  CodigoAutor INTEGER;
BEGIN

  SELECT AUT.IdAutor
  INTO   CodigoAutor
  FROM   L_AUTORES AUT
  WHERE  AUT.nombre = nombre 
  AND    AUT.APELLIDOS = apellidos;
  
  RETURN Codigoautor;

END Devolver_codigo_autor;