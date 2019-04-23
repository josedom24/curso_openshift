# Despliegue de aplicaciones Python en OpenShift

Vamos a desplegar una aplicación python que tenemos guardada en el repositorio: https://github.com/josedom24/python_for_openshift

Para realizar el despliegue seguimos los siguientes pasos desde la consola web:

1. Al crear nuestra aplicación, escogemos en el catálogo la opción de imagen python.
2. Escogemos la versión de python e indicamos el repositorio de nuestra aplicación.
3. Durante el despliegue se van a instalar los módulos que encuentre en el fichero `requirements.txt`.
4. El contenedor que vamos a crear ejecuta por defecto una aplicación qie se llama `app.py`.


