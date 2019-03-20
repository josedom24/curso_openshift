# Desplegando nuestras aplicaciones en contenedores

## Despliegue tradicional de aplicaciones

* Las aplicaciones tradicionalmente se implementan como un sólo conjunto de librerías y archivos de configuración.
* Se implementan en un sistema operativo (en servidores físicos o virtuales) con un conjunto se servicios en ejecución (web, base de datos, ...).
* Desventaja 1: Las actualizaciones del S.O. puede interrumpir la aplicación.
* Desventaja 2: Si en un mismo sistema tenemos varias aplicaciones, las actualizaciones de librerías de una ella puede afectar a otras aplicaciones.
* Posible solución: Sistemas en alta disponibilidad que minimicen el tiempo de parada de una aplicación.

## Los contenedores: Alternativa al despliegue de aplicaciones

Los contenedores son un tipo de partición aislada dentro de un solo sistema operativo. Ofrecen muchos de los mismos beneficios que las máquinas virtuales, como seguridad, almacenamiento y aislamiento de redes, pero requieren muchos menos recursos de hardware y son más rápidos de iniciar y finalizar. También aíslan las librerías y el entorno de tiempo de ejecución (como CPU y almacenamiento) utilizados por una aplicación para minimizar el impacto de una actualización de SO en el SO del host.

### Ventajas de uso de los contenedores

* Aislamiento del entorno.
* Menor tamaño del hardware.
* Implementación rápida.
* Reutilización de componentes.
* Minimización del impacto frente a errores/cambios.

### Desventajas de uso de los contenedores

* Complejidad

## Tipos de contenedores

* **Contenedores de sistemas**: Son similares a las máquinas virtuales, pero distintos contenedores comparten el núcleo del anfitrión. Un ejemplo: **LXC**, que forma parte del núcleo Linux y que nos aporta aislamiento y seguridad usando *cgroups* y *namespaces*.
* **Contenedores de aplicaciones**: Especializados en la ejecución de aplicaciones, normalmente cada contenedor ejecuta un sólo proceso. Estos contenedores contienen todas las librerías necesarias para que esa aplicación pueda funcionar. Ejemplo: **docker**.

## Despliegue de aplicaciones basada microservicios

Los contenedores fomentan el enfoque de desarrollo aplicaciones basada en **microservicios** (us aplicaciones monolíticas), ya que los distintos servicios en que dividimos una aplicación se pueden ejecutar de manera muy sencilla en distintos contenedores.

* **Ventajas**: Cada contenedor ofrece un servicio, son más fáciles de mantener, de escalar, de iniciar, de actualizar,...


