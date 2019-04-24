# Despliegue de una aplicación con la utilidad de línea de comandos oc

Una vez que nos hemos conectado a nuestro cluster y hemos creado un proyecto, vamos a crear nuestra aplicación. En este caso, volvemos a desplegar la misma aplicación que en el ejemplo anterior, usando **source2image**.

Para ver todos recursos del catálogo que podemos utilizar:

    $ oc new-app --list

Seguimos los mismos pasos, del catálogo elegimos la imagen de php y la versión, para buscar imágenes:

    $ oc new-app --search php

A continuación creamos la nueva aplicación indicando la imagen, el repositorio donde esta el código e indicando un nombre:

    $ oc new-app php:7.1~https://github.com/josedom24/html_for_openshift.git --name prueba

Podemos ver el estado de nuestra aplicación ejecutando:

    $ oc status
    In project miproyecto1 on server https://api.starter-us-west-2.openshift.com:443

    svc/prueba - 172.30.27.139 ports 8080, 8443
      dc/prueba deploys istag/prueba:latest <-
        bc/prueba source builds https://github.com/josedom24/html_for_openshift.git on openshift/php:7.1 
        deployment #1 deployed 37 seconds ago - 1 pod

Como podemos observar se ha creado un **build**:

    $ oc get bc
    NAME      TYPE      FROM      LATEST
    prueba    Source    Git       1

    $ oc describe bc/prueba

Se ha creado un despliegue:

    $ oc get dc
    NAME      REVISION   DESIRED   CURRENT   TRIGGERED BY
    prueba    1          1         1         config,image(prueba:latest)

    $ oc describe dc/prueba

Y podemos ver los pods que se han creado:

    $ oc get pods
    NAME             READY     STATUS      RESTARTS   AGE
    prueba-1-build   0/1       Completed   0          5m
    prueba-1-n6lmz   1/1       Running     0          4m

    $ oc describe pod/prueba-1-n6lmz

Para ver los logs de un build:

    $ oc logs bc/prueba

Para ver los logs de un determinado despliegue:

    $ oc logs dc/prueba

Y, por ejemplo, para ejecutar un comando en un determinado pod:

    $ oc exec prueba-1-n6lmz  -it /bin/bash

También podemos ejecutar el siguiente comando para acceder al pod:

    $ oc rsh prueba-1-n6lmz

## Accediendo a nuestra aplicación

Cuando hemos creado una aplicación se ha creado un servicio:

    $ oc get svc
    NAME      TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)             AGE
    prueba    ClusterIP   172.30.27.139   <none>        8080/TCP,8443/TCP   10m

Pero debemos crear una ruta para poder acceder a dicha aplicación, para ello:

    $ oc expose svc/prueba
    route.route.openshift.io/prueba exposed
    
    $ oc get routes
    NAME      HOST/PORT                                                     PATH      SERVICES   PORT       TERMINATION   WILDCARD
    prueba    prueba-miproyecto1.7e14.starter-us-west-2.openshiftapps.com             prueba     8080-tcp                 None

Y ya podemos acceder a la aplicación usando la URL `prueba-miproyecto1.7e14.starter-us-west-2.openshiftapps.com`.

