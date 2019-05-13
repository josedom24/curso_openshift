# Ciclo de vida de nuestras aplicaciones en docker

## Paso 1:Desarrollo de nuestra aplicación

En este ejemplo vamos a desarrollar una página web que va a ser servida por un servidor web que se ejecutará en un contenedor Docker.

Por lo tanto lo primero que debemos hacer es crear nuestra página web:

    $ cd public_html
    $ echo "<h1>Prueba</h1>" > index.htmL


## Paso 2: Creación de la imagen Docker

Utilizando un fichero `Dockerfile` definimos como vamos a crear nuestra imagen:

* Qué imagen base vamos a utilizar.
* Qué paquetes vamos a instalar
* Donde copiamos nuestro código fuente (página web)
* Indicamos el servicio que va a ejecutar el contenedor (servidor apache)

Un ejemplo de fichero `Dockerfile` podría ser:

    FROM debian
    RUN apt-get update -y && apt-get install -y \
        apache2 \
        && apt-get clean && rm -rf /var/lib/apt/lists/*
    COPY ./public_html /var/www/html/
    ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
  
Podríamos usar una imagen base con apache2 ya instalado y utilizar el siguiente fichero `Dockerfile`:

    FROM httpd:2.4
    COPY ./public_html /usr/local/apache2/htdocs/
  
A continuación creamos nuestra imagen, desde el directorio donde tenemos el `Dockerfile`, ejecutamos:

    $ docker build -t josedom24/aplicacionweb:v1 .
    Sending build context to Docker daemon  3.584kB
    Step 1/4 : FROM debian
     ---> be2868bebaba
    Step 2/4 : RUN apt-get update -y && apt-get install -y apache2 & apt-get clean && rm -rf /var/lib/apt/lists/*
     ...
    Successfully built 518871c9fc0c
    Successfully tagged josedom24/aplicacionweb:v1

Y por último, podemos comprobar que en nuestro entorno local tenemos la imagen que acabamos de crear:

    $ docker image ls
    REPOSITORY                TAG                 IMAGE ID            CREATED             SIZE
    josedom24/aplicacionweb   v1                  b2e0df215145        7 seconds ago       204MB
    debian                    latest              be2868bebaba        10 days ago         101MB
  
## Paso 3: Probamos nuestra aplicación en el entorno de desarrollo

Creamos un contenedor en nuestro entorno de desarrollo:

    $ docker run --name aplweb -d -p 80:80 josedom24/aplicacionweb:v1
    fbdd73529e2bb2d9ee9c6415031513741688e6d38509572251f5b624ed7dc23f
  
    $ docker container ls
    CONTAINER ID        IMAGE                        COMMAND                    CREATED             STATUS              PORTS                NAMES
    fbdd73529e2b        josedom24/aplicacionweb:v1   "/usr/sbin/apache2ct…"   6 seconds ago       Up 5 seconds        0.0.0.0:80->80/tcp   aplweb
  
![1](img/docker1.png)

## Paso 4: Distribuimos nuestra imagen

Vamos a subir nuestra imagen al registro Docker Hub:

    $ docker login
    ...
    $ docker push josedom24/aplicacionweb:v1
    The push refers to repository [docker.io/josedom24/aplicacionweb]
    ac126159496f: Pushed 
    cc15ec5f0c43: Pushed 
    ...
 
Comprobamos que está subida al repositorio:

    $ docker search josedom24/aplicacionweb
    NAME                     DESCRIPTION...
    josedom24/aplicacionweb:v1   
  

## Paso 5:Implantación de la aplicación

En el el entorno de producción, bajamos la imagen de Docker Hub y creamos el contenedor:


    $ docker pull josedom24/aplicacionweb:v1
    v1: Pulling from josedom24/aplicacionweb
    9a029d5ca5bb: Pull complete 
    ...
    $ docker run --name aplweb_prod -d -p 80:80 josedom24/aplicacionweb:v1
  
## Paso 6: Modificación de la aplicación

Al modificar el código de la aplicación tenemos que generar una nueva imagen.

    $ cd public_html
    echo "<h1>Prueba 2</h1>" > index.html
    $ docker build -t josedom24/aplicacionweb:v2 .

Podemos probarla en el entorno de desarrollo, eliminando el contenedor anterior:

    $ doker container rm -f aplweb
    $ docker run --name aplweb2 -d -p 80:80 josedom24/aplicacionweb:v2

![2](img/docker2.png)

Subimos la nueva versión de la aplicación. En el entorno de producción: bajamos la nueva versión, eliminamos el contenedor de la versión antigua y creamos un nuevo contenedor con la nueva imagen:

    $ docker push josedom24/aplicacionweb:v1
    ...
  
En producción:

    $ docker pull josedom24/aplicacionweb:v2
    ...
    $ doker container rm -f aplweb_prod
    $ docker run --name aplweb2_prod -d -p 80:80 josedom24/aplicacionweb:v2

