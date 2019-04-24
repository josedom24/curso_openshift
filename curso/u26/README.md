# Despliegue de Wordpress en OpenShift

En esta unidad vamos a instalar WordPress, un CMS escrito en PHP, en OpenShift aplicando todos los conocimientos que hemos estudiado en unidades anteriores:

## Creación de la base de datos

Vamos a crear un nuevo proyecto y en ella vamos a crear una aplicación con la base de datos mysql. Para ellos escogemos en el catálogo la imagen de mysql e indicamos las variables para su creación:

![wp1](img/mysql.png)

## Despliegue de WordPress

A continuación vamos a crear una aplicación PHP con el despliegue de WordPress para ello vamos a utilizar el repositorio oficial de la aplicación: `https://github.com/WordPress/WordPress`:

![wp2](img/php.png)

En este momento tenemos instalado WordPress pero sin almacenamiento persistente. Para trabajar con almacenamiento persistente en el próximo paso vamos a crear un volumen, pero antes vamos a cambiar la estrategia de despliegue de la aplicación:

* Por defecto la estrategia es **Rolling**: En este caso se crean los nuevos pods de la nueva versión edl despliegue se comprueban que funcionan y posteriormente se eliminan los pods de la versión anterior.
* Nosotros deseamos que la estrategia sea **Recreate**: En esta situación se eliminan los pods de la versión actual y posteriormente se crean los nuevos pods de la nueva versión. Si vamos a trabajar con volúmenes, necesitamos configurar este tipo de estrategia, ya que la primera nos da errores al intentar conectar el volumen a un nuevo pod cuando sigue conectado al anterior pod.

Para cambiar la estrategia: Elegimos el despliegue de *wordpress* y en el botón **Actions** elegimos la opción **Edit**:

![wp3](img/deploy.png)

## Creación del volumen

A continuación vamos a crear un nuevo volumen:

![wp4](img/volumen.png)

Y lo conectamos al despliegue *wordpress* en el directorio `/opt/app-root/src/wp-content`: Elegimos el despliegue de *wordpress* y en el botón **Actions** elegimos la opción **Add Storage*:

![wp5](img/volumen2.png)

En el momento que hemos añadido el almacenamiento a nuestra aplicación se produce un nuevo despliegue de forma automática que implantará la aplicación con el volumen persistente.

En el directorio `wp-content` de WordPress se guardada todos los datos de la aplicación (documentos que subimos, plugins, temas,...). Por lo tanto es el directorio que necesitamos que este guardado en un volumen persistente.

Pero al montar el volumen en el directorio indicado, hemos perdido su contenido, por lo que vamos a copiarlo desde nuestro ordenador:

* He clonado el repositorio de WordPress en mi ordenador:

        $ git clone https://github.com/WordPress/WordPress
        $ cd WordPress

* Vamos a copiar el contenido de este directorio al volumen, para ello:

        $ oc get pods
        NAME                READY     STATUS      RESTARTS   AGE
        mysql-1-r9vjk       1/1       Running     0          22m
        wordpress-1-build   0/1       Completed   0          20m
        wordpress-2-dsgnr   1/1       Running     0          2m

        $ oc cp wp-content wordpress-2-dsgnr:/opt/app-root/src/

* Comprobamos que hemos copiado los ficheros:

        $ oc exec wordpress-2-dsgnr ls wp-content
        index.php
        plugins
        themes

Podemos concluir que cada vez que hagamos un nuevo despliegue se creara de nuevo el sistema de fichero de los contenedores, a excepción del directorio `wp-content` cuya información esta guardada en el volumen. Seguimos teniendo un problema: el fichero `wp-config.php` donde se guarda la configuración de WordPress se perderá cada vez que hacemos un despliegue. Para solucionarlo, vamos a copiar al volumen persistente dos ficheros:

1. Un fichero `wp-config.php` con la configuración de wordpress con los datos para el acceso a la base de datos:

        $ cp /opt/ficheros
        $ oc cp wp-config.php wordpress-2-dsgnr:/opt/app-root/src/wp-content

2. Un fichero `run.sh` que vamos a ejecutar cada vez que hagamos un nuevo despliegue y va a crear un enlace simbólico al fichero de configuración que tenemos guardado: 

        $ oc cp run.sh wordpress-2-dsgnr:/opt/app-root/src/wp-content
    
    El contenido del fichero `run.sh` es:

        #!/bin/bash
        ln -s /opt/app-root/src/wp-content/wp-config.php /opt/app-root/src/wp-config.php
        exec /usr/libexec/s2i/run
    
    Y tenemos que darle permiso de ejecución:

        $ oc exec wordpress-2-dsgnr chmod +x wp-content/run.sh




    spec:
          containers:
            - command:
                - /opt/app-root/src/wp-content/run
    ...