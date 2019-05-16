# minishift: Jugando con openshift v3 

[minishitf](https://docs.okd.io/latest/minishift/index.html) es una aplicación que nos ayuda a instalar un cluster de openshift en un único nodo. Por defecto crea una máquina en [virtualbox](https://docs.okd.io/latest/minishift/getting-started/setting-up-virtualization-environment.html#setting-up-kvm-driver) donde realiza la instalación del cluster (de forma muy sencilla también podemos usar [kvm](https://docs.okd.io/latest/minishift/getting-started/setting-up-virtualization-environment.html#setting-up-kvm-driver)).

## Instalación de minishift

Necesitamos un sistema donde tengamos instalado virtualbox (la versión recomendad es la 5.1.12 o superior). A continuación desde la [página de descargas](https://github.com/minishift/minishift/releases) nos bajamos la última versión de minishift y lo descomprimimos.

Para facilitar el trabajo con minishift podemos añadir el directorio que hemos descomprimido en el PATH del sistema ejecutando:

    $ export PATH=$(pwd):$PATH


Ejecutando el comando `minishift` puedes visualizar todos los subcomandos que podemos ejecutar, puedes obtener ayuda para ver como funcionan cada uno de ellos.

## Creando el cluster openshift

La inicialización del cluster crea una nueva máquina en nuestro virtualbox e instala en ella todas las aplicaciones necesarias para que funcione openshift (la versión que se va a instalar el openshift 3.11), la instrucción que tenemos que ejecutar para que se empiece a construir el cluster es la siguiente (el proceso dura algunos minutos):

    $ minishift start --vm-driver virtualbox
    minishift start       
    -- Starting profile 'minishift'
    ...
    OpenShift server started.

    The server is accessible via web console at:
        https://192.168.99.100:8443/console

    You are logged in as:
        User:     developer
        Password: <any value>

    To login as administrator:
        oc login -u system:admin

## Gestionando el cluster openshift

Para detener la máquina virtual que hemos creado:

    $ minishift stop

En cualquier otro momento podemos seguir trabajando con el cluster:

    $ minishift start

Para borrar la máquina virtual:

    $ minishift delete

