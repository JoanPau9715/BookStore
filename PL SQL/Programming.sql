-- Insertar libro


create or replace
PROCEDURE VER_DATOS_LIBRO
  (v_IdLibro IN INTEGER, 
   v_Stock OUT INTEGER, v_NumVentas OUT INTEGER)
AS 
BEGIN

    SELECT Stock, NumVentas
      INTO v_stock, v_numventas
      FROM LV_DATOS
     WHERE IDLIBRO = v_IdLibro; 
     
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
      BEGIN
        v_Stock := 0;
        v_NumVentas := 0;
      END;  

END VER_DATOS_LIBRO;


describe L_libros;
create or replace
PROCEDURE INSERTAR_LIBRO 
( v_ISBN IN VARCHAR2, TITULO IN VARCHAR2,
  AUTOR IN INTEGER, GENERO IN INTEGER, 
  EDITORIAL IN INTEGER, FECHAPUBLIC IN NUMBER,
  EDICION IN VARCHAR2, IDIOMA IN INTEGER, 
  SINOPSIS IN VARCHAR2, NUMPAGINAS IN INTEGER,
  NUMEJEMPLARES IN INTEGER, PRECIOLOTE IN NUMBER,
  FECHACOMPRA IN DATE, PRECIOVENTAUNIDAD IN NUMBER, 
  NUEVOID OUT INTEGER) 
AS
  PrecioCompraUnidad Number(5, 2);
BEGIN

  INSERT INTO L_LIBROS
    VALUES (secuencia.NextVal, v_isbn, InitCap(Lower(titulo)), 
            autor, genero, editorial, fechapublic, edicion, 
            idioma, sinopsis, numpaginas, default, default);

  
  SELECT secuencia.CurrVal
    INTO NUEVOID
    FROM DUAL;
               
  INSERT INTO L_COMPRAS 
    VALUES (secuencia.NextVal, nuevoid, numejemplares, preciolote, fechacompra);
    
  PrecioCompraUnidad := ROUND(preciolote / numejemplares, 2);
  
  INSERT INTO L_ALMACEN
    VALUES (nuevoid, numejemplares, preciocompraunidad, precioventaunidad, default);
            
  COMMIT;
  
END INSERTAR_LIBRO;



-- Modificar libro

create or replace
PROCEDURE MODIFICAR_LIBRO
( v_IdLibro IN INTEGER, v_ISBN IN VARCHAR2, v_TITULO IN VARCHAR2, 
  v_AUTOR IN INTEGER, v_GENERO IN INTEGER, v_EDITORIAL IN INTEGER, 
  v_FECHAPUBLIC IN NUMBER, v_EDICION IN VARCHAR2, v_IDIOMA IN INTEGER, 
  v_SINOPSIS IN VARCHAR2, v_NUMPAGINAS IN INTEGER) 
AS
BEGIN

  UPDATE L_LIBROS 
    SET Isbn = v_isbn, Titulo = InitCap(Lower(v_titulo)), Autor = v_autor,
        Genero = v_genero, Editorial = v_editorial, FechaPublic = v_fechapublic,
        Edicion = v_edicion, Idioma = v_idioma, Sinopsis = v_sinopsis, 
        NumPaginas = v_numpaginas
  WHERE IdLibro = v_IdLibro;
  
  COMMIT;

END MODIFICAR_LIBRO;



-- Borrar libro

create or replace
PROCEDURE BORRAR_LIBRO ( v_IdLibro IN INTEGER)
AS
BEGIN

  DELETE FROM L_LIBROS WHERE IdLibro = v_IdLibro;
  COMMIT;

END BORRAR_LIBRO;

-- Insertar autor

create or replace
PROCEDURE INSERTAR_AUTOR
(NOMBRE IN VARCHAR2, APELLIDOS IN VARCHAR2, SEUDONIMO IN VARCHAR2, KNOWNBY IN VARCHAR2,
 FECHANAC IN NUMBER, FECHADEF IN VARCHAR2, PAISNAC IN INTEGER, BIOGRAFIA IN VARCHAR2,
 NuevoID OUT INTEGER)
AS BEGIN

  if  (autor_Disponible(Nombre || ' ' || Apellidos) = 0) 
  and (autor_Disponible(Seudonimo) = 0)
  then

    INSERT INTO L_AUTORES
      VALUES(secuencia.nextVal, InitCap(Lower(nombre)), InitCap(Lower(apellidos)), 
             InitCap(Lower(seudonimo)), KnownBy,
             case when fechanac = 0 then null
                  else fechanac
             end, 
             case when fechadef = 0 then null
                  else fechadef
             end,                 
             paisnac, biografia);
                 
    COMMIT;
    
    SELECT secuencia.CurrVal
      INTO NUEVOID
      FROM DUAL;  

  else
    NuevoID := -1;
  end if;      
  
