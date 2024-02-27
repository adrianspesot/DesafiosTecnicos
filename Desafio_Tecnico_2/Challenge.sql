CREATE TABLE Alumnos (
    alumno_id INT PRIMARY KEY,
    nombre VARCHAR(50),
    fecha_nacimiento DATE,
    direccion VARCHAR(100)
);

CREATE TABLE Materias (
    materia_id INT PRIMARY KEY,
    nombre VARCHAR(50),
    creditos INT
);


CREATE TABLE Inscripciones (
    alumno_id INT,
    materia_id INT,
    fecha_inscripcion DATE,
    PRIMARY KEY (alumno_id, materia_id),
    FOREIGN KEY (alumno_id) REFERENCES Alumnos(alumno_id),
    FOREIGN KEY (materia_id) REFERENCES Materias(materia_id)
);


CREATE TABLE Notas (
    nota_id INT PRIMARY KEY,
    alumno_id INT,
    materia_id INT,
    valor FLOAT,
    fecha_registro DATE,
    FOREIGN KEY (alumno_id) REFERENCES Alumnos(alumno_id),
    FOREIGN KEY (materia_id) REFERENCES Materias(materia_id)
);

drop table Demo;

-- Poblar las tablas

INSERT INTO Alumnos (alumno_id, nombre, fecha_nacimiento, direccion) VALUES
    (1, 'Juan Perez', '1998-05-15', 'Calle 123, Ciudad'),
    (2, 'María García', '1997-08-10', 'Avenida 456, Ciudad'),
    (3, 'Carlos Martínez', '1999-02-20', 'Plaza 789, Ciudad'),
    (4, 'Luisa Rodriguez', '2000-11-05', 'Calle 567, Ciudad'),
    (5, 'Andrés López', '1996-03-22', 'Avenida 890, Ciudad'),
    (6, 'Ana Sánchez', '1998-07-18', 'Plaza 234, Ciudad'),
    (7, 'Diego Torres', '1999-09-30', 'Calle 901, Ciudad'),
    (8, 'Valentina Herrera', '1997-12-08', 'Avenida 123, Ciudad'),
    (9, 'Pedro Gomez', '2001-01-25', 'Plaza 456, Ciudad'),
    (10, 'Martina Fernández', '1996-06-14', 'Calle 678, Ciudad'),
    (11, 'Javier Morales', '1998-04-09', 'Avenida 789, Ciudad'),
    (12, 'Camila Ruiz', '2000-10-02', 'Plaza 345, Ciudad'),
    (13, 'Santiago Diaz', '1999-03-11', 'Calle 012, Ciudad'),
    (14, 'Isabella Jiménez', '1997-09-29', 'Avenida 567, Ciudad'),
    (15, 'Lucas Perez', '1998-08-17', 'Plaza 678, Ciudad'),
    (16, 'Emma Castro', '2001-02-13', 'Calle 234, Ciudad'),
    (17, 'Mateo Vargas', '1996-07-28', 'Avenida 789, Ciudad'),
    (18, 'Mia Morales', '1997-12-01', 'Plaza 890, Ciudad'),
    (19, 'Daniel Herrera', '1999-05-09', 'Calle 123, Ciudad'),
    (20, 'Valeria Aguilar', '2000-06-22', 'Avenida 456, Ciudad'),
    (21, 'Alejandro Gomez', '2001-03-15', 'Plaza 567, Ciudad'),
    (22, 'Laura Rodríguez', '1997-11-18', 'Calle 678, Ciudad'),
    (23, 'Nicolás Fernández', '1998-10-14', 'Avenida 789, Ciudad'),
    (24, 'Sofía Martínez', '1999-09-12', 'Plaza 890, Ciudad'),
    (25, 'Diego Soto', '2000-08-11', 'Calle 123, Ciudad'),
    (26, 'Valentina Torres', '1997-07-09', 'Avenida 234, Ciudad'),
    (27, 'Lucas Pérez', '1998-06-07', 'Plaza 345, Ciudad'),
    (28, 'Martina Gómez', '1999-05-05', 'Calle 456, Ciudad'),
    (29, 'Joaquín Morales', '2001-04-03', 'Avenida 567, Ciudad'),
    (30, 'Luna Rodríguez', '1996-03-01', 'Plaza 678, Ciudad'),
    (31, 'Matías Fernández', '1998-02-27', 'Calle 789, Ciudad'),
    (32, 'Emma Sánchez', '1999-01-25', 'Avenida 890, Ciudad'),
    (33, 'Pedro Vargas', '2000-12-22', 'Plaza 123, Ciudad'),
    (34, 'Valeria Martínez', '1997-11-18', 'Calle 234, Ciudad'),
    (35, 'Nicolás Fernández', '1998-10-14', 'Avenida 345, Ciudad'),
    (36, 'Sofía Pérez', '1999-09-12', 'Plaza 456, Ciudad'),
    (37, 'Diego Gómez', '2000-08-11', 'Calle 567, Ciudad'),
    (38, 'Valentina Torres', '1997-07-09', 'Avenida 678, Ciudad'),
    (39, 'Lucas Rodríguez', '1998-06-07', 'Plaza 789, Ciudad'),
    (40, 'Martina Soto', '1999-05-05', 'Calle 890, Ciudad');




INSERT INTO Materias (materia_id, nombre, creditos) VALUES
    (1, 'Matemáticas', 9),
    (2, 'Historia', 3),
    (3, 'Biología', 5),
    (4, 'Química', 7),
    (5, 'Física', 9);





