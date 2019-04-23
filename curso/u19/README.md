# Introducción a la utilidad de línea de comandos oc

Hasta ahora hemos manejado los recursos de nuestro cluster utilizando la página web de **Openshift Online**, pero también tenemos a nuestra disposición un comando CLI (command line interface) `oc` que podemos usar desde la línea de comandos. 

## Instalación de la utilidad de línea de comandos oc

Podemos bajarnos la última versión del cliente desde la [página de descargas](https://github.com/openshift/origin/releases). Y siguiendo las instrucciones que encontramos en [Get Started with the CLI](https://docs.openshift.com/online/cli_reference/get_started_cli.html) podemos instalar la herramienta en los distintos sistemas operativos.

Por ejemplo para Linux Debian/Ubuntu, descomprimimos el fichero y copiamos el ejecutable `oc` en un directorio que este en el PATH.

## Conectando a nuestra cuenta de OpenShift

Una vez instalado, debemos conectarnos a nuestro cluster. Para ello vamos a utilizar un token de acceso. Lo más sencillo es obtener el token desde la página web eligiendo la opción **Copy Login Command** desde las opciones de tu usuario.

Pegamos en la línea de comando y obtenemos el comando para conectarnos a nuestro cluster:

    oc login https://api.starter-us-west-2.openshift.com --token=xxxxxxxxxxxxxxx.....

Cuando nos conectamos por primera vez se crea un fichero de configuración en `~/.kube/config` con la información de acceso al cluster.

## Creación de un nuevo proyecto

Si accedemos al cluster y no tenemos creado un proyecto tenemos que ejecutar la siguiente instrucción para crear uno:

    oc new-project miproyecto1

Y podemos comprobar el estado del cluster con:

    oc status
    In project miproyecto1 on server https://api.starter-us-west-2.openshift.com:443

    You have no services, deployment configs, or build configs.
    Run 'oc new-app' to create an application.

