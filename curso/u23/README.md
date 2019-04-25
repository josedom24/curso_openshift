# Despliegue de aplicaciones PHP en OpenShift

Vamos a instalar un CMS PHP que utiliza una base de datos Sqlite (**phpSQLiteCMS**). Para ello vamos a utilizar el código de la aplicación que se encuentra en el repositorio: https://github.com/ilosuna/phpsqlitecms

## Despliegue desde la consola web

Vamos a seguir los siguientes pasos desde la consola web:

1. Al crear nuestra aplicación, escogemos en el catálogo la opción de imagen PHP.
2. Escogemos la versión de PHP e indicamos el repositorio de nuestra aplicación.
3. Durante el despliegue se van a instalar los módulos que encuentre en el fichero `composer.json`.
4. El despliegue de la aplicación, creará un build que construirá una imagen con nuestra aplicación, posteriormente creará un deployment, encargado de crear los pods, y finalmente se creará un servicio y una ruta de acceso a la aplicación.

## Despliegue con el cliente de comandos oc

Borramos el proyecto anterior, y creamos uno nuevo. Y a continuación vamos a realizar el despliegue de la aplicación php de nuevo. Para ello ejecutamos:

    $ oc new-app php:7.1~https://github.com/ilosuna/phpsqlitecms --name appphp

Podemos ver el estado de nuestra aplicación ejecutando:

    $ oc status
    In project miproyecto1 on server https://api.starter-us-west-2.openshift.com:443

    svc/appphp - 172.30.244.6 ports 8080, 8443
      dc/appphp deploys istag/appphp:latest <-
        bc/appphp source builds https://github.com/ilosuna/phpsqlitecms on openshift/php:7.1 
        deployment #1 deployed about a minute ago - 1 pod

Para terminar tenemos que crear la ruta de acceso a la aplicación:

    $ oc expose svc/appphp
    route.route.openshift.io/appphp exposed

    $ oc get routes
    NAME      HOST/PORT                                                     PATH        SERVICES   PORT       TERMINATION   WILDCARD
    appphp    appphp-miproyecto1.7e14.starter-us-west-2.openshiftapps.com             appphp     8080-tcp                 None

Y accediendo a la URL podremos ver nuestra aplicación.

## Los contenedores son efímeros

Como hemos comentado los contenedores son efímeros, la información que se guarda en ellos se pierde al eliminar el contenedor, además si tenemos varias replicas de una misma aplicación (varios pods) la información que se guarda en cada una de ellas es independiente. Vamos a comprobarlo:

1. En el directorio `/cms/data` se encuentran las bases de datos de la aplicación.
2. Cuando escalemos nuestra aplicación se va a crear otro pod con la base de datos inicial, en este nuevo pod no tenemos el mismo contenido que el original.
3. Si realizamos un nuevo despliegue los nuevos pods perderán los datos de la base de datos.
4. **Necesitamos volúmenes persistentes**



