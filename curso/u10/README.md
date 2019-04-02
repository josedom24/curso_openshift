# Introducción a OpenShiht

Plataforma de Desarrollo, con características de Cloud Computing (PaaS) desarrollada por Red Hat

* Nos centramos en el desarrollo de la aplicación
* Openshift utiliza internamente Docker y Kubernetes
* Nos permite desplegar aplicaciones en diferentes entornos (desarrollo, producción,...)
* Facilita la integración continúa
* Tenemos varías formas de interactuar con OpenShift: aplicación web, CLI o API REST

## Ventajas de OpenShift v3 para el despliegue de aplicaciones

* Simplifica el ciclo de vida de implantación de nuestras aplicaciones que nos ofrece Docker.
    * El desarrollador sólo se tiene que centrar en el desarrollo de su aplicación.
    * El proyecto se guardará en un repositorio GitHub
    * A la hora de desplegar la aplicación, OpenShift leerá el código fuente del repositorio GitHub
    * E inyectará el código fuente en una imagen base de Docker (diferencias según el lenguaje de programación) creando una nueva imagen de forma automática.
    * [source2image](https://docs.openshift.com/container-platform/3.11/architecture/core_concepts/builds_and_image_streams.html#source-build)

* Nos ofrece todas las ventajas del uso de Kubernetes:
    * Tolerancia a errores
    * Escalabilidad dinámica
    * Actualizaciones continuas
    * Despliegues automáticos
    * Enrutamiento a nuestras aplicaciones
    * Balanceo de carga
    * Volúmenes persistentes
* OpenShift nos ofrece una serie de extras:
    * Gestión más sencilla de proyectos y usuarios
    * Conjunto de imágenes base para distintos lenguajes de programación y bases de datos
    * Asignación automática de nombre para nuestra aplicación (recurso service y ingress controller)
    * Gestión más sencilla de los volúmenes
    * Flujos de CI/CD integradas
    * Herramientas de métrica y monitorización

## Soluciones disponibles de OpenShift

* [OKD (origin)](https://www.okd.io/): La distribución de la comunidad que puedes instalar en tu infraestructura.
* [OpenShift Online](https://www.openshift.com/products/online/): Versión que se ejecuta en el cloud público de Red Hat. Dos planes: Free y Pro.
* [OpenShift Dedicated](https://www.openshift.com/products/dedicated/): te permite disponer de un cluster de Openshift gestionado por Red Hat para que despliegues tus aplicaciones.
* [OpenShift Container Platform](https://www.openshift.com/products/container-platform/): te permite disponer de un cluster de Openshift en tu propia infraestructura gestionado por Red Hat.

## Tecnologías soportadas por OpenShift

[Accede a todas las tecnologías soportadas por OpenShift.](https://www.openshift.com/products/features/technologies/)

