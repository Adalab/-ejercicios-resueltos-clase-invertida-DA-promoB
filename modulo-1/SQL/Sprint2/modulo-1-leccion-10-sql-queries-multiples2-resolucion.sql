CREATE SCHEMA `leccion-7-sql` ;
USE  `leccion-7-sql`;


CREATE TABLE Empleadas
(IDEmpleada INT NOT NULL AUTO_INCREMENT,
Salario FLOAT DEFAULT NULL,
Nombre VARCHAR(30) DEFAULT NULL,
Apellido VARCHAR(30) DEFAULT NULL,
Pais VARCHAR(10) DEFAULT NULL,
PRIMARY KEY (IDEmpleada)
);

INSERT INTO Empleadas
VALUE (1, 2500,"Ana","González","España"),
(2, 4000, "Maria","López", "España"),
(3, 3000, "Lucía","Ramos", "España"),
(5, 1500, "Rocío","García", "Francia");


CREATE TABLE EmpleadasEnProyectos
(IDEmpleada INT NOT NULL REFERENCES Empleadas(IDEmpleada),
IDProyecto INT NOT NULL,
PRIMARY KEY (IDEmpleada,IDProyecto)
);


INSERT INTO EmpleadasEnProyectos
VALUE  (2, 1),
(3, 2),
(4, 2),
(5, 3);


/*LEFT JOIN*/
/*EJEMPLO : Obtener el nombre, apellido y el ID en proyecto de la tablas empleadas y proyectos
, utilizando un LEFT JOIN*/
SELECT Nombre, Apellido, EmpleadasEnProyectos.IDProyecto
FROM Empleadas
LEFT JOIN EmpleadasEnProyectos
ON Empleadas.IDEmpleada = EmpleadasEnProyectos.IDEmpleada;


/*RIGHT JOIN*/
/*EJEMPLO : Obtener el nombre, apellido y el ID en proyecto de la tablas empleadas y proyectos
, utilizando un RIGHT JOIN*/

SELECT Nombre, Apellido, EmpleadasEnProyectos.IDProyecto
FROM Empleadas
RIGHT JOIN EmpleadasEnProyectos
ON Empleadas.IDEmpleada = EmpleadasEnProyectos.IDEmpleada;

/*FULL JOIN*/
/*Ejemplo:** Seleccionamos los nombres y apellidos de todas las empleadas de la tabla Empleada,
 así como los IDProyecto de todos los proyectos de la tabla EmpleadasEnProyectos.
 Si alguna de las empleadas está asignada a un proyecto, se indicará en el resultado*/

SELECT Nombre, Apellido, EmpleadasEnProyectos.IDProyecto
FROM Empleadas
LEFT JOIN EmpleadasEnProyectos
ON Empleadas.IDEmpleada = EmpleadasEnProyectos.IDEmpleada
UNION
SELECT Nombre, Apellido, EmpleadasEnProyectos.IDProyecto
FROM Empleadas
RIGHT JOIN EmpleadasEnProyectos
ON Empleadas.IDEmpleada = EmpleadasEnProyectos.IDEmpleada;



/*SELF JOIN*/
/**EJEMPLO :seleccionar parejas de empleadas del mismo país y visualizar sus salarios, 
lo cual puede resultar útil para encontrar diferencias significativas entre ellos
 e investigar la causa. */
 
SELECT A.Nombre AS Nombre1, A.Apellido AS Apellido1, A.Salario AS Salario1, B.Nombre AS Nombre2, B.Apellido AS Apellido2, B.Salario AS Salario2, A.Pais 
FROM Empleadas A, Empleadas B
WHERE A.IDEmpleada <> B.IDEmpleada
AND A.Pais = B.Pais;

/*EJERCICIOS FINALES*/

USE tienda;


/*EJERCICIO 1
Selecciona el ID, nombre, apellidos de todas las empleadas y el ID de cada cliente asociado a ellas (si es que lo tienen)*/


SELECT employees.employee_number, employees.first_name,  employees.last_name, customers.customer_number
FROM employees
LEFT JOIN customers
ON employees.employee_number = customers.sales_rep_employee_number;

/*EJERCICIO 2
Selecciona el ID de todos los clientes, y el nombre, apellidos de las empleadas que llevan sus pedidos (si es que las hay):*/

SELECT employees.employee_number, employees.first_name,  employees.last_name, customers.customer_number
FROM employees
RIGHT JOIN customers
ON employees.employee_number = customers.sales_rep_employee_number;

/*EJERCICIO 3
Selecciona el ID, nombre, apellidos de las empleadas, para aquellas con más de 8 clientes, usando LEFT JOIN:*/

SELECT employees.employee_number, employees.first_name,  employees.last_name, COUNT( customers.customer_number)
FROM employees
LEFT JOIN customers
ON employees.employee_number = customers.sales_rep_employee_number
GROUP BY employees.employee_number
HAVING COUNT( customers.customer_number)> 8;

/*EJERCICIO 4
Selecciona el ID, nombre, apellidos de las empleadas, para aquellas con más de 8 clientes, usando RIGHT JOIN:*/

SELECT employees.employee_number, employees.first_name,  employees.last_name, COUNT( customers.customer_number)
FROM customers
RIGHT JOIN employees
ON employees.employee_number = customers.sales_rep_employee_number
GROUP BY employees.employee_number
HAVING COUNT( customers.customer_number)> 8;


/*EJERCICIO 5
Selecciona el nombre y apellidos de las empleadas que tienen clientes de más de un país, usando LEFT JOIN:*/
SELECT employees.employee_number, employees.first_name, employees.last_name, COUNT(DISTINCT customers.country) AS PaisesClientes
FROM employees
LEFT JOIN customers
ON employees.employee_number = customers.sales_rep_employee_number
GROUP BY (employees.employee_number)
HAVING COUNT(DISTINCT customers.country)>1;