END INSERTAR_AUTOR;

-- Modificar autor

create or replace
PROCEDURE MODIFICAR_AUTOR
(v_IDAUTOR IN INTEGER, v_NOMBRE IN VARCHAR2, v_APELLIDOS IN VARCHAR2, v_SEUDONIMO IN VARCHAR2,
 v_KNOWNBY IN VARCHAR2,v_FECHANAC IN NUMBER, v_FECHADEF IN VARCHAR2, v_PAISNAC IN INTEGER, 
 v_BIOGRAFIA IN VARCHAR2, ok OUT INTEGER)
IS BEGIN

  if  (autor_Disponible(v_Nombre || ' ' || v_Apellidos, v_IdAutor) IN (0, 1)) 
  and (autor_Disponible(v_Seudonimo, v_IdAutor) IN (0, 1))
  then
    UPDATE L_AUTORES SET
      Nombre = InitCap(Lower(v_nombre)), Apellidos = InitCap(Lower(v_apellidos)), 
      Seudonimo = InitCap(Lower(v_seudonimo)), KnownBy = v_knownby,
      FechaNac =  case when v_fechanac = 0 then null
                  else v_fechanac
                  end, 
      FechaDef =  case when v_fechadef = 0 then null
                  else v_fechadef
                  end, 
      PaisNac = v_paisnac, Biografia = v_biografia
    WHERE
      IdAutor = v_idautor;
  
    COMMIT;
        
    ok := 1;

  else
    ok := -1;
  end if;  
  
END Modificar_Autor;

-- Borrar autor

create or replace
PROCEDURE BORRAR_AUTOR (v_IdAutor IN INTEGER)
IS 
  asignado EXCEPTION;
  libros INTEGER;
BEGIN

  SELECT COUNT(*)
    INTO libros
    FROM l_libros
   WHERE Autor = v_IdAutor;
  
  IF libros > 0 THEN    
    raise asignado;  
  ELSE  
    DELETE FROM L_AUTORES 
    WHERE idautor = v_idautor;  
  end if;

  COMMIT;
  
  EXCEPTION
    WHEN ASIGNADO THEN
    Raise_Application_Error(-20001, 'El autor tiene libros asignados. No puede ser borrado');
  
END;

-- Comprobar disponibilidad autor

create or replace 
FUNCTION autor_Disponible 
  (v_KnownAS IN VARCHAR2, v_IdAutor IN INTEGER := 0)
RETURN INTEGER IS
  disponible INTEGER;
BEGIN

  SELECT COUNT(*)
    INTO disponible
    FROM l_autores
   WHERE (Lower(Nombre) || ' ' || Lower(Apellidos) = Lower(v_knownas)
      OR  Lower(Seudonimo) = Lower(v_knownas))
     AND IdAutor <> v_IdAutor;
      
  RETURN disponible;      

END autor_Disponible;

-- Devolver Id de un autor 

create or replace
PROCEDURE devolver_id_autor
(KnownAs IN VARCHAR2, IdAutor OUT INTEGER)
AS BEGIN

  SELECT AUT.IdAutor
  INTO   IdAutor
  FROM   L_AUTORES AUT
  WHERE  Upper(AUT.nombre) || case 
         when AUT.Apellidos IS NOT NULL then ' ' || Upper(AUT.apellidos) 
         else '' end 
         = Upper(KnownAs)
     OR  Upper(Seudonimo) = Upper(KnownAs);
  
  EXCEPTION 
  WHEN NO_DATA_FOUND THEN
  IdAutor := -1;

END devolver_id_autor;



-- Insertar género

create or replace
PROCEDURE Insertar_Genero
 (v_Denom IN l_generos.denom%TYPE, ok OUT INTEGER)
IS BEGIN

  IF genero_Disponible(v_Denom) = 0 then
  
    INSERT INTO L_GENEROS 
      VALUES (secuencia.NextVal, InitCap(Lower(v_denom)));
    
    COMMIT;
    
    SELECT secuencia.CurrVal 
      INTO ok 
      FROM DUAL;
  
  ELSE    
    ok := -1;
  END IF;  
END Insertar_Genero;


-- Modificar género

