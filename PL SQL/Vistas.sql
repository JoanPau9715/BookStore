-- Vista libros


create or replace 
VIEW LV_DISPLAY_LIBROS
  (IdLibro,Titulo, ISBN, Edicion, Autor, Genero, Editorial)
AS SELECT

    LIB.IdLibro, LIB.Titulo, LIB.ISBN, LIB.Edicion,
    AUT.Nombre || DECODE(AUT.Apellidos, null, '', AUT.Apellidos), 
    GEN.Denom, ED.Denom
    
   FROM L_LIBROS LIB JOIN L_AUTORES AUT ON LIB.AUTOR = AUT.IDAUTOR
                     JOIN L_GENEROS GEN ON LIB.GENERO = GEN.IDGENERO
                     JOIN L_EDITORIALES ED ON LIB.EDITORIAL = ED.IDEDITORIAL
;


create or replace
VIEW LV_LIBROS
  (IDLibro, ISBN, Titulo, Edicion, FechaPublic, Sinopsis, NumPaginas,
   AutorNCompleto, DenomGenero, DenomEditorial, DenomIdioma)
AS SELECT
     L.IdLibro, L.ISBN, L.Titulo, L.Edicion, 
     L.FechaPublic, L.Sinopsis, L.NumPaginas,
     case 
        when AUT.KnownBy = 'Nombre real' 
          then  AUT.Nombre || case 
                 when AUT.Apellidos IS NOT NULL then ' ' || AUT.apellidos 
                 else '' end
        else
          AUT.Seudonimo
     end,
     G.Denom, ED.Denom, I.Denom
   FROM L_LIBROS L
   JOIN L_AUTORES AUT
     ON L.Autor = AUT.IdAutor
   JOIN L_GENEROS G
     ON L.Genero = G.IdGenero
   JOIN L_EDITORIALES ED
     ON L.Editorial = ED.IdEditorial
   JOIN L_IDIOMAS I
     ON L.Idioma = I.IdIdioma
     
WITH READ ONLY

-- Vista autores

create or replace
VIEW LV_AUTORES
  (IDAutor, Nombre, Apellidos, NCompleto, Seudonimo, 
   KnownBy, Biografia, FechaNac, FechaDef, PaisNac)
AS SELECT
     AUT.IdAutor, AUT.Nombre, AUT.Apellidos, AUT.Nombre || ' ' || AUT.Apellidos,
     AUT.Seudonimo, AUT.KnownBy, AUT.Biografia, AUT.FechaNac, AUT.FechaDef, P.Denom
   FROM L_AUTORES AUT
   JOIN L_PAISES P
     ON AUT.PaisNac = P.IdPais
WITH READ ONLY


-- vista datos de cada libro


create or replace
VIEW LV_DATOS
  (IdLibro, Stock, NumVentas)
AS SELECT 

      L.IdLibro, AL.Stock, COUNT(V.IdLibro)
      
    FROM L_LIBROS L
    JOIN L_ALMACEN AL
      ON L.IDLIBRO = AL.IDLIBRO
    LEFT OUTER JOIN L_VENTAS V
      ON L.IDLIBRO = V.IDLIBRO
      
    group by L.IdLibro, AL.Stock
    
WITH READ ONLY

create or replace
VIEW LV_CLIENTES_INTERESES
AS SELECT

      CL.Nick, GEN.Denom, INF.TipoAviso
    
    FROM L_CLIENTES CL
         JOIN L_INFO_NOVEDADES INF 
         ON CL.IDCLIENTE = INF.IDCLIENTE
         JOIN L_GENEROS GEN
         ON INF.IDGENERO = GEN.IDGENERO

WITH READ ONLY
      





  
    
  

