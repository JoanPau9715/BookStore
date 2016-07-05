-- Alta cliente


create or replace
PROCEDURE ALTA_CLIENTE
( v_Nombre IN VARCHAR2, v_Apellidos IN VARCHAR2,
  v_eMail IN VARCHAR2, v_Nick IN VARCHAR2, v_Clave IN VARCHAR2,
  v_resultado OUT INTEGER)
IS
  id_cliente INTEGER;
  nick_disponible BOOLEAN;
  email_disponible BOOLEAN;
BEGIN

  nick_disponible := (CHECK_AVAIL_NICK(v_nick) = 0);    
  email_disponible := (CHECK_AVAIL_EMAIL(v_email) = 0);

  IF ((nick_disponible = TRUE) AND (email_disponible = TRUE)) 
  THEN

    SELECT secuencia.nextVal INTO id_cliente FROM DUAL;
      
    INSERT INTO L_CLIENTES
      VALUES (id_cliente, InitCap(Lower(v_Nombre)), InitCap(Lower(v_Apellidos)), 
              Lower(v_eMail), InitCap(Lower(v_Nick)), v_Clave, default, default);
                
               
    COMMIT;
    
    v_resultado := id_cliente;
  
  ELSIF (nick_disponible = FALSE) THEN  
    v_resultado := -1;
    
  ELSIF (email_disponible = FALSE) THEN  
    v_resultado := -2;  
    
  END IF;    
  
  EXCEPTION
  WHEN OTHERS THEN 
  BEGIN
    v_resultado := -3;
    ROLLBACK;    
  END;  

END ALTA_CLIENTE;


create or replace
PROCEDURE NUEVO_INTERES_CLIENTE
  (v_IdCLiente IN L_CLIENTES.IdCliente%TYPE, v_DenomInteres IN L_GENEROS.DENOM%TYPE,
   v_TipoAviso IN VARCHAR2)
IS 
  v_IdGenero INTEGER;
BEGIN

  SELECT IDGENERO INTO v_IdGenero 
    FROM L_GENEROS WHERE UPPER(DENOM) = UPPER(v_DenomInteres);

  INSERT INTO L_INFO_NOVEDADES
    VALUES (v_IdCliente, v_IdGenero, v_tipoaviso);
    
  COMMIT;    

END NUEVO_INTERES_CLIENTE;



-- Comprobar login de usuario

create or replace
PROCEDURE COMPROBAR_LOGIN
  (v_Nick IN VARCHAR2, v_Clave IN VARCHAR2, v_Ok OUT INTEGER)
IS 
BEGIN

  SELECT COUNT(*) INTO v_Ok
    FROM L_CLIENTES
   WHERE UPPER(Nick) = UPPER(v_Nick) AND Clave = v_Clave;   

END COMPROBAR_LOGIN;

-- Baja de cliente

create or replace
PROCEDURE BAJA_CLIENTE
( v_NickCliente IN L_CLIENTES.Nick%TYPE)
IS
BEGIN

  UPDATE L_CLIENTES SET Activo = 0
    WHERE UPPER(Nick) = UPPER(v_NickCliente);
    
  COMMIT;

END BAJA_CLIENTE;





















