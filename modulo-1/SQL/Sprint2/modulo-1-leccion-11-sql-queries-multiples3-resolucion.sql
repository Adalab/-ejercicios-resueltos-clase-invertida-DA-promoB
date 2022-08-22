CREATE SCHEMA `leccion-8-sql` ;

USE `leccion-8-sql`;

CREATE TABLE Clientes
(IDClientes INT NOT NULL AUTO_INCREMENT,
IDProyecto INT NOT NULL ,
Nombre VARCHAR(30) DEFAULT NULL,
Ciudad VARCHAR(30) DEFAULT NULL,
Pais VARCHAR(30) DEFAULT NULL,
PRIMARY KEY (IDClientes)
);

INSERT INTO Clientes
VALUE (1, 1,"HR Analitycs ES","Madrid","España"),
(2,2,"Luxury Brands","Paris","Francia"),
(3,3,"Preservación Bosques ","Lisboa","Portugal"),
(4,4,"Data Inc.","Berlín","Alemania"),
(5,5,"Data Italia","Roma","Italia");

CREATE TABLE Proyectos
(IDProyecto INT NOT NULL REFERENCES Clientes(IDProyecto),
Nombre VARCHAR(30) DEFAULT NULL,
Ciudad VARCHAR(30) DEFAULT NULL,
Pais VARCHAR(30) DEFAULT NULL,
PRIMARY KEY (IDProyecto)
);

INSERT INTO Proyectos
VALUE (1, "Predicción Salarios","Salamanca","España"),
(2,"Agrupaciones Marcas","Brest","Francia"),
(3,"Visualización Bosques","Manteigas","Portugal"),
(4,"Corrección de datos","Berlín","Alemania"),
(5,"Creación de data lake","Nápoles","Italia");

/* EJEMPLO union, muestra las ciudades de ambas tablas, sin repeticion*/
SELECT Pais
FROM Clientes
UNION
SELECT Pais
FROM Proyectos;

/* EJEMPLO UNION ALL, muestra las ciudades de ambas tablas, con repeticion*/
SELECT Pais
FROM Clientes
UNION ALL
SELECT Pais
FROM Proyectos;


/* EJEMPLO UNION con ORDER BY, muestra las ciudades de ambas tablas,
sin repeticion y ordenado alfabeticamente*/

(SELECT Pais
FROM Clientes)
UNION
(SELECT Pais
FROM Proyectos)
ORDER BY Pais;


/* EJEMPLO UNION ALL con LIMIT, muestra las ciudades de ambas tablas,
 con repeticion, limitando los resultados a las 6 primeros registros*/

SELECT Pais
FROM Clientes
UNION ALL
SELECT Pais
FROM Proyectos
ORDER BY Pais
LIMIT 6;


/* EJEMPLO INTERCEPT, muestra aquellas ciudades de ambas tablas cuyos registros son iguales*/
 
SELECT Ciudad
FROM Clientes
WHERE Ciudad IN(
SELECT Ciudad
FROM Proyectos);
 
 
 /* EJEMPLO EXCEPT , devuelve las ciudades de la tabla clientes, que no se encuentran en la tabla proyectos*/
 
 
SELECT Ciudad
FROM Clientes
WHERE Ciudad NOT IN(
SELECT Ciudad
FROM Proyectos);

# EJERCICIOS FINALES

USE tienda;

/* EJERCICIO 1: Selecciona los apellidos que se encuentren en ambas tablas para employees y customers, con alias 'Apellidos'. */
 
 
SELECT last_name AS 'Apellido'
FROM employees
UNION
SELECT contact_last_name AS 'Apellido'
FROM customers;


-- Los apellidos con UNION ALL

SELECT last_name AS 'Apellido'
FROM employees
UNION ALL
SELECT contact_last_name AS 'Apellido'
FROM customers;
 
/* EJERCICIO 2: Selecciona los nombres con alias 'Nombre' y apellidos,
 con alias 'Apellidos' tanto de los clientes como de los empleados de las tablas employees y customers. */
 
SELECT first_name AS 'Nombre' ,last_name AS 'Apellido'
FROM employees
UNION
SELECT contact_first_name AS 'Nombre',contact_last_name AS 'Apellido'
FROM customers;

 
/* EJERCICIO 3: Selecciona todos los nombres con alias 'Nombre' y apellidos,
 con alias 'Apellidos', tanto de los clientes como de los empleados de las tablas employees y customers. */
SELECT first_name AS 'Nombre' ,last_name AS 'Apellido'
FROM employees
UNION ALL
SELECT contact_first_name AS 'Nombre',contact_last_name AS 'Apellido'
FROM customers;
 
/* EJERCICIO 4: Queremos ver ahora que empleados tienen algun contrato asignado con alguno de los clientes existentes.
 Para ello selecciona employeeNumber como 'Número empleado', firstName como 'Nombre Empleado' y lastName como 'Apellido Empleado' */
 
SELECT  employee_number AS 'Número empleado', first_name AS 'Nombre Empleado' , last_name AS 'Apellido Empleado'
FROM employees
WHERE employee_number IN (
SELECT sales_rep_employee_number 
FROM customers);
 
/* EJERCICIO 5: Queremos ver ahora en cuantas ciudades en las cuales tenemos clientes,
 no tambien una oficina de nuestra empresa para ello.
 Selecciona aquellas ciudades como 'Ciudad' y los nombres de las empresas como 'Nombre de la empresa '
 de la tabla customers, sin repeticiones, que no tengan una oficina en dicha ciudad de la tabla offices. */
 
SELECT city AS 'ciudad', customer_name AS 'nombre de la empresa'
FROM customers
WHERE city NOT IN (
SELECT city FROM offices);
 
 SELECT * FROM offices
 LIMIT 10;
 
 
 