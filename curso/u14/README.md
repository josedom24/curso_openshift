# Ejemplo 1: Despliegue de una página HTML estática en OpenShift

* Vamos a crear una aplicación web estática con un servidor web apache2.
* Nuestra página la tenemos en un repositorio de GitHub
* Vamos a crear nuestra aplicación usando **source2image**: al crear la aplicación vamos a escoger una imagen con apache2 y vamos a indicar nuestro repositorio con el código, a partir de esta información se va a crear una imagen docker con apache2 y nuestro código que va a servir para desplegar la aplicación.

## Pasos a seguir

1. Del catalogo elegimos la imagen de php
2. Indicamos un nombre y el repositorio donde tenemos nuestro código
3. Se va a crear un build:
    * Se crea un pod a partir de la imagen de apache2 seleccionada.
    * Se inyecta en ese pod el código del repositorio.
    * Y se crea una nueva imagen con apache2 y nuestra aplicación.
4. A partir de la imagen creada:
    * Se crea un deployment que crear un pod con la aplicación.
    * Se crea un servicio de acceso a la aplicación
    * Y se crea una ruta de acceso.
5. Ya tenemos desplegada nuestra aplicación y podemos acceder a ella.