create or replace
PROCEDURE Modificar_Genero
  (v_IdGenero IN l_generos.idgenero%TYPE,
   v_Denom IN l_generos.denom%TYPE, ok OUT INTEGER)
IS BEGIN

  IF genero_Disponible(v_Denom) IN (0, 1) then

    UPDATE L_Generos
       SET Denom = InitCap(Lower(v_Denom))
     WHERE IdGenero = v_idgenero;
    
    COMMIT; 
    
    ok := 1;
  ELSE    
    ok := -1;  
  END IF;  
END Modificar_Genero;


-- Borrar género

create or replace 
PROCEDURE Borrar_Genero
  (v_IdGenero IN l_generos.idgenero%TYPE)
IS BEGIN

  DELETE FROM L_GENEROS
   WHERE idgenero = V_IDGENERO;
   
  COMMIT;  

END Borrar_Genero;


-- Comprobar disponibilidad de un género

create or replace
FUNCTION genero_Disponible
 (v_Denom IN VARCHAR2)
RETURN INTEGER IS
  disponible INTEGER;
BEGIN

  SELECT COUNT(*)
    INTO disponible
    FROM L_GENEROS
   WHERE Lower(Denom) = Lower(v_Denom);
   
  RETURN disponible; 

END genero_Disponible;


-- devolver el id de un género

create or replace 
PROCEDURE devolver_Id_Genero
 (v_Denom IN l_editoriales.denom%TYPE, 
  v_IdGenero OUT l_generos.idgenero%TYPE)
IS BEGIN

  SELECT IdGenero
  INTO   v_IdGenero
  FROM   L_Generos
  WHERE  Upper(Denom) = Upper(v_Denom);
  
  EXCEPTION 
  WHEN NO_DATA_FOUND THEN
  v_IdGenero := -1;  

END devolver_Id_Genero;

-- prueba
set serveroutput on
declare idgenero integer;
begin
devolver_Id_Genero('Intriga', idgenero);
dbms_output.put_line(idgenero);
end;


-- Insertar una editorial

create or replace
PROCEDURE Insertar_Editorial
  (v_Denom IN l_editoriales.denom%TYPE, ok OUT INTEGER)
IS BEGIN

  if editorial_Disponible(v_denom) = 0 then
  
    INSERT INTO L_EDITORIALES
      VALUES (secuencia.NextVal, InitCap(Lower(v_Denom)));
    
    COMMIT;
    
    SELECT secuencia.CurrVal
      INTO ok
      FROM DUAL;
      
  ELSE
    ok := -1;
  END IF;
END Insertar_Editorial;


-- Modificar una editorial

create or replace
PROCEDURE Modificar_Editorial
  (v_IdEditorial IN l_editoriales.ideditorial%TYPE,
   v_Denom IN l_editoriales.denom%TYPE, ok OUT Integer)
IS BEGIN

  IF editorial_Disponible(v_Denom) IN (0, 1) then

    UPDATE L_Editoriales
       SET Denom = InitCap(Lower(v_Denom))
     WHERE IdEditorial = v_ideditorial;
    
    COMMIT; 
    
    ok := 1;
  ELSE    
    ok := -1;  
  END IF;    
END Modificar_Editorial;

-- Borrar una editorial

create or replace
PROCEDURE Borrar_Editorial
  (v_IdEditorial IN l_editoriales.ideditorial%TYPE)
IS BEGIN

  DELETE FROM L_EDITORIALES
    WHERE ideditorial = v_ideditorial;
    
  COMMIT;

END Borrar_Editorial;


-- Comprobar disponibilidad de una editorial

create or replace
FUNCTION editorial_Disponible
  (v_Denom IN VARCHAR2)
RETURN INTEGER IS
  disponible INTEGER;
BEGIN

  SELECT COUNT(*)
    INTO disponible
    FROM l_editoriales
   WHERE Lower(Denom) = Lower(v_Denom);
   
  RETURN disponible;

END editorial_Disponible;

-- devolver id de una editorial

create or replace 
PROCEDURE devolver_Id_Editorial
 (v_Denom IN l_editoriales.denom%TYPE, 
  v_IdEditorial OUT l_editoriales.ideditorial%TYPE)
IS BEGIN

  SELECT IdEditorial
  INTO   v_IdEditorial
  FROM   L_EDITORIALES
  WHERE  Upper(Denom) = Upper(v_Denom);
  
  EXCEPTION 
  WHEN NO_DATA_FOUND THEN
  v_IdEditorial := -1;  

END devolver_Id_Editorial;



