# Operaciones avanzadas con la utilidad de línea de comandos oc

## Tolerancia a fallos

Si borramos un pods, se va a crear inmediatamente otro para que la aplicación siga funcionando:

    $ oc get pods
    NAME             READY     STATUS      RESTARTS   AGE
    prueba-1-build   0/1       Completed   0          18m
    prueba-1-n6lmz   1/1       Running     0          17m
    
    $ oc delete pod/prueba-1-n6lmz
    pod "prueba-1-n6lmz" deleted
    
    $ oc get pods
    NAME             READY     STATUS      RESTARTS   AGE
    prueba-1-b4s25   1/1       Running     0          10s
    prueba-1-build   0/1       Completed   0          18m

## Escalabilidad

En cualquier momento se puede escalar de forma horizontal (crear más pods en un despliegue o eliminarlos) los pods de un despliegue. En todo momento las peticiones a nuestra aplicación se balancean entre los pods que tengamos ejecutando.

    $ oc scale dc prueba --replicas=3
    deploymentconfig.apps.openshift.io/prueba scaled

    $ oc get pods -o wide
    NAME             READY     STATUS      RESTARTS   AGE       IP               NODE                                          NOMINATED NODE
    prueba-1-b4s25   1/1       Running     0          1m        10.130.22.98     ip-172-31-56-230.us-west-2.compute.internal   <none>
    prueba-1-build   0/1       Completed   0          20m       10.129.115.115   ip-172-31-51-92.us-west-2.compute.internal    <none>
    prueba-1-sghr9   1/1       Running     0          20s       10.128.27.215    ip-172-31-55-160.us-west-2.compute.internal   <none>
    prueba-1-w4b4p   1/1       Running     0          20s       10.129.11.160    ip-172-31-52-89.us-west-2.compute.internal    <none>

Y comprobamos el balanceo de carga:

    for i in `seq 1 100`; do curl http://prueba-miproyecto1.7e14.starter-us-west-2.openshiftapps.com/info.php; done
    Servidor:prueba-1-sghr9
    Servidor:prueba-1-w4b4p
    Servidor:prueba-1-b4s25
    ...

## Actualizaciones continúas

Modificamos el código de nuestra aplicación, y guardamos los cambios en el repositorio. Desde openshift realizamos un nuevo build, que construye una nueva imagen con la aplicación modificada:

    $ oc start-build bc/prueba
    build.build.openshift.io/prueba-2 started

    $ oc get bc
    NAME      TYPE      FROM      LATEST
    prueba    Source    Git       2

A continuación, de forma **automática**, se realizará un nuevo deployment, que borrará los pods antiguos y creará nuevos desde la nueva versión de la imagen:

    $ oc get dc
    NAME      REVISION   DESIRED   CURRENT   TRIGGERED BY
    prueba    2          3         2         config,image(prueba:latest)

## Rollback de nuestra aplicación

Para volver a una versión anterior de nuestra aplicación:

    $ oc rollout undo dc/prueba
    deploymentconfig.apps.openshift.io/prueba rolled back
    
    $ oc get dc
    NAME      REVISION   DESIRED   CURRENT   TRIGGERED BY
    prueba    3          3         1         config

## Autoescalado

Para crear un autoescalado en un despliegue:

    $ oc autoscale dc/prueba --min 1 --max 3 --cpu-percent=20
    horizontalpodautoscaler.autoscaling/prueba autoscaled
        
    $ oc get hpa
    NAME      REFERENCE                 TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
    prueba    DeploymentConfig/prueba   5%/20%    1         3         3          34s
    
    $ oc describe hpa/prueba

