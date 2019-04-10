# Actualizaciones continúas y Rollback de nuestra aplicación en OpenShift

## Actualizaciones continúas

El ciclo de vida del desarrollo de nuestra aplicación sería el siguiente:

1. Modificamos el código de nuestra aplicación, y guardamos los cambios en el repositorio.
2. Desde openshift realizamos un nuevo build, que construye una nueva imagen con la aplicación modificada.
3. A continuación, de forma **automática**, se realizará un nuevo deployment, que borrará los pods antiguos y creará nuevos desde la nueva versión de la imagen.

## Rollback de nuestra aplicación en OpenShift

En cualquier momento podemos desplegar un deployment anterior, para volver a una versión anterior de nuestra aplicación. 

