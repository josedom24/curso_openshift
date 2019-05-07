# Despliegue de nuestra primera aplicación en OpenShift

* Vamos a crear una aplicación web con un servidor web apache2. Nuestra aplicación tendrá ficheros html y php.
* Nuestra aplicación la tenemos en un repositorio de GitHub (https://github.com/josedom24/html_for_openshift)
* Vamos a crear nuestra aplicación usando **source2image**: al crear la aplicación vamos a escoger una imagen con apache2 y php y vamos a indicar nuestro repositorio con el código, a partir de esta información se va a crear una imagen docker con apache2, php y nuestro código, que va a servir para desplegar la aplicación.

## Pasos a seguir

1. Del catalogo elegimos la imagen de php y elegimos la versión de php con la que vamos a trabajar.
2. Indicamos un nombre y el repositorio donde tenemos nuestro código.
3. Se va a crear un build:
    * Se crea un pod a partir de la imagen de apache2 seleccionada.
    * Se inyecta en ese pod el código del repositorio.
    * Y se crea una nueva imagen con apache2 y nuestra aplicación.
4. A partir de la imagen creada:
    * Se crea un deployment que crear un pod con la aplicación.
    * Se crea un servicio de acceso a la aplicación
    * Y se crea una ruta de acceso.
5. Ya tenemos desplegada nuestra aplicación y podemos acceder a ella.

