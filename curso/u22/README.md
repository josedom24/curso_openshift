# Despliegue de aplicaciones PHP en OpenShift

Vamos a instalar un CMS PHP que utiliza una base de datos Sqlite. (phpSQLiteCMS). Para ello vamos a utilizar el código de la aplicación que se encuentra en el repositorio: https://github.com/josedom24/phpsqlitecms 

Vamos a seguir los siguientes pasos desde la consola web:

1. Al crear nuestra aplicación, escogemos en el catálogo la opción de imagen PHP.
2. Escogemos la versión de PHP e indicamos el repositorio de nuestra aplicación.
3. Durante el despliegue se van a instalar los módulos que encuentre en el fichero `composer.json`.

## Los contenedores son efímeros

Como hemos comentado los contenedores son efímeros, la información que se guarda en ellos se pierde al eliminar el contenedor, además si tenemos varias replicas de una misma aplicación (varios pods) la información que se guarda en cada una de ellas es independiente. Vamos a comprobarlo:

1. En el directorio `/cms/data` se encuentran las bases de datos de la aplicación.
2. Cuando escalemos nuestra aplicación se va a crear otro pod con la base de datos inicial, en este nuevo pod no tenemos el mismo contenido que el original.
3. Si realizamos un nuevo despliegue los nuevos pods perderán los datos de la base de datos.
4. **Necesitamos volúmenes persistentes**



