SELECT * FROM Alumnos;
SELECT * FROM Inscripciones;
SELECT * FROM Materias;
SELECT * FROM Notas;

/*
1. El equipo docente de la asignatura Historia sostiene que hay una gran cantidad de alumnos
promocionados en su materia nacidos desde 1998 en adelante. Se desea obtener su id,
nombre y fecha de nacimiento.
*/
SELECT 
	n.alumno_id,
    a.nombre,
    a.fecha_nacimiento,
    n.valor,
    m.nombre AS Materia
FROM 
	Notas AS n
    LEFT JOIN Materias AS m ON n.materia_id = m.materia_id
    LEFT JOIN Alumnos AS a ON n.alumno_id = a.alumno_id
WHERE 
	valor >=80 AND
    n.materia_id = (SELECT materia_id FROM Materias WHere nombre LIKE '%Historia%') AND
	strftime('%Y',a.fecha_nacimiento) >= '1998'
    
   
    
/*
2. La asignatura de Matemáticas es una de las más exigentes según las encuestas estudiantiles.
Para conocer el estado histórico de los exámenes de fin de curso en esta materia se desea
obtener una tabla que contenga las columnas ‘Desaprobados’, ‘Regulares’, ‘Promocionados’,
‘Total’. Debe contener una sola fila con la cantidad de alumnos correspondiente a cada
columna.
*/

SELECT 
	SUM(CASE WHEN valor < 60 THEN 1 ELSE 0 END) AS Desaprobados,
    SUM(CASE WHEN valor BETWEEN 60 AND 79 THEN 1 ELSE 0 END) AS Regulares,
	SUM(CASE WHEN valor >=80 THEN 1 ELSE 0 END) AS Promocionados,
    COUNT(*) AS Total
FROM 
	Notas AS n
    LEFT JOIN Materias AS m ON n.materia_id = m.materia_id
WHERE 
	n.materia_id = (SELECT materia_id FROM Materias WHere nombre LIKE '%Mat%')



/*
3. A fin de priorizar la asignación de recursos educativos entre las materias, se desea obtener el
listado de id de aquellas materias que tengan más de 5 alumnos inscriptos antes del año
2022.
*/
SELECT i.materia_id, m.nombre AS Materia
FROM Inscripciones i
	LEFT JOIN Materias m ON i.materia_id=m.materia_id
WHERE
	strftime('%Y',fecha_inscripcion) < '2022'
GROUP BY i.materia_id
HAVING COUNT(alumno_id) > 5


/*
4. El equipo directivo de Corebi School desea conocer la variación generacional en los
estudiantes inscritos. Para ello es necesario obtener el listado de la cantidad de alumnos
registrados por cada generación (año de nacimiento) ordenados por año descendentemente.
*/
SELECT 
	strftime('%Y',a.fecha_nacimiento) AS Generacion,
    COUNT(i.alumno_id) AS Cantidad_Alumnos
FROM Inscripciones AS i
	LEFT JOIN Alumnos AS a ON i.alumno_id= a.alumno_id
GROUP BY strftime('%Y',a.fecha_nacimiento)
ORDER BY Generacion DESC;



/*
5. Para obtener la “Beca de investigación en ciencias naturales” es necesario cumplir con 10 o
más créditos en los exámenes del año correspondiente. Para ganar los créditos de una
materia es necesario como mínimo regularizarla. Se desea conocer el nombre y cantidad de
créditos de los alumnos ganadores de la beca en el año 2021.
*/

SELECT 
    a.nombre,
    SUM(CASE WHEN n.valor >=60 THEN m.creditos ELSE 0 END) AS Total_Creditos
FROM 
	Notas AS n
    LEFT JOIN Materias AS m ON n.materia_id = m.materia_id
    LEFT JOIN Alumnos AS a ON n.alumno_id = a.alumno_id
WHERE strftime('%Y',n.fecha_registro) = '2021'
GROUP BY a.nombre, strftime('%Y',n.fecha_registro)
HAVING Total_Creditos >=10
ORDER BY a.nombre