-- Insertar idioma

create or replace PROCEDURE Insertar_Idioma
  (v_Denom IN l_idiomas.denom%TYPE, ok OUT INTEGER)
IS BEGIN

  IF idioma_Disponible(v_Denom) = 0 then
  
    INSERT INTO L_IDIOMAS
      VALUES (secuencia.nextVal, v_denom);
      
    COMMIT;
    
    SELECT secuencia.currVal
      INTO ok
      FROM dual;
      
  ELSE
    OK := -1;
  END IF;

END Insertar_Idioma;

-- Modificar idioma
create or replace PROCEDURE Modificar_Idioma
 (v_Ididioma IN l_idiomas.ididioma%TYPE,
  v_Denom IN l_idiomas.denom%TYPE)
IS BEGIN

  IF idioma_Disponible(v_Denom) IN (0, 1) then
  
    UPDATE L_IDIOMAS
       SET Denom = InitCap(Lower(v_Denom))
     WHERE IDIDIOMA = v_ididioma;
     
     COMMIT;
  
  end if;  

END Modificar_Idioma;

-- Borrar idioma
create or replace PROCEDURE Borrar_Idioma
  (v_IdIdioma IN l_idiomas.ididioma%TYPE)
IS BEGIN

  DELETE FROM L_IDIOMAS
   WHERE IDIDIOMA = V_IDIDIOMA;
   
  COMMIT;

END Borrar_Idioma;

-- comprobar disponibilidad de un idioma
create or replace FUNCTION idioma_Disponible
  (v_Denom IN VARCHAR2)
RETURN INTEGER
  IS disponible INTEGER;
BEGIN
  
  SELECT COUNT(*)
    INTO disponible
    FROM l_idiomas
   WHERE Lower(Denom) = Lower(v_Denom);
   
  RETURN disponible;  
  
END idioma_Disponible;

-- devolver el id de un idioma
create or replace 
PROCEDURE devolver_Id_Idioma
 (v_Denom IN l_Idiomas.denom%TYPE, 
  v_IdIdioma OUT l_Idiomas.idIdioma%TYPE)
IS BEGIN

  SELECT IdIdioma
  INTO   v_IdIdioma
  FROM   L_Idiomas
  WHERE  Upper(Denom) = Upper(v_Denom);
  
  EXCEPTION 
  WHEN NO_DATA_FOUND THEN
  v_IdIdioma := -1;  

END devolver_Id_Idioma;


-- Insertar un país


create or replace PROCEDURE Insertar_Pais
  (v_Denom IN l_paises.denom%TYPE, ok OUT INTEGER)
IS BEGIN

  IF pais_Disponible(v_denom) = 0 then
  
    INSERT INTO L_PAISES
      VALUES (secuencia.nextVal, InitCap(Lower(v_Denom)));
    
    commit;
    
    SELECT secuencia.currVal
      INTO ok
      FROM dual;
      
  else
    ok := -1;
  end if;

END Insertar_Pais;


create or replace PROCEDURE Modificar_Pais
  (v_IdPais IN l_paises.idpais%TYPE,
   v_Denom IN l_paises.denom%TYPE)
IS BEGIN

  IF pais_Disponible(v_denom) IN (0, 1) then
  
    UPDATE L_PAISES
       SET Denom = InitCap(Lower(v_Denom))
     WHERE IDPAIS = v_idpais;
     
     COMMIT;
  
  end if;

END Modificar_Pais;

create or replace PROCEDURE Borrar_Pais
  (v_IdPais IN l_paises.idpais%TYPE)
IS BEGIN

  DELETE FROM L_PAISES
   WHERE IDPAIS = V_IDPAIS;
   
  COMMIT;

END Borrar_Pais;

create or replace FUNCTION pais_Disponible
  (v_Denom IN VARCHAR2)
RETURN INTEGER
IS disponible INTEGER;
BEGIN

  SELECT COUNT(*)
    INTO disponible
    FROM l_paises
   WHERE Lower(Denom) = Lower(v_Denom);
   
  RETURN disponible; 

END pais_Disponible;

-- devover id de un pais

create or replace
PROCEDURE devolver_id_pais
(v_Denom IN VARCHAR2, IdPais OUT INTEGER)
AS BEGIN

  SELECT IdPais
  INTO   IdPais
  FROM   L_PAISES
  WHERE  Upper(Denom) = Upper(v_Denom);
  
  EXCEPTION 
  WHEN NO_DATA_FOUND THEN
  IdPais := -1;

END devolver_id_pais;








