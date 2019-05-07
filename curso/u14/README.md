# Recursos que nos ofrece OpenShift

* **Proyectos**: Permiten a los usuarios organizar y controlar sus aplicaciones.
* **Aplicación**: Nuestra aplicaciónes una aplicación Kubernetes, por los están formada por distintos recursos: deployment, pods, service, routes
* **Builds**: Es el proceso por el que se crea la imagen desde la que se va a crear nuestra aplicación. Tenemos muchas estrategias:
    * Desde una imagen, desde un fichero Dockerfile, ...
    * source2image
    * Pipeline de Jenkins
    * ...
* **Registro de imágenes**: Las imágenes que se crean en los builds se guardan en un registro interno.
* **Routes**: Se asocia automática una ruta (nombre) para acceder a cada aplicación.
* **Catálogo de servicios**: Conjunto de imágenes y plantillas bases. A partir de ellas podemos construir (builds) nuevas imágenes con s2i.
* **Web Console**: Aplicación web que nos permite trabajar con nuestros recursos de OpenShift
* **cli oc**:Herramienta de línea de comandos que nos permite trabajar con nuestros recursos de OpenShift
