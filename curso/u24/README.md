# Despliegue de aplicaciones PHP en OpenShift con almacenamiento persistente

En este ejemplo vamos a utilizar un volumen (almacenamiento persistente) para guardar las bases de datos de la aplicación (que están guardadas en el directorio `/cms/data`). Vamos a continuar trabajando donde lo dejamos en la unidad anterior.

## Estrategia de despliegue

En este momento tenemos instalado phpSQLiteCMS pero sin almacenamiento persistente. Para trabajar con almacenamiento persistente en el próximo paso vamos a crear un volumen, pero antes vamos a cambiar la estrategia de despliegue de la aplicación:

* Por defecto la estrategia es **Rolling**: En este caso se crean los nuevos pods de la nueva versión edl despliegue se comprueban que funcionan y posteriormente se eliminan los pods de la versión anterior.
* Nosotros deseamos que la estrategia sea **Recreate**: En esta situación se eliminan los pods de la versión actual y posteriormente se crean los nuevos pods de la nueva versión. Si vamos a trabajar con volúmenes, necesitamos configurar este tipo de estrategia, ya que la primera nos da errores al intentar conectar el volumen a un nuevo pod cuando sigue conectado al anterior pod.

Para cambiar la estrategia: Elegimos el despliegue de *appphp* y en el botón **Actions** elegimos la opción **Edit**:

![wp3](img/deploy.png)

## Creación del volumen

A continuación vamos a crear un nuevo volumen:

![wp4](img/volumen.png)

Y lo conectamos al despliegue *appphp* en el directorio `/opt/app-root/src/cms/data`: Elegimos el despliegue de *appphp* y en el botón **Actions** elegimos la opción **Add Storage*:

![wp5](img/volumen2.png)

En el momento que hemos añadido el almacenamiento a nuestra aplicación se produce un nuevo despliegue de forma automática que implantará la aplicación con el volumen persistente.

En el directorio `cms/data` de phpSQLiteCMS se guardadan las bases de datos sqltile de la aplicación. Por lo tanto es el directorio que necesitamos que este guardado en un volumen persistente.

Pero al montar el volumen en el directorio indicado, hemos perdido su contenido, por lo que vamos a copiar las bases de datos desde nuestro ordenador:

* He clonado el repositorio de WordPress en mi ordenador:

        $ git clone https://github.com/ilosuna/phpsqlitecms.git
        $ cd phpsqlitecms

* Vamos a copiar el contenido de este directorio al volumen, para ello:

        $ oc get pods
        NAME             READY     STATUS      RESTARTS   AGE
        appphp-1-build   0/1       Completed   0          12m
        appphp-3-tj5jm   1/1       Running     0          1m

        $ oc cp data appphp-3-tj5jm:cms/

* Comprobamos que hemos copiado los ficheros:

        $ oc exec appphp-3-tj5jm ls cms/data
        index.php
        plugins
        themes

Podemos concluir que cada vez que hagamos un nuevo despliegue se creara de nuevo el sistema de fichero de los contenedores, a excepción del directorio `wp-content` cuya información esta guardada en el volumen. 







En este ejemplo vamos a utilizar un volumen (almacenamiento persistente) para guardar las bases de datos de la aplicación. Con esto estamos consiguiendo que la información es compartida por todos los pods de una aplicación. Para ello hay que tener en cuenta:

1. El directorio donde se almacenan las bases de datos es `/cms/data`.
2. Nosotros vamos a crear un volumen persistente y lo vamos a montar en ese directorio.
3. En el primer despliegue que creemos vamos a copiar al volumen persistente las bases de datos inicializadas.
4. Para ello vamos a hacer un fork del repositorio (https://github.com/josedom24/phpsqlitecms) y vamos a guardar en un directorio las bases de datos, para posteriormente poder copiarlas al volumen.






