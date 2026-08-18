# Proyeto final - MySQL - coderhouse


<p align="center">
  <img src="/preview.png" alt="MySQL + Power BI" width="840">
</p>




curso :	MySQL  
institución : CoderHouse [www.coderhouse.com]  
alumno : José Soria Díaz  
comisión : 53185  
docente : Santiago Luis Acosta Rapoani  
entrega : Mayo 2024  
temática : FOTOGRAFIA


---


- [Proyeto final - MySQL - coderhouse](#proyeto-final---mysql---coderhouse)
    - [**Overview**](#overview)
    - [**Introducción**](#introducción)
    - [**Objetivo**](#objetivo)
    - [**Problemática**](#problemática)
    - [**Modelo de negocio**](#modelo-de-negocio)
    - [**Desarrollo**](#desarrollo)





---


### **Overview**

Proyecto final que plasma conocimientos desarrollados durante la cursada de MySQL. Herramientas utilizadas: MySQL, mockaroo, ChatGPT, Excel, PowerBI.



### **Introducción**

Un proyecto comercial web llamado Fotografía se pone en marcha, el proyecto cuenta con varias áreas de desarrollo pero hoy nos enfocaremos en la gestión de su base de datos y un breve análisis de la evolución de alguna temática en particular dentro del proyecto, desde su fundación en inicios del 2023. Éste proyecto se basa en una plataforma Web donde conviven usuarios creadores de imágenes fotográficas y usuarios consumidores (quienes visualizan el contenido con posibilidad de compra de trabajos).



### **Objetivo**

Se desea diseñar un esquema de base de datos a fin de poder gestionar una plataforma web de fotografía. Dicho esquema podrá almacenar información estática por ejemplo datos de contacto, e información dinámica, interacciones con comentarios, órdenes de compra, pagos, etc.  
La base de datos debe permitir la generación y creación de reportería para el análisis de la evolución del proyecto comercial.



### **Problemática**

Poder gestionar un sitio con usuarios de todo el mundo. Aunque inicialmente el modelo de negocios inició con mercado en pocos países de Latam, hoy ya se encuentra disponible en Argentina, Uruguay, Chile, Brasil, Colombia, México y Estados Unidos. En el futuro será abierto a otros diferentes mercados.



### **Modelo de negocio**

Un portal comercial en donde solo los fotógrafos puedan exponer sus trabajos personales y al mismo tiempo pueda unir a fotógrafos y usuarios como compradores de su contenido.  
Los fotógrafos disponen sus fotografías en álbumes. El usuario podrá comprar el contenido del álbum y este estará disponible para su descarga en alta resolución. Al mismo tiempo el usuario podrá ponerse en contacto para consultar y requerir servicio profesional de su fotógrafo preferido para el estilo o proyecto que necesite. El fotógrafo publicará sus álbumes/imágenes que considere según su estilo de preferencia. Los elementos que son puestos a la venta son los álbumes, pudiéndose comprar el álbum con todo su contenido y no así fotografías individuales. La interactividad sí puede establecerse a nivel de fotografía.



### **Desarrollo**

Para ello se diseña un modelo de base de datos transaccional OLTP, estructura y DER, tablas y dependencias entre ellas, vistas, funciones, stored procedures y triggers. Se disponibiliza script de generación de estructura, creación de objetos y carga de datos en sus tablas.

Luego se le dedica un apartado de analítica con la creación de un dashboard de control en PowerBI estableciendo conexión a la base de datos. PBI lee vistas/tablas materializadas para agilizar rendimiento.
En documentación PDF dentro de este repositorio se encontrarán todos los pormenores en la configuración de la herramienta de visualización para establecer la conexión con la base de datos en forma genérica.

El proyecto en PowerBI puede ser utilizado a modo de consulta sin necesidad de vincularlo con una base de datos, hasta el momento que se quiera actualizar el dashboard, donde sin la configuración previa mencionada la herramienta arrojará errores al no encontrar los datos vinculados.


