# Introducción a docker

* Virtualización ligera: aprovechamos mejor el hardware y únicamente necesitamos el sistema de archivos mínimo para que funcionen los servicios.
* Los contenedores son autosuficientes, sólo necesitamos una imagen para crear contenedores.
* Una imagen Docker podríamos entenderla como "un Sistema Operativo con aplicaciones instaladas".
* El proyecto nos ofrece es un repositorio de imágenes: Registry Docker Hub que nos permite gestionar imágenes.
* Un contenedor suele ejecutar un sólo servicio. Una aplicación suele necesitar la ejecución de varios contenedores que trabajan juntos.

## Componentes de Docker

* **Docker Engine**: Es un demonio que corre sobre cualquier distribución de Linux y que expone una API externa para la gestión de imágenes y contenedores.
* **Docker Client**: Es el cliente de línea de comandos (CLI) que nos permite gestionar el Docker Engine. El cliente docker se puede configurar para trabajar con con un Docker Engine local o remoto.
* **Docker Registry**: La finalidad de este componente es almacenar las imágenes generadas por el Docker Engine. Nos permite distribuir nuestras imágenes. Podemos instalar un registro privado, o hacer uso de uno público como Docker Hub.
