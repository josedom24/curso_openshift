# Despliegue de aplicaciones Python en OpenShift

Vamos a desplegar una aplicación python que tenemos guardada en el repositorio: https://github.com/josedom24/python_for_openshift

## Despliegue desde la consola web

Para realizar el despliegue seguimos los siguientes pasos desde la consola web:

1. Al crear nuestra aplicación, escogemos en el catálogo la opción de imagen python.
2. Escogemos la versión de python e indicamos el repositorio de nuestra aplicación.
3. Durante el despliegue se van a instalar los módulos que encuentre en el fichero `requirements.txt`.
4. El contenedor que vamos a crear ejecuta por defecto una aplicación qie se llama `app.py`.

## Despliegue con el cliente de comandos oc

Borramos el proyecto anterior, y creamos uno nuevo. Y a continuación vamos a realizar el despliegue de la aplicación python de nuevo. Lo primero es buscar las imágenes python que tenemos en el catálogo:

    $ oc new-app --search python

A continuación creamos la aplicación:

    $ oc new-app python:3.6~https://github.com/josedom24/python_for_openshift --name app-python

Podemos ver el estado de nuestra aplicación ejecutando:

    $ oc status
    In project miproyecto1 on server https://api.starter-us-west-2.openshift.com:443

    svc/app-python - 172.30.85.230:8080
      dc/app-python deploys istag/app-python:latest <-
        bc/app-python source builds https://github.com/josedom24/python_for_openshift on openshift/python:3.6 
        deployment #1 deployed 16 seconds ago - 1 pod

Para terminar tenemos que crear la ruta de acceso a la aplicación:

    $ oc expose svc/app-python
    route.route.openshift.io/app-python exposed
    
    $ oc get route
    NAME         HOST/PORT                                                         PATH      SERVICES     PORT       TERMINATION   WILDCARD
    app-python   app-python-miproyecto1.7e14.starter-us-west-2.openshiftapps.com             app-python   8080-tcp                 None

Y accediendo a la URL podremos ver nuestra aplicación.