/*
SPESOT ADRIÁN
Resolución de los ejercicios propuestos en el desafío técnico

Quiero mencionar, que al realizar la grabación, cometí el error de no haber hecho mención de generar una tabla nueva de 
ventas, por el hecho de que existen muchos registros duplicados. A su vez, la resolución de los incisos fueron hechos 
con la tabla de ventas entregada. Al final encontrará la creación de una nueva tabla de ventas más limpia, sin duplicados
la que se podría reemplazar en ventas para tener mejores datos.
*/

--1
-- TOP 10 Vendedores según ventas 
--Reconocimiento de tablas
SELECT * FROM ventas;
SELECT * FROM vendedores;


SELECT 
	vdor.nombre, 
    SUM(vtas.unidades) AS Cantidades_Vendidas -- Traigo nombre y sumo las unidades vendidas
FROM 
--Join de tablas de las cuales necesito la info, uso left para que traiga todos los datos de ventas y acople con la de vendedor
	ventas AS vtas LEFT JOIN vendedores AS vdor ON vtas.id_vendedor = vdor.id 
GROUP BY vdor.nombre -- Agrupo porque tengo una funcion de agregación
ORDER BY Cantidades_Vendidas DESC 
LIMIT 10; --Por ultimo le dijo que me traiga los primeros 10 registros de acuerdo al pedido del enunciado


--2
--Por vendedor, exponer la variación en ventas vs el mes anterior.

WITH venta AS ( --Uso with para guardar en memoria la consulta que sigue, con el nombre de venta
SELECT 
	id_vendedor,
    SUM(unidades) AS cant,
	DATE(SUBSTR(periodo,1,4) || '-' ||SUBSTR(periodo,5,6) || '-01') AS FechaActual,
    DATE(DATE(SUBSTR(periodo,1,4) || '-' ||SUBSTR(periodo,5,6) || '-01'), '-1 month') AS FechaAnterior
FROM
	ventas
GROUP BY id_vendedor, periodo -- En el video estába con: DATE(SUBSTR(periodo,1,4) || '-' ||SUBSTR(periodo,5,6) || '-01')
--Pero lo corrijo con periodod ya que no es necesario poner toda la consulta.
)

SELECT -- Utilizo la tabla que guardé en memoria, con with, para realizar la consulta correspondiente
	v1.id_vendedor, v1.FechaActual, v1.cant AS CantActual, v1.FechaAnterior, v2.cant AS cantAnterior,
    IFNULL(v1.cant-v2.cant,'N/A') AS Variacion_,
    IFNULL(CAST(100*v1.cant/v2.cant-100 as STRING)||' %','N/A') AS 'Variacion_%'
FROM 
	venta as v1
LEFT JOIN venta AS v2 ON (v1.id_vendedor= v2.id_vendedor AND v1.FechaAnterior = v2.FechaActual)
;


--3
-- Exponer el id de los vendedores que hayan realizado ventas superiores a 200 perfumes en Córdoba.
SELECT * FROM ventas; -- id_vendedores, suma(unidades)
SELECT * FROM vendedores; -- no utilizar
SELECT * FROM provincias; -- filtrar por Cordoba
SELECT * FROM productos;
SELECT * From categorias; -- Perfumes es id 2

/* Voy a realizar una consulta que contenga id_vendedores, unidades vendidas > 200 que sea de la categoria perfume y sea de Córdobacategorias
Para ello primero busco el id de la categoria correspondiente y el id de la provincia correspondiente*/
-- Busco la id de provincia de cordoba
SELECT id
FROM provincias
WHERE provincia = 'CÓRDOBA';

-- Busco la id de categoría perfumes
SELECT id
FROM categorias
WHERE categoria LIKE '%PERFU%';

-- Query de resultado OPCION 1
SELECT 
	vtas.id_vendedor,
    SUM(vtas.unidades) AS Cantidad_Vendida
FROM 
	ventas AS vtas LEFT JOIN vendedores AS vdor ON vtas.id_vendedor = vdor.id 
WHERE 
	vtas.id_categoria = (SELECT id FROM categorias WHERE categoria LIKE '%PERFU%')
	AND
    vdor.id_provincia = (SELECT id FROM provincias WHERE provincia = 'CÓRDOBA')
GROUP BY id_vendedor
HAVING SUM(unidades)> 200
ORDER BY Cantidad_Vendida DESC;
    
-- Query de resultado OPCION 2 Agregando nombre de categoría y de provincia
SELECT 
	vtas.id_vendedor,
    SUM(vtas.unidades) AS Cantidad_Vendida,
    cat.categoria,
    prov.provincia
FROM 
	ventas AS vtas LEFT JOIN vendedores AS vdor ON vtas.id_vendedor = vdor.id 
    LEFT JOIN categorias AS cat ON vtas.id_categoria = cat.id
    LEFT JOIN provincias AS prov ON vdor.id_provincia = prov.id 
WHERE 
	vtas.id_categoria = (SELECT id FROM categorias WHERE categoria LIKE '%PERFU%')
	AND
    vdor.id_provincia = (SELECT id FROM provincias WHERE provincia = 'CÓRDOBA')
GROUP BY id_vendedor
HAVING SUM(unidades)> 200
ORDER BY Cantidad_Vendida DESC;


--4
/*- Bonus: Programar un Stored Procedure que tome como parámetro un
año e indique las 5 provincias con menor cantidad de ventas para el año
en cuestión*/


CREATE PROCEDURE prov_menos_ventas(@anio INT)
AS
BEGIN
  SELECT 
      SUBSTR(vtas.periodo,1,4) AS Año,
      prov.provincia,
      Sum(vtas.unidades) AS Cantidades_Vendidas
  FROM 
      ventas AS vtas LEFT JOIN vendedores AS vdor ON vtas.id_vendedor = vdor.id 
      LEFT JOIN provincias AS prov ON vdor.id_provincia = prov.id 
  WHERE vtas.periodo LIKE @anio + '%'
  GROUP BY prov.provincia, vtas.periodo
  ORDER BY Sum(vtas.unidades) ASC
  LIMIT 5;
END

EXEC prov_menos_ventas 2022


--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
/*CREAR TABLA VENTAS LIMPIA, SIN REGISTROS DUPLICADOS
Debí hacer la limpieza de datos antes de realizar los ejercicios.
*/

CREATE TABLE ventas_limpia(
	ID_VENTAS INT PRIMARY KEY, --Se puede generar una PK, creo que sería bueno que toda tabla tenga PK
  	periodo INT,
    id_vendedor INT, 
    id_marca INT,
    id_prod INT,
    id_categoria INT,
    unidades INT,
  	tipo_dom VARCHAR(1),
  	FOREIGN KEY(id_vendedor) REFERENCES vendedores(id),
	FOREIGN KEY(id_marca) REFERENCES marcas(id),
  	FOREIGN KEY(id_prod) REFERENCES productos(id),
  	FOREIGN KEY(id_categoria) REFERENCES categorias(id)
)   

/*Ingreso de datos a la nueva tabla Ventas_Limpia*/
INSERT INTO ventas_limpia(
	ID_VENTAS,
  	periodo,
    id_vendedor,
    id_marca,
    id_prod,
    id_categoria,
    unidades,
  	tipo_dom
)    
SELECT DISTINCT periodo || id_vendedor||id_marca||id_prod||id_categoria||unidades||tipo_dom AS ID_VENTAS,
	periodo,
    id_vendedor,
    id_marca,
    id_prod,
    id_categoria,
    unidades,
  	tipo_dom
FROM ventas