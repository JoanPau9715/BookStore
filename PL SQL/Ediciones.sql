select * from l_libros;
select * from l_compras;
select * from l_almacen;

select titulo, fhinsercion from l_libros

select * from l_clientes;
select * from l_generos;
select * from l_info_novedades;

SELECT * FROM LV_CLIENTES_INTERESES

update l_libros set genero = 1 where titulo like 'Nuevo%';

delete from l_generos where denom = 'Astrología';
insert into l_generos values (secuencia.nextval, 'Libros Blancos');
delete from l_libros 
delete from l_almacen;
delete from l_clientes;
commit;

select count(*) from l_clientes where nick = 'bool';

show user;

SELECT * FROM L_ALMACEN



delete from l_libros where idlibro = 941;
commit;

select idautor from l_autores
where Nombre || ' ' || Apellidos = 'Edgar Allan Poe';

select * from l_autores;

update l_autores set idautor = 1000 where nombre = 'Edgar';

delete from l_autores where fechanac = 0;

select secuencia.currval from dual;

select * from l_autores;
delete from l_autores where nombre like 'Pork%';

describe l_autores;

select * from l_generos;