INSERT INTO Inscripciones (alumno_id, materia_id, fecha_inscripcion) VALUES
    (14, 3, '2020-02-15'),
    (25, 5, '2019-09-22'),
    (6, 2, '2021-07-11'),
    (31, 1, '2018-05-30'),
    (9, 4, '2022-11-03'),
    (19, 3, '2021-03-18'),
    (33, 2, '2020-09-09'),
    (8, 1, '2021-06-05'),
    (22, 5, '2023-01-28'),
    (12, 4, '2019-11-20'),
    (40, 1, '2022-04-17'),
    (2, 3, '2020-08-13'),
    (7, 2, '2022-06-10'),
    (13, 5, '2020-03-25'),
    (18, 4, '2021-01-21'),
    (37, 1, '2023-02-08'),
    (15, 3, '2019-07-02'),
    (36, 2, '2022-02-01'),
    (10, 5, '2021-05-14'),
    (32, 4, '2020-10-07'),
    (26, 1, '2021-08-22'),
    (4, 3, '2022-01-11'),
    (30, 2, '2023-03-05'),
    (27, 1, '2020-12-29'),
    (39, 5, '2019-04-16'),
    (17, 4, '2021-02-09'),
    (21, 3, '2022-05-23'),
    (29, 2, '2021-12-08'),
    (5, 1, '2023-04-07'),
    (23, 5, '2019-01-14'),
    (11, 4, '2020-06-02'),
    (1, 3, '2022-11-19'),
    (35, 2, '2021-09-27'),
    (3, 1, '2020-12-03'),
    (20, 5, '2022-08-30'),
    (38, 4, '2019-03-06'),
    (16, 3, '2021-12-15'),
    (28, 2, '2022-04-01'),
    (24, 1, '2023-06-26'),
    (34, 5, '2020-02-05'),
    (40, 4, '2019-05-12'),
    (9, 1, '2021-01-09');



INSERT INTO Notas (nota_id, alumno_id, materia_id, valor, fecha_registro) VALUES
    (1, 14, 4, 85, '2020-02-15'),
    (2, 25, 5, 92, '2019-09-22'),
    (3, 6, 2, 78, '2021-07-11'),
    (4, 31, 1, 65, '2018-05-30'),
    (5, 9, 4, 74, '2022-11-03'),
    (6, 19, 3, 88, '2021-03-18'),
    (7, 33, 2, 59, '2020-09-09'),
    (8, 8, 1, 70, '2021-06-05'),
    (9, 22, 5, 95, '2023-01-28'),
    (10, 12, 4, 81, '2019-11-20'),
    (11, 40, 1, 45, '2022-04-17'),
    (12, 2, 3, 73, '2020-08-13'),
    (13, 7, 2, 68, '2022-06-10'),
    (14, 13, 5, 88, '2020-03-25'),
    (15, 18, 4, 29, '2021-01-21'),
    (16, 37, 1, 91, '2023-02-08'),
    (17, 15, 3, 56, '2019-07-02'),
    (18, 36, 2, 72, '2022-02-01'),
    (19, 10, 5, 63, '2021-05-14'),
    (20, 32, 4, 17, '2020-10-07'),
    (21, 26, 1, 26, '2021-08-22'),
    (22, 4, 3, 69, '2022-01-11'),
    (23, 30, 2, 58, '2023-03-05'),
    (24, 27, 1, 84, '2020-12-29'),
    (25, 39, 5, 28, '2019-04-16'),
    (26, 17, 4, 77, '2021-02-09'),
    (27, 21, 3, 82, '2022-05-23'),
    (28, 29, 2, 66, '2021-12-08'),
    (29, 5, 1, 90, '2023-04-07'),
    (30, 23, 5, 94, '2019-01-14'),
    (31, 11, 4, 71, '2020-06-02'),
    (32, 1, 3, 83, '2022-11-19'),
    (33, 35, 2, 57, '2021-09-27'),
    (34, 3, 1, 80, '2020-12-03'),
    (35, 20, 5, 96, '2022-08-30'),
    (36, 38, 4, 75, '2019-03-06'),
    (37, 16, 3, 62, '2021-12-15'),
    (38, 28, 2, 89, '2022-04-01'),
    (39, 24, 1, 67, '2023-06-26'),
    (40, 34, 5, 59, '2020-02-05'),
    (41, 40, 4, 64, '2019-05-12'),
    (42, 9, 1, 86, '2021-01-09'),
    (43, 14, 3, 53, '2020-02-15'),
    (44, 25, 2, 14, '2019-09-22'),
    (45, 6, 5, 81, '2021-07-11'),
    (46, 31, 4, 28, '2018-05-30'),
    (47, 19, 1, 67, '2022-11-03'),
    (48, 33, 3, 86, '2021-03-18'),
    (49, 8, 2, 85, '2020-09-09'),
    (50, 22, 1, 92, '2021-06-05'),
    (51, 12, 5, 54, '2023-01-28'),
    (52, 2, 4, 83, '2019-11-20'),
    (53, 7, 3, 63, '2022-04-17'),
    (54, 13, 2, 72, '2020-08-13'),
    (55, 18, 1, 46, '2022-06-10'),
    (56, 37, 5, 61, '2020-03-25'),
    (57, 15, 4, 79, '2021-01-21'),
    (58, 36, 3, 55, '2019-07-02'),
    (59, 10, 2, 13, '2022-02-01'),
    (60, 32, 1, 97, '2023-03-05');





