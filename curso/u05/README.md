# Persistencia de la información en docker

## Uso de volúmenes persistentes

* La información que se guarda en un contenedor no es persistente.
* Los contenedores que implementan aplicaciones Stateful deben guardar los datos en un medio de almacenamiento persistente. Desacoplamos la aplicación de los datos.
* Con docker podemos gestionar volúmenes de datos, que nos permiten guardar la información en el host (almacenamiento persistente).

## Ventajas de guardar los datos en almacenamiento persistente

* Los contenedores son más livianos.
* Puedo tener datos distintos en los distintos entornos de desarrollo.
* Si un contenedor falla, no se pierde información sólo tengo que crear un nuevo contenedor.
* La modificación de los datos de la aplicación no conlleva la construcción de una nueva imagen.

## Ejemplo de almacenamiento persistente

Vamos a crear un contenedor con mysql donde guardamos la información de la base de datos en un volumen persistente:

    $ docker run --name some-mysql -v /opt/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=asdasd -d mysql

Comprobamos que se ha guardado la base de datos en el host:

    /opt/mysql$ ls
    ibdata1  ib_logfile0  ib_logfile1  ibtmp1  #innodb_temp  mysql  mysql.ibd  undo_001  undo_002
  
Creamos una base de datos:

    $ docker exec -it some-mysql bash
    root@75544a024f9b:/# mysql -u root -p -h localhost
    ...
    create database dbtest;
    Query OK, 1 row affected (0.07 sec)
  
Qué pasa si nuestro nuestro contenedor falla!!!

    $ docker container rm -f some-mysql 

Podemos crear otro contenedor y comprobar como sigue existiendo la base de datos:

    $ docker run --name some-mysql2 -v /opt/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=asdasd -d mysql
    
    $ docker exec -it some-mysql2 bash
    root@878f77d80fcf:/# mysql -u root -p -h localhost
    ...
    show databases;
    ...
    | dbtest             |
    ...
  

