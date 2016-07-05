
create or replace 
TRIGGER comprueba_Known
  BEFORE INSERT OR UPDATE ON L_AUTORES
  FOR EACH ROW
DECLARE
  notknown EXCEPTION;
BEGIN

  if (:new.KnownBy = 'Nombre real') and
     (:new.Nombre IS NULL) then
     
     raise notknown;
       
  elsif (:new.KnownBy = 'Seudónimo') and
     (:new.Seudonimo IS NULL) then
     
     raise notknown;
     
  end if;
  
  EXCEPTION
    WHEN notknown THEN
     raise_application_error(-20001, 'Datos incorrectos');    

END comprueba_Known;


create or replace 
TRIGGER update_idautor
  BEFORE UPDATE OF IdAutor ON L_AUTORES
  FOR EACH ROW
BEGIN

  UPDATE L_LIBROS
     SET Autor = :new.IdAutor
   WHERE Autor = :old.IdAutor;

END update_idautor;


create or replace
TRIGGER no_borrar_almacen
  BEFORE DELETE ON L_ALMACEN
  FOR EACH ROW
DECLARE
  filas INTEGER;
  noborrar EXCEPTION;
BEGIN

  SELECT COUNT(*) 
    INTO filas 
    FROM L_LIBROS L 
   WHERE L.IDLIBRO = :old.IdLibro;
   
   IF (filas > 0) then
     raise noborrar;
   end if; 
     
  EXCEPTION
  WHEN noborrar THEN
    raise_application_error(-20001, 'Estos datos no pueden ser borrados');
    
END no_borrar_almacen;

create or replace
TRIGGER no_borrar_compras
  BEFORE DELETE ON L_COMPRAS
  FOR EACH ROW
DECLARE
  filas INTEGER;
  noborrar EXCEPTION;
BEGIN

  SELECT COUNT(*) 
    INTO filas 
    FROM L_LIBROS L 
   WHERE L.IDLIBRO = :old.IdLibro;
   
   IF (filas > 0) then
     raise noborrar;
   end if; 
     
  EXCEPTION
  WHEN noborrar THEN
    raise_application_error(-20001, 'Estos datos no pueden ser borrados');
    
END no_borrar_compras;

create or replace
TRIGGER no_borrar_ventas
  BEFORE DELETE ON L_VENTAS
  FOR EACH ROW
DECLARE
  filas INTEGER;
  noborrar EXCEPTION;
BEGIN

  SELECT COUNT(*) 
    INTO filas 
    FROM L_LIBROS L 
   WHERE L.IDLIBRO = :old.IdLibro;
   
   IF (filas > 0) then
     raise noborrar;
   end if; 
     
  EXCEPTION
  WHEN noborrar THEN
    raise_application_error(-20001, 'Estos datos no pueden ser borrados');
    
END no_borrar_ventas;




