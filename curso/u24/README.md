# Despliegue de aplicaciones PHP en OpenShift con almacenamiento persistente

En este ejemplo vamos a utilizar un volumen (almacenamiento persistente) para guardar las bases de datos de la aplicación. Con esto estamos consiguiendo que la información es compartida por todos los pods de una aplicación. Para ello hay que tener en cuenta:

1. El directorio donde se almacenan las bases de datos es `/cms/data`.
2. Nosotros vamos a crear un volumen persistente y lo vamos a montar en ese directorio.
3. En el primer despliegue que creemos vamos a copiar al volumen persistente las bases de datos inicializadas.
4. Para ello vamos a hacer un fork del repositorio (https://github.com/josedom24/phpsqlitecms) y vamos a guardar en un directorio las bases de datos, para posteriormente poder copiarlas al volumen.






